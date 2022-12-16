---
title: CPU访问各个部件的延时时长
date: 2022-07-15 08:24:16
tags:
- latency
categories: 计算机体系架构
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
---

被普遍引用得比较多的数据如下：

``` {.line-numbers}
L1 cache reference 0.5 ns
Branch mispredict 5 ns
L2 cache reference 7 ns
Mutex lock/unlock 100 ns
Main memory reference 100 ns
Compress 1K bytes with Zippy 10,000 ns
Send 2K bytes over 1 Gbps network 20,000 ns
Read 1 MB sequentially from memory 250,000 ns
Round trip within same datacenter 500,000 ns
Disk seek 10,000,000 ns
Read 1 MB sequentially from network 10,000,000 ns
Read 1 MB sequentially from disk 30,000,000 ns
Send packet CA->Netherlands->CA 150,000,000 ns
```

都没有看到L3 cache，而且L2 cache相比L1 cache相差了10倍，这些说明这是比较老的数据了（当时L2 cache还在片外，所以L2 cache才会比L1 cache相差这么大），而在这篇[performance_analysis_guide.pdf](https://www.intel.com/content/dam/develop/external/us/en/documents/performance-analysis-guide-181827.pdf)的文档里有Core i7 Xeon 5500 Series系列CPU的延迟速度如下：

``` {.line-numbers}
L1 CACHE hit, ~4 cycles
L2 CACHE hit, ~10 cycles
L3 CACHE hit, line unshared ~40 cycles
L3 CACHE hit, shared line in another core ~65 cycles
L3 CACHE hit, modified in another core ~75 cycles remote
L3 CACHE ~100-300 cycles
Local Dram ~60 ns
Remote Dram ~100 ns
```


其它部件的数据没有给出来是因为它们的变化不大，因为像内存这样相对不算太慢的部件都基本稳定在100ns左右，其它外设就更不用说了。根据CPU的主频不同，1个cycle代表的时间也不同，在1GHZ主频的CPU下，1个cycle也就是1ns。那么在至强5500的CPU上（按频率2GHZ多一点算，比如Xeon E5506 2.13GHz），L1 CACHE命中的情况下，也就是约2ns。另外几个注释一下：
L3 CACHE hit, line unshared ~40 cycles
命中，且缓存数据没有被共享，约20ns。
L3 CACHE hit, shared line in another core ~65 cycles
命中，但缓存数据被多个核共享，约32ns。
L3 CACHE hit, modified in another core ~75 cycles remote
命中，但缓存数据被另外一个核修改，约37ns。
L3 CACHE ~100-300 cycles
未命中，约50~150ns。
Local Dram ~60 ns
本地内存，约60ns。
Remote Dram ~100 ns
远程内存，约100ns。

因为内存控制器被直接接到了CPU，所以才有本地内存、远程内存（访问需要跨CPU节点）的概念。
了解这些东西有什么用？举个例子，如果要让一个主频为1GHZ的单核CPU做到万兆线速转发，我们可以算出每一个包只能占用：1GHZ/14.88Mpps=67.20ns，而访问一次内存就需要60ns（单核就没有本地内存、远程内存的概念了），所以要做到万兆线速就不能出现cache miss。如果按上面的四核至强Xeon E5506 2.13GHz算，要做到万兆线速，则每个包可以有67*4*2.13=572.58ns，此时也只允许几次cache miss才能做到我们要求的万兆线速。

总之，了解这些东东，在做底层优化的时候就有了理论根据，不用实测也能估计到将来的性能结果会怎么样。

## Reference

- http://stackoverflow.com/questions/4087280/approximate-cost-to-access-various-caches-and-main-memory
- http://www.lenky.info/archives/2012/07/1784 或 http://lenky.info/?p=1784