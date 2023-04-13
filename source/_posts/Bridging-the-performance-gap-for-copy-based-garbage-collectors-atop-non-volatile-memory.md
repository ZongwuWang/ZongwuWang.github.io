---
title: >-
  Bridging the performance gap for copy-based garbage collectors atop
  non-volatile memory
categories:
  - PaperReview
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-12-21 00:18:35
tags:
- GC
- NVM
---

这篇论文为臧斌宇、陈海波老师的ipads实验室发表在EuroSys ’21上的一篇工作，该工作聚焦于使用NVM替换DRAM作为JVM堆区存储中遇到的GC性能急剧下降的挑战，通过性能分析，作者认为G1GC算法存在两个问题：（1）G1GC算法混合读写操作，而NVM中写操作会影响读操作的带宽；（2）G1GC在对象复制时产生很多随机写操作，从而导致G1GC无法得到更好的性能。
作者提出了两个解决问题的角度：（1）将算法分离成多个子阶段，从而防止混合读写操作；（2）降低NVM的写操作次数，以最大化利用NVM带宽。为了实现这个目标，这篇工作提出了两个优化方案：（1）write cache；（2）header map。write cache即在DRAM中缓存需要回收的heap region，在回收结束之前一次性写回到NVM中，header map则是通过hash将不同对象地址映射到优先容量的write cache中。
实验结果表明：G1GC停止时间降低2.69x，应用执行时间提升11%，tail latency降低5.09x。

接下来就以这篇工作的原版presentation PPT展开介绍。

1. NVM相对于DRAM具有容量高、能效高和价格低的优点，可以作为大容量存储的DRAM替代方案。
  ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-00-33-35.png)

2. 托管语言中的应用程序已经对内存资源有了很大的需求，并且JVM中已经支持将堆区直接映射到NVM中。
  ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-00-35-27.png)

3. NVM相比于DRAM存在以下劣势：
   ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-00-38-03.png)

4. 在NVM平台上运行Java应用，发现应用程序性能下降符合NVM和DRAM的带宽差异，但是GC性能更加敏感。
   ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-00-40-26.png)

5. GC基础
   ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-00-42-14.png)
6. 发现一个异常现象：使用NVM平台，运行GC时带宽利用反而下降，这也是GC性能下降的罪魁祸首。
   ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-00-43-41.png)
7. 此外，NVM的带宽还影响GC线程的扩展性。
   ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-00-45-09.png)
8. 其他应用程序呈现相同的现象。
  ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-00-45-49.png) 
9. 进一步分析为什么会发生这种现象。
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-14-20.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-15-04.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-15-55.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-16-42.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-17-08.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-17-36.png)
10. 解决方案：通过在DRAM中缓存更新的NVM区域，最后一次性写回NVM，回收时就只需要写Write Cache。
    ![](Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-20-19.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-21-42.png)
11. 以上方案会导致一个问题：对象转移到write cache中，新的地址为DRAM中的地址，此时如何更新引用该对象的其他对象的引用地址需要换成新的地址，如果使用这个write cache中的地址，在GC完成之后该地址就会失效。因此，在写write cache时就需要确定未来在NVM中的地址。因此，该工作的第二个优化就是通过哈希表建立了write cache和NVM之间的地址映射。
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-27-53.png)
12. 实验结果
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-31-09.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-31-24.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-31-49.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-32-21.png)
    ![](./Bridging-the-performance-gap-for-copy-based-garbage-collectors-atop-non-volatile-memory/2022-12-21-01-32-41.png)