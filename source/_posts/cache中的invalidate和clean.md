---
title: cache中的invalidate和clean
date: 2022-07-12 20:08:50
tags:
- Cache
categories: 计算机体系架构
---

当cache外部的存储器内容发生改变时，需要清除掉相应位置的cache状态。如果cache采用的写策略是write-back时，还需要将cache中的旧数据刷到外部主存。

对于使用了虚拟内存技术的系统，如果MMU修改了页表权限、memory特性或者VA2PA映射关系时也需要对相应的VA cache进行clean或者invalidate。

ARM中通常只使用术语clean和invalidate，有的地方会使用flush(invalidate+clean)，描述进行invalidate和clean两个操作。

## invalidate

invalidate指的是将相应位置的cache line状态置为无效（invalid），这时候并不需要真的清除相应位置的cacheline数据。

在一般的系统中，复位必须清除掉所有cache line的valid状态，不然的话，这个cache的状态位就能够让芯片变成石头，因为复位后的内存访问可能会hit，从而拿到错误的不可预知的数据。如果cache采用了write-back写策略，cacheline可能包含了dirty数据，这个时候直接invalidate这个cache line也是不对的，可能会丢失本应该写入到主存中的数据。

## clean

clean cacheline意味着将dirty状态的cacheline写入主存，同时清除掉cacheline的dirty比特。通过这种方式可以让cacheline中的数据和主存中的数据一致（回想一下，cache的write-back策略带来了哪些优势和问题？）。

Cache invalid可以只针对对应的cache set、way或者对应的地址tag 。

## cache invalidate & clean场景

一个应用cache invalid和clean的典型场景就是DMA。

对于DMA控制器读取的地址空间，需要内核write-back的cache内容对DMA控制器可见，所以需要clean这个cache。

当使用DMA控制器对外部内存写入数据时，为了让这个主存的改动对cache可见，就需要对受影响的cache空间执行invalid。

> 本文转载自：https://zhuanlan.zhihu.com/p/515450647
