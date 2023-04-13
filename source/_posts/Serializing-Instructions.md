---
title: Serializing Instructions
categories:
  - 计算机体系架构
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2023-02-04 21:15:35
tags:
- Serialization
---

本文来源于：[AMD64 Architecture Programmer's Manual, Volume 2](https://www.amd.com/system/files/TechDocs/24593.pdf)

Serializing instructions force the processor to retire the serializing instruction and all previous instructions before the next instruction is fetched. A serializing instruction is retired when the following operations are complete:

- The instruction has executed.
- All registers modified by the instruction are updated.
- All memory updates performed by the instruction are complete.
- All data held in the write buffers have been written to memory.

Serializing instructions can be used as a barrier between memory accesses to force strong ordering of memory operations. Care should be exercised in using serializing instructions because they modify processor state and may affect program flow. The instructions also force execution serialization, which can significantly degrade performance. When strongly-ordered memory accesses are required, but execution serialization is not, it is recommended that software use the memory-ordering instructions described on page 211. 

The following are serializing instructions:

- Non-Privileged Instructions
  - CPUID
  - IRET
  - RSM
  - MFENCE
- Privileged Instructions
  - MOV CRn
  - MOV DRn
  - LGDT, LIDT, LLDT, LTR
  - WRMSR (see note 1)
  - WBINVD, WBNOINVD, INVD
  - INVLPG

Note 1: Writes to the following MSRs are not serializing: SPEC_CTRL, PRED_CMD, all x2APIC MSRs.

A dispatch serializing instruction is a lighter form of ordering than a serializing instruction. A dispatch serializing instruction forces the processor to retire the serializing instruction and all previous instructions before the next instruction is executed. In some systems, LFENCE may be configured to be dispatch serializing. In systems where CPUID Fn8000_0021_EAX[LFenceAlwaysSerializing](bit 2) = 1, LFENCE is always dispatch serializing. 

Serializing instructions in intel cpu refers to: https://xem.github.io/minix86/manual/intel-x86-and-64-manual-vol3/o_fe12b1e2a880e0ce-273.html