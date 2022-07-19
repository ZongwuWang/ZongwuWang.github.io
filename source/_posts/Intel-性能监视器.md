---
title: Intel 性能监视器
date: 2022-07-14 21:42:23
tags:
- Intel
- 性能监视
- PMU
categories: 计算机体系架构
---

全文来自Intel开发者手册：Intel? 64 and IA-32 Architectures Software Developer’s Manual Volume 3B System Programming Guide.pdf

注意：下文中已经指出手册中的对应页面和章节，请对照手册原文看，任何个人理解错误，请包涵。

一，以下内容来自（P279）：30.1 PERFORMANCE MONITORING OVERVIEW

从Pentium奔腾处理器开始，Intel引入了一组计数寄存器用于做系统性能监视（System Performance monitoring）。针对不同型号的CPU处理器，它们各自拥有的性能计数寄存器是不同的，因此，相对ISA标准的普通寄存器而言，这些寄存器被称之为属于PMU中的MSR寄存器。

注解：
- PMU：Performance Monitoring Unit，性能监视单元
- MSR：Model-Specific Register

性能计数器允许用户对选定的处理器参数进行监视和统计，根据这些统计值进行系统调优。从Intel P6开始，性能监视机制得到了进一步的改进和增强，允许用户选择更广泛的事件进行监控。在奔腾4以及至强处理器，又引入了新的性能监视机制和一组新的性能监视事件。

从Intel Core Solo and Intel Core Duo处理器开始，性能监视事件被分为两类：

1. non-architectural performance events（后文简称为特定架构事件、特定架构监视事件）
model-specific，即不同型号的处理器各自所拥有的不同事件。

2. architectural performance events（后文简称为架构兼容事件、架构兼容监视事件）
compatible among processor families，即在不同型号的处理器之间是兼容的事件。因为要提供各个型号处理器之间的兼容，因此这一类事件比较少。

二，以下内容来自（P280）：30.2 ARCHITECTURAL PERFORMANCE MONITORING

如果性能监视事件在不同微架构上的性能保存一致，那么它就是架构兼容事件。架构兼容事件可以在处理器发展过程中逐步增强，也就是可以认为架构兼容事件具有版本更新的概念，即在新型号的处理器上，提供的架构兼容事件可能要比旧型号的处理器要多，同一个架构兼容事件的功能可能也要更强大。通过CPUID.0AH可以获取到当前处理器支持的架构兼容事件版本ID。

三，以下内容来自（P281）：30.2.1 Architectural Performance Monitoring Version 1

通过两组寄存器来实现对架构兼容事件的使用，一组为事件选择寄存器（IA32_PERFEVTSELx），一组为计数寄存器（IA32_PMCx），这两组寄存器是一一对应的，另外，它们的个数也非常有限。

为了保证这两组寄存器在各个架构之间兼容，它们有如下一些约定：

1. 在各个微架构之间，IA32_PERFEVTSELx的bit位布局是一致的。
2. 在各个微架构之间，IA32_PERFEVTSELx的地址是不变的。
3. 在各个微架构之间，IA32_PMCx的地址是不变的。
4. 每一个逻辑处理器拥有它自己的IA32_PERFEVTSELx和IA32_PMCx。也就是说，如果某一个处理器核上有两个逻辑处理器，那么这两个逻辑处理器拥有它各自的IA32_PERFEVTSELx和IA32_PMCx。

四，以下内容来自（P282）：30.2.1.1 Architectural Performance Monitoring Version 1 Facilities

每一个逻辑处理器拥有的MSR寄存器IA32_PERFEVTSELx和IA32_PMCx对数可以通过CPUID.0AH:EAX[15:8]获取。这些MSR寄存器有如下一些特点：

1. IA32_PMCx寄存器的起始地址为0C1H，并且占据一块连续的MSR地址空间。
对应到linux-3.7内核代码为宏：

```c {.line-numbers}
#define MSR_ARCH_PERFMON_PERFCTR0                 0xc1
```

2. IA32_PERFEVTSELx寄存器的起始地址为186H，并且占据一块连续的MSR地址空间。从该地址开始的每一个IA32_PERFEVTSELx寄存器与从0C1H开始的IA32_PMCx寄存器一一对应。
对应到linux-3.7内核代码为宏：

```c {.line-numbers}
#define MSR_ARCH_PERFMON_EVENTSEL0               0x186
```

3. 通过CPUID.0AH:EAX[23:16]可获取IA32_PMCx寄存器的bit位宽。

4. 在各个微架构之间，IA32_PERFEVTSELx的bit位布局是一致的。

IA32_PERFEVTSELx寄存器的bit位布局如下：
0-7：Event select field，事件选择字段
8-15：Unit mask (UMASK) field，事件检测掩码字段
16：USR (user mode) flag，设置仅对用户模式（privilege levels 1, 2 or 3）进行计数，可以和OS flag一起使用。
17：OS (operating system mode) flag，设置仅对内核模式（privilege levels 0）进行计数，可以和USR flag一起使用。
18：E (edge detect) flag
19：PC (pin control) flag，如果设置为1，那么当性能监视事件发生时，逻辑处理器就会增加一个计数并且“toggles the PMi pins”；如果清零，那么当性能计数溢出时，处理器就会“toggles the PMi pins”。“toggles the PMi pins”不好翻译，其具体定义为：“The toggling of a pin is defined as assertion of the pin for a single bus clock followed by deassertion.”，对于此处，我的理解也就是把PMi针脚激活一下，从而触发一个PMI中断。
20：INT (APIC interrupt enable) flag，如果设置为1，当性能计数溢出时，就会通过local APIC来触发逻辑处理器产生一个异常。
21：保留
22：EN (Enable Counters) Flag，如果设置为1，性能计数器生效，否则被禁用。
23：INV (invert) flag，控制是否对Counter mask结果进行反转。
24-31：Counter mask (CMASK) field，如果该字段不为0，那么只有在单个时钟周期内发生的事件数大于等于该值时，对应的计数器才自增1。这就可以用于统计每个时钟周期内发生多次的事件。如果该字段为0，那么计数器就以每时钟周期按具体发生的事件数进行增长。
32-63：保留

对应到linux-3.7内核代码的相关宏为：

```c {.line-numbers}
#define ARCH_PERFMON_EVENTSEL_EVENT         0x000000FFULL
#define ARCH_PERFMON_EVENTSEL_UMASK         0x0000FF00ULL
#define ARCH_PERFMON_EVENTSEL_USR           (1ULL << 16)
#define ARCH_PERFMON_EVENTSEL_OS            (1ULL << 17)
#define ARCH_PERFMON_EVENTSEL_EDGE          (1ULL << 18)
#define ARCH_PERFMON_EVENTSEL_PIN_CONTROL       (1ULL << 19)
#define ARCH_PERFMON_EVENTSEL_INT           (1ULL << 20)
#define ARCH_PERFMON_EVENTSEL_ANY           (1ULL << 21)
#define ARCH_PERFMON_EVENTSEL_ENABLE            (1ULL << 22)
#define ARCH_PERFMON_EVENTSEL_INV           (1ULL << 23)
#define ARCH_PERFMON_EVENTSEL_CMASK         0xFF000000ULL
```

五，以下内容来自（P284）：30.2.2 Additional Architectural Performance Monitoring Extensions

第二个版本的架构兼容监视机制包含如下增强特性：

1. 提供有三个固定功能的性能计数器，IA32_FIXED_CTR0、IA32_FIXED_CTR1和IA32_FIXED_CTR2，每一个固定功能性能计数器一次只能统计一个事件。通过写位于地址38DH的IA32_FIXED_CTR_CTRL寄存器bit位来配置这些固定功能性能计数器，而不再是像通用IA32_PMCx性能计数器那样，通过对应IA32_PERFEVTSELx寄存器来配置。

对应到linux-3.7内核代码的相关宏为：

```c {.line-numbers}
/*
 * All 3 fixed-mode PMCs are configured via this single MSR:
 */
#define MSR_ARCH_PERFMON_FIXED_CTR_CTRL 0x38d
 
/*
 * The counts are available in three separate MSRs:
 */
 
/* Instr_Retired.Any: */
#define MSR_ARCH_PERFMON_FIXED_CTR0 0x309
#define INTEL_PMC_IDX_FIXED_INSTRUCTIONS    (INTEL_PMC_IDX_FIXED + 0)
 
/* CPU_CLK_Unhalted.Core: */
#define MSR_ARCH_PERFMON_FIXED_CTR1 0x30a
#define INTEL_PMC_IDX_FIXED_CPU_CYCLES  (INTEL_PMC_IDX_FIXED + 1)
 
/* CPU_CLK_Unhalted.Ref: */
#define MSR_ARCH_PERFMON_FIXED_CTR2 0x30b
#define INTEL_PMC_IDX_FIXED_REF_CYCLES  (INTEL_PMC_IDX_FIXED + 2)
#define INTEL_PMC_MSK_FIXED_REF_CYCLES  (1ULL << INTEL_PMC_IDX_FIXED_REF_CYCLES)
 
/*
 * We model BTS tracing as another fixed-mode PMC.
 *
 * We choose a value in the middle of the fixed event range, since lower
 * values are used by actual fixed events and higher values are used
 * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
 */
#define INTEL_PMC_IDX_FIXED_BTS             (INTEL_PMC_IDX_FIXED + 16)
```

2. 简化的事件编程，一般的编程操作也就是启用事件计数、禁用事件计数、检测计数溢出，因此提供有三个专门的架构兼容MSR寄存器：

IA32_PERF_GLOBAL_CTRL：允许软件通过一条WRMSR指令实现对所有或任何组合的IA32_FIXED_CTRx或任意IA32_PMCx进行启用或禁用事件计数的操作。
IA32_PERF_GLOBAL_STATUS：允许软件通过一条RDMSR指令实现对任何组合的IA32_FIXED_CTRx或任意IA32_PMCx的溢出状态的查询操作。
IA32_PERF_GLOBAL_OVF_CTRL：允许软件通过一条WRMSR指令实现对任何组合的IA32_FIXED_CTRx或任意IA32_PMCx的溢出状态的清除操作。

对应到linux-3.7内核代码的相关宏为：

```c {.line-numbers}
/* Intel Core-based CPU performance counters */
#define MSR_CORE_PERF_FIXED_CTR0    0x00000309
#define MSR_CORE_PERF_FIXED_CTR1    0x0000030a
#define MSR_CORE_PERF_FIXED_CTR2    0x0000030b
#define MSR_CORE_PERF_FIXED_CTR_CTRL    0x0000038d
#define MSR_CORE_PERF_GLOBAL_STATUS 0x0000038e
#define MSR_CORE_PERF_GLOBAL_CTRL   0x0000038f
#define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x00000390
```

六，以下内容来自（P290）：30.2.3 Pre-defined Architectural Performance Events
表格30-1列出了预先定义好的架构兼容事件

> Table 30-1. UMask and Event Select Encodings for Pre-Defined Architectural Performance Events
> Bit Position CPUID.AH.EBX Event Name UMask Event Select
> 0 UnHalted Core Cycles 00H 3CH
> 1 Instruction Retired 00H C0H
> 2 UnHalted Reference Cycles 01H 3CH
> 3 LLC Reference 4FH 2EH
> 4 LLC Misses 41H 2EH
> 5 Branch Instruction Retired 00H C4H
> 6 Branch Misses Retired 00H C5H

有些处理器可能并不全部支持上表列出的所有预定义架构兼容事件，这可以通过检测CPUID.0AH:EBX对应的bit位来做判断，只有bit位为零，才表示支持对应的事件。

几个事件的注意点：
0. UnHalted Core Cycles — Event select 3CH, Umask 00H
简明：统计处于非停机（UnHalted）状态的时钟周期数。什么是UnHalted状态？比如执行hlt指令时，cpu就处于Halted状态。
只有当指定处理器上的时钟信号处于运行状态时，该事件计数器才统计该处理器的核心时钟周期数。因此在如下几种情况时，计数器不会增长：

> — an ACPI C-state other than C0 for normal operation
— HLT
— STPCLK# pin asserted
— being throttled by TM1
— during the frequency switching phase of a performance state transition (see Chapter 14, “Power and Thermal Management”)

另外，在性能状态发生改变，比如由性能最佳变成节能状态，那么对应的核心时钟频率会发生变化，从而该性能计数器的统计频率也会随之发生变化。

1. Instructions Retired — Event select C0H, Umask 00H
简明：统计已执行完的指令数。Retired表示引退，意译也就是消耗或已执行完。
该事件计数器统计已执行的指令数。如果一条指令由多条微指令组成，那么该事件计数器仅对其最后一条微指令进行统计。如果一条指令以rep为前缀（即意味着指令将执行多次），那么也将作为整体而只被统计一次。如果在多操作指令的最后一条微指令执行完之前出现错误，那么将不会被统计。处于VM-exit条件下时，该事件不会增长。在硬中断，traps陷进以及中断处理函数内时，该计数器都将继续统计。

2. UnHalted Reference Cycles — Event select 3CH, Umask 01H
简明：统计处于非停机（UnHalted）状态的参考时钟周期数。
只有当指定处理器上的时钟信号处于运行状态时，该事件计数器才统计该处理器的参考时钟周期数。这和UnHalted Core Cycles类似，但不同的是，该性能计数器的统计频率不会因核心时钟频率受性能状态发生改变影响而发生变化。

七，下面是与NMI中断相关的部分，属于个人总结

1. Linux内核有一个nmi_watchdog机制，可以用来检测死锁。
这可以参考内核文档：2.6.30.8\Documentation\nmi_watchdog.txt

2. 第1点是旧的nmi_watchdog机制，自2.6.37.x开始，有了新的nmi_watchdog机制。
a) 关于new nmi_watchdog介绍，在这里：new nmi_watchdog using perf events

b) new nmi_watchdog出现在2.6.37.2之后（在内核更新log里搜索关键字“new nmi_watchdog”）：
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?id=5f2b0ba4d94b3ac23cbc4b7f675d98eb677a760a&qt=grep&q=new+nmi_watchdog

> Age Commit message (Expand) Author Files Lines
2010-11-18 x86, nmi_watchdog: Remove the old nmi_watchdog Don Zickus 7 -608/+5
2010-05-12 lockup_detector: Combine nmi_watchdog and softlockup detector Don Zickus 12 -29/+650
2010-02-08 nmi_watchdog: Config option to enable new nmi_watchdog Don Zickus 5 -1/+26
2010-02-08 x86: Move notify_die from nmi.c to traps.c Don Zickus 2 -7/+5

c) 在2.6.37.x内，新旧两套nmi机制同时存在，但old nmi_watchdog机制在2.6.38后被移除：
[x86, nmi_watchdog: Remove the old nmi_watchdog](http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=5f2b0ba4d94b3ac23cbc4b7f675d98eb677a760a)

3. 新的nmi_watchdog机制，其nmi中断源不再可以设置为IO-APIC（即nmi_watchdog=1），而只能是local APIC（即nmi_watchdog=2）。
具体而言是通过：性能计数器溢出（Hardware counter overflow interrupt） –> local APIC（合适配置进行转换） –> NMI
在Intel开发者手册3A第460页（10.1 LOCAL AND I/O APIC OVERVIEW）有对应的说明：

> ? Performance monitoring counter interrupts — P6 family, Pentium 4, and
Intel Xeon processors provide the ability to send an interrupt to its associated
processor when a performance-monitoring counter overflows (see Section
30.8.5.8, “Generating an Interrupt on Overflow”).

以及Intel开发者手册3B第342页（30.8.5.8 Generating an Interrupt on Overflow）的说明：

> (Here, the performance counter entry in the local vector table [LVT] is set
up to deliver the interrupt generated by the PMI to the processor.)

另外可以参考文档：PerfEvent与Intel PMU介绍（林铭 Intel开源技术中心）

4. 新的nmi_watchdog机制的使用：

新的watchdog只需打开内核选项接口（参考文档：lockup-watchdogs.txt，也就是原来的nmi_watchdog.txt）：
Kernel hacking —>
[*] Detect Hard and Soft Lockups
[*] Panic (Reboot) On Hard Lockups
[*] Panic (Reboot) On Soft Lockups

新机制处理了nmi的嵌套问题：http://lwn.net/Articles/484932/
对应的源文件：http://lxr.linux.no/#linux+v3.6.11/arch/x86/kernel/entry_64.S#L1615

5. 新的nmi_watchdog机制的关键性配置语句为：

```c {.line-numbers}
apic_write(APIC_LVTPC, APIC_DM_NMI);
```

其使用的具体性能计数器与当前机器CPU型号有关，在最一般情况下，使用的是：

```c {.line-numbers}
#define MSR_ARCH_PERFMON_PERFCTR0       0xc1
#define MSR_ARCH_PERFMON_EVENTSEL0      0x186
```

事件为：

```c {.line-numbers}
#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL   (0x3c)
#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK     (0x00 << 8)
```

可以看到这是架构兼容事件UnHalted Core Cycles。由于统计的是非停机时钟周期，所以如果系统比较空闲，那么通过“cat /proc/interrupts | grep NMI”看到的nmi中断增长比较缓慢。这是因为当系统空闲时，idle进程默认执行的是mwait_idle()函数，其核心指令mwait导致CPU处于停机状态，所以流逝的时钟周期没有统计到计数器内，进而原本要溢出的计数器没有溢出，nmi中断也就没有触发。

6. 如何让新nmi_watchdog机制下的nmi中断持续触发？

第5点中提到，如果系统比较空闲，那么系统里的nmi中断数会很少。可以有不少方法提升nmi中断频率：
a) 让系统不要处于空闲状态，比如弄个死循环程序一直跑起。（这个仅用于验证的确是因为CPU空闲导致的，囧）
b) 修改内核参数，加上“idle=poll”（可以参考2.6.30.8\Documentation\kernel-parameters.txt），这样让系统的idle进程执行cpu_relax()函数，而该函数的核心是nop指令，因此CPU并不会处于停机状态。（这会导致无法节能，浪费国家电力，囧）
b) 有个名为“CPU_CLK_UNHALTED.TOTAL_CYCLES”的统计事件：
http://software.intel.com/sites/products/documentation/doclib/stdxe/2013/amplifierxe/win/ug_docs/reference/pmm/events/cpu_clk_unhalted.total_cycles.html
Performance Analysis Guide for Intel? Core? i7 Processor and Intel? Xeon? 5500 processors.pdf
这只是CPU_CLK_UNHALTED的变体，pdf里的解释如下：

> Total cycles can be directly measured with CPU_CLK_UNHALTED.TOTAL_CYCLES.
This event is derived from CPU_CLK_UNHALTED.THREAD by setting the cmask = 2
and inv = 1, creating a condition that is always true. The difference between these two is
the halted cycles. These occur when the OS runs the null process.

即创造一个恒真的环境，让计数器的每次统计总是自增。不过根据Intel? VTune手册以及实测来看，这个事件应该仅被某些处理器支持，上面pdf文档就是针对的i7和至强5500系列cpu。libpfm-4.2.0库仅针对Nehalem、Westmere、Sandybridge提供有TOTAL_CYCLES。该事件的具体设置为：
UMask = 0x00;
CMask = 2;
Inv = 1
即：

```c {.line-numbers}
#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK (0x0 | (1 << 23) | (0x2 << 24))
```


参考：
http://blog.csdn.net/gengshenghong/article/details/7383438
http://blog.csdn.net/gengshenghong/article/details/7384862

转载请保留地址：http://www.lenky.info/archives/2013/02/2207 或 http://lenky.info/?p=2207