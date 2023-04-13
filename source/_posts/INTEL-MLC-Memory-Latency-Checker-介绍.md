---
title: INTEL MLC(Memory Latency Checker)介绍
categories:
  - CPU性能分析
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2023-04-05 01:28:19
tags:
- MLC
- Intel
- Memory
- Latency
---

在定位机器性能问题的时候，有时会觉得机器莫名其妙地跑的慢，怎么也看不出来问题。CPU频率也正常，程序热点也没问题，可就是慢。这时候可以检查一下内存的访问速度，看看是不是机器的内存存在什么问题。Intel Memory Latency Checker就是实现这个目标的一大利器。

尤其现在的很多机器都使用了NUMA架构，本节点内和跨节点的内存访问的速度会有差异。另外，内存带宽也有可能成为机器的性能瓶颈。

下载地址：[https://www.intel.com/content/www/us/en/download/736633/intel-memory-latency-checker-intel-mlc.html]

包里有文档，或者看在线版本的：[https://www.intel.com/content/www/us/en/developer/articles/tool/intelr-memory-latency-checker.html]

INTEL MLC可以测量出机器的内存访问延迟和带宽，并且可以观察出它们是如何随着机器负载的增加而变化的。Intel的处理器有一些内存预取功能，可能会影响测试结果，所以在Linux下需要使用root权限来运行mlc。

运行一下mlc，输出如下：

```shell {.line-numbers}
# ./mlc 
Intel(R) Memory Latency Checker - v3.9
Measuring idle latencies (in ns)...
		Numa node
Numa node	     0	     1	
       0	  82.2	 129.6	
       1	 131.1	  81.6
```

这一部分内容表示任意两个Numa node之间的空闲内存访问延迟矩阵，以ns为单位。访问本node的内存延迟是低于访问跨node的内存延迟的。所以观察这个矩阵，它的数值大致关于对角线对称，node 0访问node 1与node 1访问node 0的速度大致相同，可以判断numa节点间的内存访问应该正常。这个功能也是我最常使用的，可以在命令行中使用：

```shell {.line-numbers}
./mlc --latency_matrix
```

以单独执行内存访问延迟矩阵。

```shell {.line-numbers}
Measuring Peak Injection Memory Bandwidths for the system
Bandwidths are in MB/sec (1 MB/sec = 1,000,000 Bytes/sec)
Using all the threads from each core if Hyper-threading is enabled
Using traffic with the following read-write ratios
ALL Reads        :	69143.9	
3:1 Reads-Writes :	61908.4	
2:1 Reads-Writes :	60040.5	
1:1 Reads-Writes :	54517.6	
Stream-triad like:	57473.4	
```

这一部分内容表示不同读写比下的内存带宽。一般来说，内存的写速度是略慢于读速度的。有时候内存会出一些奇奇怪怪的问题，比如读取一切正常，但写的特别慢。这时候观察数据，随着写比例的上升，如果带宽急剧下降，那么有可能出现了这种情况。

```shell {.line-numbers}
Measuring Memory Bandwidths between nodes within system 
Bandwidths are in MB/sec (1 MB/sec = 1,000,000 Bytes/sec)
Using all the threads from each core if Hyper-threading is enabled
Using Read-only traffic type
		Numa node
Numa node	     0	     1	
       0	35216.6	32537.9	
       1	31875.1	35048.5	
```

这一部分内容表示显示内存访问带宽矩阵。单独判断numa节点间内存访问是否正常还可以使用 ：

```shell {.line-numbers}
./mlc --bandwidth_matrix
```

判断方法与延迟矩阵类似，如下列异常数据，node 1访问node 0的带宽与node 0访问node 1的带宽相差较大。出现不平衡的时候一般从内存插法、内存是否故障以及numa平衡等角度进行排查。

```shell {.line-numbers}
异常数据:
Using buffer size of 100.000MB/thread for reads and an additional 100.000MB/thread for writes
Measuring Memory Bandwidths between nodes within system 
Bandwidths are in MB/sec (1 MB/sec = 1,000,000 Bytes/sec)
Using all the threads from each core if Hyper-threading is enabled
Using Read-only traffic type
                Numa node
Numa node             0             1        
       0        51999.2        30097.0        
       1        11091.6        58205.7   
```

```shell {.line-numbers}
Measuring Loaded Latencies for the system
Using all the threads from each core if Hyper-threading is enabled
Using Read-only traffic type
Inject	Latency	Bandwidth
Delay	(ns)	MB/sec
==========================
 00000	523.74	  69057.4
 00002	589.55	  68668.7
 00008	686.99	  68571.4
 00015	549.87	  68873.6
 00050	575.48	  68673.0
 00100	524.74	  68877.5
 00200	197.61	  64225.8
 00300	131.60	  47141.0
 00400	110.39	  36803.0
 00500	117.32	  30135.2
 00700	100.90	  22179.1
 01000	100.93	  15762.8
 01300	 91.74	  12351.6
 01700	 98.61	   9475.2
 02500	 86.66	   6927.8
 03500	 88.13	   5132.6
 05000	 87.68	   3818.6
 09000	 85.36	   2473.5
 20000	 84.83	   1538.7
```

这一部分内容展示了内存访问带宽和内存延迟的之间的关系，全部是读操作。随着机器负载的增加，内存访问带宽增加，内存响应也会相应变慢。根据这里的数据可以判断出内存在负载压力下的响应变化，可以观察是否在达到一定带宽的时候，出现了不可接受的内存响应时间。

除了这些以外，MLC还提供了其他一些功能，可以使用命令参数进行开启，功能包括：

- 测量指定node之间的访问延迟
- 测量CPU cache的访问延迟
- 测量cores/Socket的指定子集内的访问带宽
- 测量不同读写比下的带宽
- 指定随机的访问模式以替换默认的顺序模式进行测量
- 指定测试时的步幅
- 测量CPU cache到CPU cache之间的访问延迟

> 本文转载自：https://zhuanlan.zhihu.com/p/359823092