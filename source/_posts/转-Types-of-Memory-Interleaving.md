---
title: (转)Types of Memory Interleaving
date: 2021-07-30 13:38:47
tags: 
- 计算机体系架构
- Memory
- Interleaving
categories: 计算机体系架构
---

# (转)Types of Memory Interleaving

[Memory Interleaving](https://www.geeksforgeeks.org/memory-interleaving/) is an abstraction technique which divides memory into a number of modules such that successive words in the address space are placed in the different module.

Suppose a 64 MB memory made up of the 4 MB chips as shown in the below:

![](1406-4.png)

We organize the memory into 4 MB banks, each having eight of the 4 MB chips. The memory thus has 16 banks, each of 4 MB.

64 MB memory = $2^{26}$, so 26 bits are used for addressing.
16 = $2^4$, so 4 bits of address select the bank, and 4 MB = $2^{22}$, so 22 bits of address to each chip.

In general, an N-bit address, with $N = L + M$, is broken into two parts:

1. L-bit bank select, used to activate one of the $2^L$ banks of memory, and
2. M-bit address that is sent to each of the memory banks.

When one of the memory banks is active, the other ($2^L – 1$) are inactive. All banks receive the M-bit address, but the inactive one do not respond to it.

**Classification of Memory Interleaving:**
Memory interleaving is classified into two types:

1. **High Order Interleaving –** In high-order interleaving, the most significant bits of the address select the memory chip. The least significant bits are sent as addresses to each chip. One problem is that consecutive addresses tend to be in the same chip. The maximum rate of data transfer is limited by the memory cycle time.

It is also known as Memory Banking.

![](223-1.png)

2. **Low Order Interleaving –** In low-order interleaving, the least significant bits select the memory bank (module). In this, consecutive memory addresses are in different memory modules. This allows memory access at much faster rates than allowed by the cycle time.

![](3164-1.png)

注：转载于https://www.geeksforgeeks.org/types-of-memory-interleaving/