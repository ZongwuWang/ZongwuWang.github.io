---
title: AutoFDO tutorial
categories: 编译器
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-09-29 10:22:54
tags:
- 编译
- gcc
- FDO
- AutoFDO
- feedback-directed optimization
---

For the longest time, compilers have been producing optimised binaries. However, in today's world it can often be daunting to know exactly which optimisations you should choose (more than 80 options with just the basic optimizations), and which of those will really be of benefit to you. In this tutorial, we will examine a simple "hello world" case, and introduce you to some basic optimisations, as well as the new AutoFDO feature of GCC version 5.0.

Lets start with a simple sorting algorithm as example:

{% folding green close, sort.c %}
```c {.line-numbers}
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#define ARRAY_LEN 30000

static struct timeval tm1;

static inline void start() {
    gettimeofday(&tm1, NULL);
}

static inline void stop() {
    struct timeval tm2;
    gettimeofday(&tm2, NULL);
    unsigned long long t = 1000 * (tm2.tv_sec - tm1.tv_sec) +\
                           (tm2.tv_usec - tm1.tv_usec) / 1000;
    printf("%llu ms\n", t);
}

void bubble_sort (int *a, int n) {
    int i, t, s = 1;
    while (s) {
        s = 0;
        for (i = 1; i < n; i++) {
            if (a[i] < a[i - 1]) {
                t = a[i];
                a[i] = a[i - 1];
                a[i - 1] = t;
                s = 1;
            }
        }
    }
}

void sort_array() {
    printf("Bubble sorting array of %d elements\n", ARRAY_LEN);
    int data[ARRAY_LEN], i;
    for(i=0; i<ARRAY_LEN; ++i){
        data[i] = rand();
    }
    bubble_sort(data, ARRAY_LEN);
}

int main(){
    start();
    sort_array();
    stop();
    return 0;
}
```
{% endfolding %}

When we compile and execute this simple code as:

{% folding green open, gcc默认优化运行结果 %}
```shell {.line-numbers}
# gcc sort.c -o sort
# ./sort
Bubble sorting array of 30000 elements
3720 ms
```
{% endfolding %}

We will take this as a the baseline for incoming improvements based on the Options That Control Optimization we enable.

## Basic Optimization Options

These options control various sorts of optimizations(-O1/-O2/-O3). There is an excellent explanation about this on the [GCC Optimize-Options](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html) section. We will use the -O3 option.

- -O3 turns on all optimizations specified by -O2 and also turns on the -finline-functions, -funswitch-loops, -fpredictive-commoning, -fgcse-after-reload, -ftree-loop-vectorize, -ftree-loop-distribute-patterns, -ftree-slp-vectorize, -fvect-cost-model, -ftree-partial-pre and -fipa-cp-clone options.

After applying this flag to our example code:

{% folding green open, gcc O3优化运行结果 %}
```shell {.line-numbers}
# gcc -O3 sort.c -o sort_optimized
#./sort_optimized
Bubble sorting array of 30000 elements
1500 ms
```
{% endfolding %}

We can see that execution time is reduced 59.6%. This is really impressive for just one single optimization flag. Now lets take into consideration that this optimization is just based on the static analysis of the code by itself . There is no input from execution time that can tell us how the code is behaving with the user: which parts are never executed or which one are more worth to be optimized. What if we could have that feedback? Well we can , FDO technology is the one that make this magic.

## Feedback-Directed Optimization (FDO)

Traditional feedback-directed optimization (FDO) in GCC uses static instrumentation to collect edge and value profiles. GCC uses execution profiles consisting of basic block and edge frequency counts to guide optimizations such as instruction scheduling, basic block reordering, function splitting, and register allocation. The current method of feedback-directed optimization in GCC. involves the following steps (Ramasamy, Yuan, Chen & Hundt, 2008):

1. Build an instrumented version of the program for edge and value profiling.
2. Run the instrumented version with representative training data to collect the execution profile. These runs typically incur significant overhead due to the additional instrumentation code that is executed.
3. Build an optimized version of the program by using the collected execution profile to guide the optimizations (FDO build)

The instrumentation and FDO builds are tightly coupled. GCC requires that both builds use the same inline decisions and similar optimization flags to ensure that the control-flow graph (CFG) that is instrumented in the instrumentation build matches the CFG that is annotated with the profile data in the FDO build.

Applying this method to our example:

- Create an instrumented binary with -fprofile-generate:

	```shell {.line-numbers}
	# gcc sort.c -o sort_instrumented -fprofile-generate
	```

- Run the binary in order to generate the profile data file (data file with runtime information)
	```shell {.line-numbers}
	# ./sort_instrumented
	Bubble sorting array of 30000 elements
	3622 ms	
	```

- Re build the source with the profile data as feedback
	```shell {.line-numbers}
	# gcc -O3 sort.c -o sort_fdo -fprofile-use=sort.gcda
	Bubble sorting array of 30000 elements
	1448 ms	
	```

We can see an improvement from just -O3 to FDO ( 1500 -> 1448 ) of 3.46%.1500 experiments with much more complex code show a gain of almost 9%.

This method has shown good application performance gains, but is not commonly used in practice due to the high runtime overhead of profile collection, the tedious dual-compile usage model, and difficulties in generating representative training data set.

## AutoFDO

To overcome the limitations of the current FDO model, it was proposed the use of AutoFDO. AutoFDO is a tool which uses [perf](https://perf.wiki.kernel.org/index.php/Main_Page) to collect sample profiles. A standalone tool is used to convert the perf.data file into gcov format. The source code can be found [here](https://github.com/google/autofdo).

This new model proposed skip the instrumentation step . Instead , uses sampling based profile to drive feedback directed optimizations. There is a good GCC [documentation](https://gcc.gnu.org/wiki/AutoFDO) plus the original article from GCC Developers’ Summit [“Feedback-Directed Optimizations in GCC with Estimated Edge Profiles from Hardware Event Sampling”](http://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CB8QFjAA&url=http://research.google.com/pubs/pub36576.html&ei=0RqLVf6tJYHWoATw86iADA&usg=AFQjCNHX9jFGrZ4Cp2o9yeQfJIBVN6fBSw&sig2=3_OAL4JV8bA_j56zj7Vm7w).

From the functional point of view there are two phases in AutoFDO:

### Phase 1: Generate the profile file

AutoFDO needs a perf.data file that captures the BR_INST_RETIRED:TAKEN event in the processor. This event will vary for every architecture, so we are going to use ocperf, which is part of the pmu-tools project, which wraps all the information required for perf to generate the perf.data correctly for any Intel architecture. The user is free to use this tool or just the perf tool.

```shell {.line-numbers}
# ocperf.py record -b -e br_inst_retired.near_taken:pp -- ./sort
Bubble sorting array of 30000 elements
3731 ms
[ perf record: Woken up 7 times to write data ]
[ perf record: Captured and wrote 1.580 MB perf.data (3902 samples) ]
```

After this a standalone tool is used to convert the perf.data file into gcov format. This tool is create_gcov from autofdo set of tools:

```shell {.line-numbers}
# create_gcov --binary=./sort --profile=perf.data --gcov=sort.gcov -gcov_version=1
```

### Phase 2: Use profile to optimize binary

The following info is read from the profile gcov file ( in our case sort.gcov ) :

- Function names and file names.
- Source level profile, which is a mapping from inline stack to its sample counts.
- Module profile: Module to aux-modules mapping

In order to read the profile file we need to rebuild the source:

```shell {.line-numbers}
# gcc -O3 -fauto-profile=sort.gcov sort.c -o sort_autofdo
```

After this we have the binary sort_autofdo, the which we can run to test:

```shell {.line-numbers}
# ./sort_autofdo
Bubble sorting array of 30000 elements
1447 ms
```

As we can see we have similar results than with FDO, with some advantages:

- Profile collection can occur on production systems. The profiles shall therefore be readily available for FDO builds without the need for any special instrumentation build and run
- The profile data thus collected during the testing and development phase can then be used to build the optimized binary. This is similar to the instrumentation-based FDO model, except that the overhead of profile collection is much lower.
- The traditional FDO model using instrumented runs to collect profile data is not suitable for cases where execution of the instrumented code changes the behavior of time-critical code such as operating system kernel code
- The current instrumentation-based FDO model does not support obtaining execution counts for kernel code

## Bibliography

Ramasamy, V., Yuan, P., Chen, D., & Hundt, R. (2008). Feedback-Directed Optimizations in GCC with Estimated Edge Profiles from Hardware Event Sampling. Proceedings of the GCC Developers’ Summit, 87-102.

> 本文转载自：https://gcc.gnu.org/wiki/AutoFDO/Tutorial