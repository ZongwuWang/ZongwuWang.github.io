---
title: Approximate cost to access various caches and main memory?
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2021-12-23 17:52:14
tags:
- Latency
- CPU
categories: 计算机体系结构
---

关于计算机访问延迟，存在以下几组统计数据：

1. 首先是[colin-scott公布的数据](https://colin-scott.github.io/personal_website/research/interactive_latency.html)，包含了1990年至今的计算机访问延迟
2. 第二组是来自[Stack Overflow的回答](https://stackoverflow.com/questions/4087280/approximate-cost-to-access-various-caches-and-main-memory)，并根据参看连接找到了[原始出处](https://gist.github.com/jboner/2841832)。具体参数如下：
   ```
			0.5 ns - CPU L1 dCACHE reference
			1   ns - speed-of-light (a photon) travel a 1 ft (30.5cm) distance
			5   ns - CPU L1 iCACHE Branch mispredict
			7   ns - CPU L2  CACHE reference
			71   ns - CPU cross-QPI/NUMA best  case on XEON E5-46*
			100   ns - MUTEX lock/unlock
			100   ns - own DDR MEMORY reference
			135   ns - CPU cross-QPI/NUMA best  case on XEON E7-*
			202   ns - CPU cross-QPI/NUMA worst case on XEON E7-*
			325   ns - CPU cross-QPI/NUMA worst case on XEON E5-46*
		10,000   ns - Compress 1K bytes with Zippy PROCESS
		20,000   ns - Send 2K bytes over 1 Gbps NETWORK
		250,000   ns - Read 1 MB sequentially from MEMORY
		500,000   ns - Round trip within a same DataCenter
	10,000,000   ns - DISK seek
	10,000,000   ns - Read 1 MB sequentially from NETWORK
	30,000,000   ns - Read 1 MB sequentially from DISK
	150,000,000   ns - Send a NETWORK packet CA -> Netherlands
	|   |   |   |
	|   |   | ns|
	|   | us|
	| ms|
	```
	[参考图片链接](https://i.stack.imgur.com/a7jWu.png)，防止被墙，显示如下：
	![](./Approximate-cost-to-access-various-caches-and-main-memory/a7jWu.png)


其他相关链接：

- [The Infinite Space Between Words](https://blog.codinghorror.com/the-infinite-space-between-words/)
- [Teach Yourself Programming in Ten Years](http://norvig.com/21-days.html#answers)
- https://www.7-cpu.com/
- https://stackoverflow.com/questions/21369381/measuring-cache-latencies
- https://www.nexthink.com/blog/smarter-cpu-testing-kaby-lake-haswell-memory/
- https://medium.com/applied/applied-c-memory-latency-d05a42fe354e