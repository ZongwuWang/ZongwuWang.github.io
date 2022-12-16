---
title: RDTSC(P)精确测量时间
categories: 挖坑待填
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-09-28 20:46:28
tags:
- 计时
- C++
- RDTSC
- RDTSCP
---
```c++ {.line-numbers}
static inline uint64_t
__rdtsc(void)
{
#if defined(__i386)  // intel 80386 架构
    {
        uint64_t tsc;

		// Based on my knowledge, 80386 is a inOrder CPU, serializing is not required.
        __asm__ volatile("rdtsc" : "=A"(tsc));
        return (tsc);
    }
#elif defined(__amd64) // amd x86_64架构
    {
        uint64_t tsc;

		__asm__ volatile(
			"lfence\n\t"/*serialize*/
			"RDTSC\n\t" /*read the clock*/
			"shl $32, %%rdx\n\t"
			"or %%rdx, %%rax\n\t"
			: "=a" (tsc)
			:
			: "%rcx", "%rdx"
		);
        return tsc;
    }
#elif defined(__aarch64__) // arm 64为架构
    {
        uint64_t t;

        __asm__ volatile("mrs %0,  cntvct_el0" : "=r"(t));
        return (t);
    }
#else
    return (0);
#endif
}

static inline uint64_t
__rdtscp(void)
{
#if defined(__i386)  // intel 80386 架构
    {
        uint64_t tsc;

        __asm__ volatile("rdtsc" : "=A"(tsc));
		printf("Warning: rdtscp not supported in i386\n");
        return (tsc);
    }
#elif defined(__amd64) // amd x86_64架构
    {
        uint64_t tsc;

		__asm__ volatile(
			"rdtscp\n\t" /*read the clock*/
			"shl $32, %%rdx\n\t"
			"or %%rdx, %%rax\n\t"
			: "=a" (tsc)
			:
			: "%rcx", "%rdx"
		);
        return tsc;
    }
#elif defined(__aarch64__) // arm 64为架构
    {
        uint64_t tsc;

        __asm__ volatile("mrs %0,  cntvct_el0" : "=r"(tsc));
		printf("Warning: rdtscp not supported in aarch64\n");
        return (tsc);
    }
#else
    return (0);
#endif
}
```

总结：rdstcp指令在新的架构上出现，该指令为serializing call，不会对其进行乱序，因此可以准确的计算时间。而rdstc不会进行序列化，因此在调用rdstc之前，通过一条cpuid/mfence/lfence指令强制序列化，其中开销cpuid > mfence > lfence，在Linux kernel 5.4之后，AMD和Intel平台上都是用lfence来序列化rdtsc。需要注意的是rdtscp测量的不是core clock cycles，而是reference clock，而core frequence是动态变化的（DVFS），因此当core频率高时，得到的结果小，当core频率低时，得到的结果大。（这个结果是不是也可以用于profile dvfs频率？）

[Difference between rdtscp, rdtsc : memory and cpuid / rdtsc?](https://stackoverflow.com/questions/12631856/difference-between-rdtscp-rdtsc-memory-and-cpuid-rdtsc)中，提问者还提出了另一种序列化的方案，在rdtsc指令的破坏列表中添加"memory"，如下所示：

```c++ {.line-numbers}
__asm__ __volatile__("rdtsc; "          // read of tsc
                     "shl $32,%%rdx; "  // shift higher 32 bits stored in rdx up
                     "or %%rdx,%%rax"   // and or onto rax
                     : "=a"(tsc)        // output to tsc
                     :
                     : "%rcx", "%rdx", "memory"); // rcx and rdx are clobbered
                                                  // memory to prevent reordering
```

但这边有一个误区，编译器能够获取这个clobber list中的memory标记，因此不会对该条指令进行乱序优化。但是最终编译到可执行文件并在CPU上执行时，CPU识别的仅仅是一条rdtsc+shl+or指令，因此不会对其进行序列化。这边很好的展示了编译器和CPU都存在乱序，同时需要通过什么手段分别对编译器和CPU流水线进行序列化。

在[几种取时间的方法（附代码）](http://www.wangkaixuan.tech/?p=840)一文中，作者展示了一种专家版计时方案，即结合rdtscp和lscpu读取cpu频率得到最终时间，但是需要保证CPU频率不变。

为了探究rdtscp的测量精度，设计了以下程序：

```c++ {.line-numbers}
/*************************************************************************
        > File Name: src/main.cpp
        > Author: Wang Zongwu
        > Mail: wangzongwu@outlook.com
        > Created Time: Thu 17 Nov 2022 05:26:04 PM CST
  # Description: measure the lock delay
  ***********************************************************************/


#include <cstddef>
#include <cstdio>
#include<iostream>
#include<thread>
#include <mutex>
#include <unistd.h>

using namespace std;

int main() {
        size_t begin, end;
        for (int i = 0; i < 100; i++) {
                __asm__ __volatile__("rdtscp;"
                                : "=a"(begin)
                                :
                                : "%rcx", "%rdx");
                //__asm__ __volatile__("add $1, %%rax" : );
                //__asm__ __volatile__("movq $100000, %%rcx;" : );
                //__asm__ __volatile__("rep; nop" : : : "%rax");
                __asm__ __volatile__("rdtscp;"
                                : "=a"(end)
                                :
                                : "%rcx", "%rdx");
                printf("CPU cycles for nothing: %ld\n", (end-begin));
        }

        return 0;
}
```

为了减少不必要的指令数，测量时仅选取rax的值。在本机测试时，如果在两条rdtscp指令之间不插入其他任何指令，测试结果为18或20.
如果插入多条"add 1, rax"指令，测试结果会变成20或22，可见测试精度为2 cycles。(由于多发射，add指令较少时会与rdtscp并行，测试结果不会发生变化。)

在测量rdtscp的精度时，打算使用"rep nop"来实现循环nop，但是最终被编译为pause指令，这个在[What does "rep; nop;" mean in x86 assembly? Is it the same as the "pause" instruction?](https://stackoverflow.com/questions/7086220/what-does-rep-nop-mean-in-x86-assembly-is-it-the-same-as-the-pause-instru)中有解释，核心的解释为 =="Prefixes (other than lock) that don't apply to an instruction are ignored in practice by existing CPUs."== 因此"rep nop"在不支持pause指令的cpu上会被解释成nop指令，在支持pause指令的cpu上会被解释为pause指令。pause指令能够实现更高效的spin_lock的上锁效率，具体解释见[What is the purpose of the "PAUSE" instruction in x86?](https://stackoverflow.com/questions/12894078/what-is-the-purpose-of-the-pause-instruction-in-x86)

TODO: 编写代码测试以上结论。

参考：

- [Difference between rdtscp, rdtsc : memory and cpuid / rdtsc?](https://stackoverflow.com/questions/12631856/difference-between-rdtscp-rdtsc-memory-and-cpuid-rdtsc)
- [细说RDTSC的坑](http://www.wangkaixuan.tech/?p=901)
- [几种取时间的方法（附代码）](http://www.wangkaixuan.tech/?p=840)
- [What does "rep; nop;" mean in x86 assembly? Is it the same as the "pause" instruction?](https://stackoverflow.com/questions/7086220/what-does-rep-nop-mean-in-x86-assembly-is-it-the-same-as-the-pause-instru)
- [What is the purpose of the "PAUSE" instruction in x86?](https://stackoverflow.com/questions/12894078/what-is-the-purpose-of-the-pause-instruction-in-x86)
- [Multiple nop instructions do not consistently take longer than a single nop instruction](https://stackoverflow.com/questions/58386042/multiple-nop-instructions-do-not-consistently-take-longer-than-a-single-nop-inst)
