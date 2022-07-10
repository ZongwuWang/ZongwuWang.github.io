---
title: google-profile user guide
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-01-07 17:47:49
tags:
- Profile
- 性能分析
categories: 计算机体系架构
---

# Google profile user guide

## 功能及原理

Google Heap Profiler大致有三类功能：

- 可以分析出在程序的堆内有些什么东西
- 定位出内存泄露
- 可以让我们知道哪些地方分配了比较多的内存

大概的原理就是使用tcmalloc 来代替malloc calloc new等等，这样Google Heap Profiler就能知道内存的分配情况，从而分析出内存问题。

## 安装

```shell
wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.9.1/gperftools-2.9.1.tar.gz
tar -xvf gperftools-2.9.1.tar.gz
cd gperftools-2.9.1
./configure
```

## 使用

1. 建立源文件scr/*
2. 建立Sconstruct编译脚本
3. 建立gprof.sh进行profile
4. 运行："source gprof.sh"

github repository: https://github.com/ZongwuWang/google-profiler.git

## Demo结果

[heap profile result](https://github.com/ZongwuWang/google-profiler/blob/master/build/Debug/out_heapprof.pdf)

[cpu profile result](https://github.com/ZongwuWang/google-profiler/blob/master/build/Debug/out_heapprof.pdf)

从以上结果可以看出不进行malloc的代码不会存在profile中，这是因为原理是heap profile。

<font color=red>这边值得注意的一点是链接顺序会影响编译结果，因此scons中的'--no-as-needed'链接选项必须加上[^1][^2][^3]</font>


[^1]: https://www.cnblogs.com/OCaml/archive/2012/06/18/2554086.html#sec-1-1
[^2]: https://blog.csdn.net/sunny04/article/details/17913949
[^3]: https://www.cnblogs.com/little-ant/p/3398885.html

## gem5中增加profile支持

需要对$GEM5_ROOT/Sconstruct改动如下：

1. 增加option支持
   AddOption('--gprofile', action='store_true',
          help='Build with google gperftools for profiling')
2. 


## linux perf tool

https://performanceengineeringin.wordpress.com/2020/03/15/performance-profiling-with-linux-perf-command-line-tool/#:~:text=How%20to%20set%20up%20perf%20%3F%201%20perf,version%20on%20your%20system.%20...%20More%20items...%20