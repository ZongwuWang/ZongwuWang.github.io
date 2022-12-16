---
title: perf使用手册
categories: CPU性能分析
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-07-16 10:20:35
tags:
- perf
- 性能分析
---

<font size=7 color=Blue>Linux kernel profiling with perf</font>


## 1. 介绍

Perf 是一个用于基于 Linux 2.6+ 的系统的分析器工具，它抽象出 Linux 性能测量中的 CPU 硬件差异，并提供了一个简单的命令行界面。 Perf 基于最新版本的 Linux 内核导出的 perf_events 接口。 本文通过示例运行演示了 perf 工具。 输出是在具有双核 Intel Core2 T7100 CPU 的 HP 6710b 上运行的内核 2.6.38-8-generic 结果的 Ubuntu 11.04 系统上获得的。 为便于阅读，某些输出使用省略号 ([...]) 进行缩写。

### 1.1 命令

perf 工具提供了一组丰富的命令来收集和分析性能和跟踪数据。 命令行用法让人想起 git，因为有一个通用工具 perf，它实现了一组命令：stat、record、report [...]

支持的命令列表：

```shell {.line-numbers}
perf

 usage: perf [--version] [--help] COMMAND [ARGS]

 The most commonly used perf commands are:
  annotate        Read perf.data (created by perf record) and display annotated code
  archive         Create archive with object files with build-ids found in perf.data file
  bench           General framework for benchmark suites
  buildid-cache   Manage <tt>build-id</tt> cache.
  buildid-list    List the buildids in a perf.data file
  diff            Read two perf.data files and display the differential profile
  inject          Filter to augment the events stream with additional information
  kmem            Tool to trace/measure kernel memory(slab) properties
  kvm             Tool to trace/measure kvm guest os
  list            List all symbolic event types
  lock            Analyze lock events
  probe           Define new dynamic tracepoints
  record          Run a command and record its profile into perf.data
  report          Read perf.data (created by perf record) and display the profile
  sched           Tool to trace/measure scheduler properties (latencies)
  script          Read perf.data (created by perf record) and display trace output
  stat            Run a command and gather performance counter statistics
  test            Runs sanity tests.
  timechart       Tool to visualize total system behavior during a workload
  top             System profiling tool.

 See 'perf help COMMAND' for more information on a specific command.
```

某些命令需要内核中的特殊支持并且可能不可用。 要获取每个命令的选项列表，只需键入命令名称后跟 -h：

```shell {.line-numbers}
perf stat -h

 usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
    -i, --no-inherit      child tasks do not inherit counters
    -p, --pid <n>         stat events on existing process id
    -t, --tid <n>         stat events on existing thread id
    -a, --all-cpus        system-wide collection from all CPUs
    -c, --scale           scale/normalize counters
    -v, --verbose         be more verbose (show counter open errors, etc)
    -r, --repeat <n>      repeat command and print average + stddev (max: 100)
    -n, --null            null run - dont start any counters
    -B, --big-num         print large numbers with thousands' separators
```

### 1.2 事件

perf 工具支持可测量事件的列表。 该工具和底层内核接口可以测量来自不同来源的事件。 例如，某些事件是纯内核计数器，在这种情况下它们被称为软件事件。 示例包括：上下文切换、次要故障。

另一个事件来源是处理器本身及其性能监控单元 (PMU)。 它提供了一个事件列表来测量微架构事件，例如周期数、指令退役、L1 缓存未命中等。 这些事件简称为 PMU 硬件事件或硬件事件。 它们因每种处理器类型和型号而异。

perf_events 接口还提供了一小组常见的硬件事件名字对象。 在每个处理器上，这些事件会映射到 CPU 提供的实际事件（如果存在），否则无法使用该事件。 有点令人困惑的是，这些也称为硬件事件和硬件缓存事件。

最后，还有由内核 ftrace 基础设施实现的跟踪点事件。 这些仅适用于 2.6.3x 和更新的内核。

要获取支持的事件列表：

```shell {.line-numbers}
perf list

List of pre-defined events (to be used in -e):

 cpu-cycles OR cycles                       [Hardware event]
 instructions                               [Hardware event]
 cache-references                           [Hardware event]
 cache-misses                               [Hardware event]
 branch-instructions OR branches            [Hardware event]
 branch-misses                              [Hardware event]
 bus-cycles                                 [Hardware event]

 cpu-clock                                  [Software event]
 task-clock                                 [Software event]
 page-faults OR faults                      [Software event]
 minor-faults                               [Software event]
 major-faults                               [Software event]
 context-switches OR cs                     [Software event]
 cpu-migrations OR migrations               [Software event]
 alignment-faults                           [Software event]
 emulation-faults                           [Software event]

 L1-dcache-loads                            [Hardware cache event]
 L1-dcache-load-misses                      [Hardware cache event]
 L1-dcache-stores                           [Hardware cache event]
 L1-dcache-store-misses                     [Hardware cache event]
 L1-dcache-prefetches                       [Hardware cache event]
 L1-dcache-prefetch-misses                  [Hardware cache event]
 L1-icache-loads                            [Hardware cache event]
 L1-icache-load-misses                      [Hardware cache event]
 L1-icache-prefetches                       [Hardware cache event]
 L1-icache-prefetch-misses                  [Hardware cache event]
 LLC-loads                                  [Hardware cache event]
 LLC-load-misses                            [Hardware cache event]
 LLC-stores                                 [Hardware cache event]
 LLC-store-misses                           [Hardware cache event]

 LLC-prefetch-misses                        [Hardware cache event]
 dTLB-loads                                 [Hardware cache event]
 dTLB-load-misses                           [Hardware cache event]
 dTLB-stores                                [Hardware cache event]
 dTLB-store-misses                          [Hardware cache event]
 dTLB-prefetches                            [Hardware cache event]
 dTLB-prefetch-misses                       [Hardware cache event]
 iTLB-loads                                 [Hardware cache event]
 iTLB-load-misses                           [Hardware cache event]
 branch-loads                               [Hardware cache event]
 branch-load-misses                         [Hardware cache event]

 rNNN (see 'perf list --help' on how to encode it) [Raw hardware event descriptor]

 mem:<addr>[:access]                        [Hardware breakpoint]

 kvmmmu:kvm_mmu_pagetable_walk              [Tracepoint event]

 [...]

 sched:sched_stat_runtime                   [Tracepoint event]
 sched:sched_pi_setprio                     [Tracepoint event]
 syscalls:sys_enter_socket                  [Tracepoint event]
 syscalls:sys_exit_socket                   [Tracepoint event]

 [...]
```

一个事件可以有子事件（或单元掩码）。 在某些处理器和某些事件上，可以组合单元掩码并测量任一子事件何时发生。 最后，一个事件可以有修饰符，即改变事件计数的时间或方式的过滤器。

#### 1.2.1 硬件事件

PMU 硬件事件是特定于 CPU 的，并由 CPU 供应商记录。 perf 工具，如果链接到 libpfm4 库，会提供一些事件的简短描述。 有关 Intel 和 AMD 处理器的 PMU 硬件事件列表，请参阅：

- [Intel PMU 事件表：手册附录 A](http://www.intel.com/Assets/PDF/manual/253669.pdf)
- [AMD PMU event table: section 3.14 of manual](http://support.amd.com/us/Processor_TechDocs/31116.pdf)

## 2. 使用 perf stat 计数

对于任何受支持的事件，perf 可以在流程执行期间保持运行计数。 在计数模式中，事件的发生被简单地聚合并在应用程序运行结束时显示在标准输出上。 要生成这些统计信息，请使用 perf 的 stat 命令。 例如：

```shell {.line-numbers}
perf stat -B dd if=/dev/zero of=/dev/null count=1000000

1000000+0 records in
1000000+0 records out
512000000 bytes (512 MB) copied, 0.956217 s, 535 MB/s

 Performance counter stats for 'dd if=/dev/zero of=/dev/null count=1000000':

            5,099 cache-misses             #      0.005 M/sec (scaled from 66.58%)
          235,384 cache-references         #      0.246 M/sec (scaled from 66.56%)
        9,281,660 branch-misses            #      3.858 %     (scaled from 33.50%)
      240,609,766 branches                 #    251.559 M/sec (scaled from 33.66%)
    1,403,561,257 instructions             #      0.679 IPC   (scaled from 50.23%)
    2,066,201,729 cycles                   #   2160.227 M/sec (scaled from 66.67%)
              217 page-faults              #      0.000 M/sec
                3 CPU-migrations           #      0.000 M/sec
               83 context-switches         #      0.000 M/sec
       956.474238 task-clock-msecs         #      0.999 CPUs

       0.957617512  seconds time elapsed

```

如果没有指定事件，perf stat 会收集上面列出的常见事件。 有些是软件事件，例如上下文切换，有些是通用硬件事件，例如周期。 在#符号之后，可以呈现派生度量，例如“IPC”（每个周期的指令）。

### 2.1 控制事件选择的选项

每次运行 perf 工具都可以测量一个或多个事件。 事件使用它们的符号名称指定，后跟可选的单元掩码和修饰符。 事件名称、单位掩码和修饰符不区分大小写。

默认情况下，事件在用户和内核级别进行测量：

```shell {.line-numbers}
perf stat -e cycles dd if=/dev/zero of=/dev/null count=100000
```

要仅在用户级别进行测量，则需要传递一个修饰符：

```shell {.line-numbers}
perf stat -e cycles:u dd if=/dev/zero of=/dev/null count=100000
```

测量用户和内核（显式）：

```shell {.line-numbers}
perf stat -e cycles:uk dd if=/dev/zero of=/dev/null count=100000
```

#### 2.1.1 修饰符

事件可以通过附加冒号和一个或多个修饰符来选择具有修饰符。 修饰符允许用户限制计算事件的时间。

要测量 PMU 事件并传递修饰符：

```shell {.line-numbers}
perf stat -e instructions:u dd if=/dev/zero of=/dev/null count=100000
```

在此示例中，我们正在测量用户级别的指令数量。 请注意，对于实际事件，修饰符取决于底层 PMU 模型。 所有修饰符都可以随意组合。 这是一个简单的表格，总结了 Intel 和 AMD x86 处理器最常见的修饰符。

| Modifiers 	|                        Description                        	| Example 	|
|:---------:	|:---------------------------------------------------------:	|:-------:	|
| u         	| monitor at priv level 3, 2, 1 (user)                      	| event:u 	|
| k         	| monitor at priv level 0 (kernel)                          	| event:k 	|
| h         	| monitor hypervisor events on a virtualization environment 	| event:h 	|
| H         	| monitor host machine on a virtualization environment      	| event:H 	|
| G         	| monitor guest machine on a virtualization environment     	| event:G 	|

上面的所有修饰符都被视为布尔值（标志）。

#### 2.1.2 硬件事件

要测量硬件供应商文档提供的实际 PMU，请传递十六进制参数代码：

```shell {.line-numbers}
perf stat -e r1a8 -a sleep 1

Performance counter stats for 'sleep 1':

            210,140 raw 0x1a8
       1.001213705  seconds time elapsed
```

#### 2.1.3 多个事件

要测量多个事件，只需提供一个逗号分隔的不带空格的列表：

```shell {.line-numbers}
perf stat -e cycles,instructions,cache-misses [...]
```

可以提供的事件数量没有理论上的限制。 如果事件多于实际硬件计数器，内核将自动多路复用它们。 软件事件的数量没有限制。 可以同时测量来自不同来源的事件。

然而，假设每个事件和每个线程（每个线程模式）或每个cpu（系统范围）使用一个文件描述符，则有可能达到内核施加的每个进程打开文件描述符的最大数量。在这种情况下，perf将报告错误。有关此问题的帮助，请参阅故障排除部分。

#### 2.1.4 多路复用和缩放事件

如果事件多于计数器，内核使用时间复用（开关频率 = HZ，一般为 100 或 1000）给每个事件一个访问监控硬件的机会。 多路复用仅适用于 PMU 事件。 使用多路复用，事件不会一直被测量。 在运行结束时，该工具会根据启用的总时间与运行时间来调整计数。 实际公式为：

$$final_count = raw_count * time_enabled/time_running$$

如果在整个运行期间测量事件，这将提供对计数的估计值。 了解这是一个估计值而不是实际计数非常重要。 根据工作负载，会有盲点在扩展过程中引入错误。

事件目前以循环方式管理。 因此，每个事件最终都会有机会运行。 如果有 N 个计数器，则循环列表上的前 N 个事件被编程到 PMU 中。 在某些情况下，它可能会小于该值，因为某些事件可能不会一起测量，或者它们竞争相同的计数器。 此外，perf_events 接口允许多个工具同时测量同一个线程或 CPU。 每个事件都被添加到同一个循环列表中。 无法保证工具的所有事件都按顺序存储在列表中。

为了避免缩放（在只有一个活动 perf_event 用户的情况下），可以尝试减少事件的数量。 下表提供了几个常见处理器的计数器数量：

|   Processor   	| Generic counters 	| Fixed counters 	|
|:-------------:	|:----------------:	|:--------------:	|
| Intel Core    	| 2                	| 3              	|
| Intel Nehalem 	| 4                	| 3              	|

通用计数器可以测量任何事件。 固定计数器只能测量一个事件。 一些计数器可能保留用于特殊目的，例如看门狗定时器。

以下示例显示了缩放的效果：

```shell {.line-numbers}
perf stat -B -e cycles,cycles ./noploop 1

 Performance counter stats for './noploop 1':

    2,812,305,464 cycles
    2,812,304,340 cycles

       1.302481065  seconds time elapsed
```

在这里，没有多路复用，因此没有缩放。 让我们再添加一个事件：

```shell {.line-numbers}
perf stat -B -e cycles,cycles,cycles ./noploop 1

 Performance counter stats for './noploop 1':

    2,809,725,593 cycles                    (scaled from 74.98%)
    2,810,797,044 cycles                    (scaled from 74.97%)
    2,809,315,647 cycles                    (scaled from 75.09%)

       1.295007067  seconds time elapsed
```

有多路复用，因此可以缩放。 尝试以确保事件 A 和 B 始终一起测量的方式打包事件可能会很有趣。 尽管 perf_events 内核接口提供了对事件分组的支持，但当前的 perf 工具却没有。

#### 2.1.5 重复测量

可以使用 perf stat 多次运行相同的测试工作负载，并为每个计数获取平均值的标准偏差。

```shell {.line-numbers}
perf stat -r 5 sleep 1

 Performance counter stats for 'sleep 1' (5 runs):

    <not counted> cache-misses
           20,676 cache-references         #     13.046 M/sec   ( +-   0.658% )
            6,229 branch-misses            #      0.000 %       ( +-  40.825% )
    <not counted> branches
    <not counted> instructions
    <not counted> cycles
              144 page-faults              #      0.091 M/sec   ( +-   0.139% )
                0 CPU-migrations           #      0.000 M/sec   ( +-    -nan% )
                1 context-switches         #      0.001 M/sec   ( +-   0.000% )
         1.584872 task-clock-msecs         #      0.002 CPUs    ( +-  12.480% )

       1.002251432  seconds time elapsed   ( +-   0.025% )
```

在这里， sleep 运行 5 次，每个事件的平均计数以及 std-dev/mean 的比率被打印出来。

### 2.2 控制环境选择的选项

perf 工具可用于在每个线程、每个进程、每个 cpu 或系统范围内对事件进行计数。 在 per-thread 模式下，计数器只监视指定线程的执行。 当线程被调度出去时，监控停止。 当一个线程从一个处理器迁移到另一个处理器时，计数器会保存在当前处理器上并在新处理器上恢复。

per-process 模式是 per-thread 的一种变体，其中进程的所有线程都受到监视。 计数和样本在过程级别聚合。 perf_events 接口允许自动继承 fork() 和 pthread_create()。 默认情况下，perf 工具会激活继承。

在 per-cpu 模式下，所有在指定处理器上运行的线程都受到监视。 因此，每个 CPU 都会聚合计数和样本。 一个事件一次只监视一个 CPU。 要跨多个处理器进行监控，有必要创建多个事件。 perf 工具可以跨多个处理器聚合计数和样本。 它也可以只监视处理器的一个子集。

#### 2.2.1 计数和继承

默认情况下，perf stat 计算进程的所有线程以及后续的子进程和线程。 这可以使用 -i 选项进行更改。 不可能获得每个线程或每个进程的计数细分。

#### 2.2.2 处理器范围模式

默认情况下，perf stat 在每线程模式下计数。 要基于每个 cpu 进行计数，请传递 -a 选项。 当它自己指定时，所有在线处理器都会受到监控并汇总计数。 例如：

```shell {.line-numbers}
perf stat -B -ecycles:u,instructions:u -a dd if=/dev/zero of=/dev/null count=2000000

2000000+0 records in
2000000+0 records out
1024000000 bytes (1.0 GB) copied, 1.91559 s, 535 MB/s

 Performance counter stats for 'dd if=/dev/zero of=/dev/null count=2000000':

    1,993,541,603 cycles
      764,086,803 instructions             #      0.383 IPC

       1.916930613  seconds time elapsed
```

此测量收集所有 CPU 上的事件周期和指令。 测量的持续时间由 dd 的执行决定。 换句话说，此测量捕获 dd 进程的执行以及在所有 CPU 上在用户级别运行的任何其他内容。

要在不主动消耗周期的情况下计时测量持续时间，可以使用 ==/usr/bin/sleep== 命令：

```shell {.line-numbers}
perf stat -B -ecycles:u,instructions:u -a sleep 5

 Performance counter stats for 'sleep 5':

      766,271,289 cycles
      596,796,091 instructions             #      0.779 IPC

       5.001191353  seconds time elapsed
```

可以使用 -C 选项将监控限制在 CPUS 的一个子集。 可以传递要监视的 CPU 列表。 例如，要测量 CPU0、CPU2 和 CPU3：

```shell {.line-numbers}
perf stat -B -e cycles:u,instructions:u -a -C 0,2-3 sleep 5
```

演示机只有两个 CPU，但我们可以限制为 CPU 1。

```shell {.line-numbers}
perf stat -B -e cycles:u,instructions:u -a -C 1 sleep 5

 Performance counter stats for 'sleep 5':

      301,141,166 cycles
      225,595,284 instructions             #      0.749 IPC

       5.002125198  seconds time elapsed
```

计数在所有受监视的 CPU 中汇总。 请注意，在测量单个 CPU 时，计数周期数和指令数是如何减半的。


#### 2.2.3 附加到正在运行的进程

可以使用 perf 附加到已经运行的线程或进程。 这需要与线程或进程 ID 一起附加的权限。 要附加到进程，-p 选项必须是进程 ID。 要附加到通常在许多 Linux 机器上运行的 sshd 服务，请发出：

```shell {.line-numbers}
ps ax | fgrep sshd

 2262 ?        Ss     0:00 /usr/sbin/sshd -D
 2787 pts/0    S+     0:00 fgrep --color=auto sshd

perf stat -e cycles -p 2262 sleep 2

 Performance counter stats for process id '2262':

    <not counted> cycles

       2.001263149  seconds time elapsed
```

决定测量持续时间的是要执行的命令。 即使我们附加到一个进程，我们仍然可以传递命令的名称。 它用于计时测量。 没有它，perf 会一直监控直到它被杀死。 另请注意，当附加到进程时，会监视进程的所有线程。 此外，由于默认情况下继承是打开的，因此还将监视子进程或线程。 要关闭它，您必须使用 -i 选项。 可以在进程中附加特定线程。 通过线程，我们指的是内核可见线程。 换句话说，一个被 ps 或 top 命令可见的线程。 要附加到线程，必须使用 -t 选项。 我们看一下 rsyslogd，因为它总是在 Ubuntu 11.04 上运行，具有多个线程。

```shell {.line-numbers}
ps -L ax | fgrep rsyslogd | head -5

 889   889 ?        Sl     0:00 rsyslogd -c4
 889   932 ?        Sl     0:00 rsyslogd -c4
 889   933 ?        Sl     0:00 rsyslogd -c4
 2796  2796 pts/0    S+     0:00 fgrep --color=auto rsyslogd

perf stat -e cycles -t 932 sleep 2

 Performance counter stats for thread id '932':

    <not counted> cycles

       2.001037289  seconds time elapsed
```

在这个例子中，线程 932 在测量的 2 秒内没有运行。 否则，我们会看到一个计数值。 附加到内核线程是可能的，但并不真正推荐。 鉴于内核线程倾向于固定到特定的 CPU，最好使用 cpu-wide 模式。

### 2.3 控制输出的选项

perf stat 可以修改输出以适应不同的需求。

#### 2.3.1 漂亮地打印大数字

对于大多数人来说，很难阅读大量数字。 使用 perf stat，可以使用千位逗号分隔符（美国风格）打印大量数字。 为此，必须为 LC_NUMERIC 设置 -B 选项和正确的语言环境。 如上例所示，Ubuntu 已经正确设置了语言环境信息。 显式调用如下所示：

```shell {.line-numbers}
LC_NUMERIC=en_US.UTF8 perf stat -B -e cycles:u,instructions:u dd if=/dev/zero of=/dev/null count=10000000

100000+0 records in
100000+0 records out
51200000 bytes (51 MB) copied, 0.0971547 s, 527 MB/s

 Performance counter stats for 'dd if=/dev/zero of=/dev/null count=100000':

       96,551,461 cycles
       38,176,009 instructions             #      0.395 IPC

       0.098556460  seconds time elapsed
```

#### 2.3.2 机器可读输出

perf stat 还可以以可以轻松导入电子表格或由脚本解析的格式打印计数。 -x 选项更改输出格式并允许用户传递字段分隔符。 这使得生成 CSV 样式的输出变得容易：

```shell {.line-numbers}
perf stat  -x, date

Thu May 26 21:11:07 EDT 2011
884,cache-misses
32559,cache-references
<not counted>,branch-misses
<not counted>,branches
<not counted>,instructions
<not counted>,cycles
188,page-faults
2,CPU-migrations
0,context-switches
2.350642,task-clock-msecs
```

请注意，-x 选项与 -B 不兼容。

## 3. 使用perf record进行采样

perf 工具可用于在每个线程、每个进程和每个 CPU 的基础上收集配置文件。

有几个与采样相关的命令：记录(record)、报告(report)、注释(annotate)。 您必须首先使用 perf record 收集样本。 这会生成一个名为 perf.data 的输出文件。 然后可以使用 perf report 和 perf annotate 命令分析该文件，可能在另一台机器上。 该模型与 OProfile 的模型非常相似。

### 3.1 基于事件的抽样概述

Perf_events 基于基于事件的采样。 周期表示为事件发生的次数，而不是计时器滴答的次数。 当采样计数器溢出时记录一个样本，即从 2^64 回绕回 0。没有 PMU 实现 64 位硬件计数器，但 perf_events 在软件中模拟此类计数器。

perf_events 模拟 64 位计数器的方式仅限于使用实际硬件计数器中的位数来表示采样周期。 如果它小于 64，则内核会在这种情况下静默截断句点。 因此，如果在 32 位系统上运行，周期总是小于 2^31 是最好的。

在计数器溢出时，内核记录有关程序执行的信息，即样本。 记录的内容取决于测量的类型。 这都是由用户和工具指定的。 但是所有样本中共有的关键信息是指令指针，即程序被中断时在哪里。

基于中断的采样在现代处理器上引入了滑动。 这意味着存储在每个样本中的指令指针指定了程序被中断以处理 PMU 中断的位置，而不是计数器实际溢出的位置，即采样周期结束时的位置。 在某些情况下，如果有分支，这两个点之间的距离可能是几十条指令或更多。 当程序无法取得进展时，这两个位置确实是相同的。 因此，在解释配置文件时必须小心。

#### 3.1.1 默认事件：循环计数

默认情况下，perf 记录使用循环事件作为采样事件。 这是由内核映射到特定于硬件的 PMU 事件的通用硬件事件。 对于 Intel，它映射到 UNHALTED_CORE_CYCLES。 在存在 CPU 频率缩放的情况下，此事件不会保持与时间的恒定相关性。 英特尔提供了另一个事件，称为 UNHALTED_REFERENCE_CYCLES，但此事件当前不适用于 perf_events。

在 AMD 系统上，该事件映射到 CPU_CLK_UNHALTED，并且该事件也受频率缩放的影响。 在任何 Intel 或 AMD 处理器上，当处理器空闲时，即调用 mwait() 时，循环事件不计算在内。

#### 3.1.2 Period and rate

perf_events 接口允许两种模式来表示采样周期：

- 事件发生的次数（Period）
- 平均采样率/秒（Frequency）

perf 工具默认为平均速率。 它设置为 1000Hz，或 1000 个样本/秒。 这意味着内核正在动态调整采样周期以达到目标平均速率。 period的调整在原始配置文件数据中报告。相反，在其他模式下，采样周期由用户设置，并且在样本之间不会变化。 目前不支持采样周期随机化。

### 3.2 收集样本

默认情况下，perf 记录以每线程模式运行，并启用继承模式。 当执行一个忙循环的简单程序时，最简单的模式如下所示：

```shell {.line-numbers}
perf record ./noploop 1

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (~89 samples) ]
```

上面的示例以 1000Hz 的平均目标速率收集事件周期的样本。 生成的样本保存到 perf.data 文件中。 如果文件已经存在，系统可能会提示您传递 -f 以覆盖它。 要将结果放在特定文件中，请使用 -o 选项。

警告：报告的样本数量只是一个估计值。 它不反映收集的实际样本数量。 该估计值基于写入 perf.data 文件的字节数和最小样本大小。 但是每个样本的大小取决于测量的类型。 一些样本由计数器自己生成，但其他样本被记录以支持后处理期间的符号相关，例如 mmap() 信息。

要获得 perf.data 文件的准确样本数，可以使用 perf report 命令：

```shell {.line-numbers}
perf record ./noploop 1

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.058 MB perf.data (~2526 samples) ]
perf report -D -i perf.data | fgrep RECORD_SAMPLE | wc -l

1280
```

要指定自定义速率，必须使用 -F 选项。 例如，仅在用户级别对事件指令进行采样，并且

```shell {.line-numbers}
at an average rate of 250 samples/sec:
```

```shell {.line-numbers}
perf record -e instructions:u -F 250 ./noploop 4

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.049 MB perf.data (~2160 samples) ]
```

相反，要指定采样周期，必须使用 -c 选项。 例如，仅在用户级别每 2000 次事件指令收集一个样本：

```shell {.line-numbers}
perf record -e retired_instructions:u -c 2000 ./noploop 4

[ perf record: Woken up 55 times to write data ]
[ perf record: Captured and wrote 13.514 MB perf.data (~590431 samples) ]
```

### 3.3 处理器范围模式

在 per-cpu 模式下，为在受监视 CPU 上执行的所有线程收集样本。 要在 per-cpu 模式下切换 perf 记录，必须使用 -a 选项。 默认情况下，在此模式下，会监视所有在线 CPU。 可以使用 -C 选项限制 CPU 的子集，如上面的 perf stat 所述。

要在所有 CPUS 上以 1000 个样本/秒的平均目标速率对用户和内核级别的周期进行 5 秒的采样：

```shell {.line-numbers}
perf record -a -F 1000 sleep 5

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.523 MB perf.data (~22870 samples) ]
```

## 3. 使用perf report进行样本分析

perf record 收集的样本保存在一个名为 perf.data 的二进制文件中。 perf report 命令读取此文件并生成简明的执行配置文件。

默认情况下，样本按样本最多的函数排序。 可以自定义排序顺序，从而以不同的方式查看数据。

```shell {.line-numbers}
perf report

# Events: 1K cycles
#
# Overhead          Command                   Shared Object  Symbol
# ........  ...............  ..............................  .....................................
#
    28.15%      firefox-bin  libxul.so                       [.] 0xd10b45
     4.45%          swapper  [kernel.kallsyms]               [k] mwait_idle_with_hints
     4.26%          swapper  [kernel.kallsyms]               [k] read_hpet
     2.13%      firefox-bin  firefox-bin                     [.] 0x1e3d
     1.40%  unity-panel-ser  libglib-2.0.so.0.2800.6         [.] 0x886f1
     [...]
```

“开销”列表示在相应函数中收集的总体样本的百分比。 第二列报告收集样本的进程。 在每线程/每进程模式下，这始终是被监视命令的名称。 但在 cpu-wide 模式下，命令可能会有所不同。 第三列显示了样本来自的 ELF 图像的名称。 如果程序是动态链接的，那么这可能会显示共享库的名称。 当样本来自内核时，使用伪 ELF 映像名称 [kernel.kallsyms]。 第四列表示获取样本的特权级别，即程序运行时中断时的特权级别：

[.] : user level
[k]: kernel level
[g]: guest kernel level (virtualization)
[u]: guest os user space
[H]: hypervisor

最后一列显示符号名称。

有许多不同的方式可以呈现样本，即排序。 要按共享对象排序，即 dsos：

```shell {.line-numbers}
perf report --sort=dso

# Events: 1K cycles
#
# Overhead                   Shared Object
# ........  ..............................
#
    38.08%  [kernel.kallsyms]
    28.23%  libxul.so
     3.97%  libglib-2.0.so.0.2800.6
     3.72%  libc-2.13.so
     3.46%  libpthread-2.13.so
     2.13%  firefox-bin
     1.51%  libdrm_intel.so.1.0.0
     1.38%  dbus-daemon
     1.36%  [drm]
     [...]
```

### 4.1 控制输出的选项

为了使输出更易于解析，可以将列分隔符更改为单个字符：

```shell {.line-numbers}
perf report -t
```

### 4.2 控制内核报告的选项

perf 工具不知道如何从压缩的内核映像 (vmlinuz) 中提取符号。 因此，用户必须使用 -k 选项传递未压缩内核的路径：

```shell {.line-numbers}
perf report -k /tmp/vmlinux
```

当然，这只有在内核编译为带有调试符号时才有效。

### 4.3 处理器范围模式

在 per-cpu 模式下，从受监视 CPU 上运行的所有线程记录样本。 因此，可以收集来自许多不同过程的样本。 例如，如果我们在所有 CPU 上监控 5 秒：

```shell {.line-numbers}
perf record -a sleep 5
perf report

# Events: 354  cycles
#
# Overhead          Command               Shared Object  Symbol
# ........  ...............  ..........................  ......................................
#
    13.20%          swapper  [kernel.kallsyms]           [k] read_hpet
     7.53%          swapper  [kernel.kallsyms]           [k] mwait_idle_with_hints
     4.40%    perf_2.6.38-8  [kernel.kallsyms]           [k] _raw_spin_unlock_irqrestore
     4.07%    perf_2.6.38-8  perf_2.6.38-8               [.] 0x34e1b
     3.88%    perf_2.6.38-8  [kernel.kallsyms]           [k] format_decode
     [...]
```

当符号打印为十六进制地址时，这是因为 ELF 映像没有符号表。 当二进制文件被剥离时会发生这种情况。 我们也可以按cpu排序。 这可能有助于确定工作负载是否平衡良好：

```shell {.line-numbers}
perf report --sort=cpu

# Events: 354  cycles
#
# Overhead  CPU
# ........  ...
#
   65.85%  1
   34.15%  0
```

### 4.4 开销计算

当 perf 收集调用链时，开销可以在两列中显示为“Children”和“Self”。 'self' 开销只是通过添加条目的所有周期值来计算 - 通常是一个函数（符号）。 这是 perf 传统上显示的值，所有“self”开销值的总和应为 100%。

“子”开销是通过将子函数的所有周期值相加来计算的，这样即使它们不直接执行太多，它也可以显示更高级别函数的总开销。 这里的“子”是指从另一个（父）函数调用的函数。

所有“子”开销值的总和超过 100% 可能会令人困惑，因为它们中的每一个都已经是其子函数的“自身”开销的累积。 但是启用此功能后，即使样本分布在孩子身上，用户也可以找到哪个函数的开销最大。

考虑以下示例； 有如下三个功能。

```c {.line-numbers}
void foo(void) {
    /* do something */
}

void bar(void) {
    /* do something */
    foo();
}

int main(void) {
    bar()
    return 0;
}
```

在这种情况下，'foo' 是 'bar' 的子代，而 'bar' 是 'main' 的直接子代，所以 'foo' 也是 'main' 的子代。 换句话说，'main' 是 'foo' 和 'bar' 的父级，而 'bar' 是 'foo' 的父级。

假设所有样本仅记录在“foo”和“bar”中。 当它使用调用链记录时，输出将在 perf 报告的通常（仅自开销）输出中显示如下内容：

```shell {.line-numbers}
Overhead  Symbol
........  .....................
  60.00%  foo
          |
          --- foo
              bar
              main
              __libc_start_main

  40.00%  bar
          |
          --- bar
              main
              __libc_start_main
```

启用 --children 选项时，子函数（即 'foo' 和 'bar'）的 'self' 开销值被添加到父级以计算 'children' 开销。 在这种情况下，报告可以显示为：

```shell {.line-numbers}
Children      Self  Symbol
........  ........  ....................
 100.00%     0.00%  __libc_start_main
          |
          --- __libc_start_main

 100.00%     0.00%  main
          |
          --- main
              __libc_start_main

 100.00%    40.00%  bar
          |
          --- bar
              main
              __libc_start_main

  60.00%    60.00%  foo
          |
          --- foo
              bar
              main
              __libc_start_main
```

在上面的输出中，“foo”的“self”开销（60%）被添加到“bar”、“main”和“__libc_start_main”的“children”开销中。 同样，“bar”的“self”开销（40%）被添加到“main”和“__libc_start_main”的“children”开销中。

所以首先显示'__libc_start_main'和'main'，因为它们具有相同（100％）的'children'开销（即使它们的'self'开销为零）并且它们是'foo'和'bar'的父母。

从 v3.16 开始，默认情况下会显示“孩子”开销，并且输出按其值排序。 通过在命令行上指定 --no-children 选项或在 perf 配置文件中添加 'report.children = false' 或 'top.children = false' 来禁用 'children' 开销。

## 4. 使用 perf annotate 进行源代码级别分析

可以使用 perf annotate 深入到指令级别。 为此，您需要使用要注释的命令名称调用 perf annotate。 所有带有样本的函数都将被反汇编，并且每条指令都将报告其相对百分比的样本：

```shell {.line-numbers}
perf record ./noploop 5
perf annotate -d ./noploop

------------------------------------------------
 Percent |   Source code & Disassembly of noploop.noggdb
------------------------------------------------
         :
         :
         :
         :   Disassembly of section .text:
         :
         :   08048484 <main>:
    0.00 :    8048484:       55                      push   %ebp
    0.00 :    8048485:       89 e5                   mov    %esp,%ebp
[...]
    0.00 :    8048530:       eb 0b                   jmp    804853d <main+0xb9>
   15.08 :    8048532:       8b 44 24 2c             mov    0x2c(%esp),%eax
    0.00 :    8048536:       83 c0 01                add    $0x1,%eax
   14.52 :    8048539:       89 44 24 2c             mov    %eax,0x2c(%esp)
   14.27 :    804853d:       8b 44 24 2c             mov    0x2c(%esp),%eax
   56.13 :    8048541:       3d ff e0 f5 05          cmp    $0x5f5e0ff,%eax
    0.00 :    8048546:       76 ea                   jbe    8048532 <main+0xae>
[...]
```

第一列报告在该指令处捕获的函数 ==noploop()== 的样本百分比。 如前所述，您应该仔细解释此信息。

如果应用程序使用 -ggdb 编译，perf annotate 可以生成源代码级别信息。 下面的代码片段显示了在使用此调试信息编译时，同样执行 noploop 的信息量更大的输出。

<font color=green>这边report可能会显示"The perf.data file has no samples!"，可以参考:
- https://stackoverflow.com/questions/35497193/why-does-perf-record-and-annotate-not-work
- https://stackoverflow.com/questions/44674630/error-perf-data-file-has-no-samples
</font>

```shell {.line-numbers}
------------------------------------------------
 Percent |   Source code & Disassembly of noploop
------------------------------------------------
         :
         :
         :
         :   Disassembly of section .text:
         :
         :   08048484 <main>:
         :   #include <string.h>
         :   #include <unistd.h>
         :   #include <sys/time.h>
         :
         :   int main(int argc, char **argv)
         :   {
    0.00 :    8048484:       55                      push   %ebp
    0.00 :    8048485:       89 e5                   mov    %esp,%ebp
[...]
    0.00 :    8048530:       eb 0b                   jmp    804853d <main+0xb9>
         :                           count++;
   14.22 :    8048532:       8b 44 24 2c             mov    0x2c(%esp),%eax
    0.00 :    8048536:       83 c0 01                add    $0x1,%eax
   14.78 :    8048539:       89 44 24 2c             mov    %eax,0x2c(%esp)
         :           memcpy(&tv_end, &tv_now, sizeof(tv_now));
         :           tv_end.tv_sec += strtol(argv[1], NULL, 10);
         :           while (tv_now.tv_sec < tv_end.tv_sec ||
         :                  tv_now.tv_usec < tv_end.tv_usec) {
         :                   count = 0;
         :                   while (count < 100000000UL)
   14.78 :    804853d:       8b 44 24 2c             mov    0x2c(%esp),%eax
   56.23 :    8048541:       3d ff e0 f5 05          cmp    $0x5f5e0ff,%eax
    0.00 :    8048546:       76 ea                   jbe    8048532 <main+0xae>
[...]
```

### 5.1 在内核代码上使用 perf annotate

perf 工具不知道如何从压缩内核映像 (vmlinuz) 中提取符号。 与 perf 报告的情况一样，用户必须使用 -k 选项传递未压缩内核的路径：

```shell {.line-numbers}
perf annotate -k /tmp/vmlinux -d symbol
```

同样，这仅在内核使用调试符号编译时才有效。

## 6. 使用 perf top 进行实时分析

perf 工具可以在类似于 Linux top工具的模式下运行，实时打印采样函数。默认采样事件是周期，默认顺序是每个符号的采样数递减，因此 perf top 显示了花费大部分时间的函数。 默认情况下，perf top 在处理器范围模式下运行，在用户和内核级别监视所有在线 CPU。 可以使用 -C 选项仅监视一部分 CPUS。

```shel {.line-numbers}
perf top
-------------------------------------------------------------------------------------------------------------------------------------------------------
  PerfTop:     260 irqs/sec  kernel:61.5%  exact:  0.0% [1000Hz
cycles],  (all, 2 CPUs)
-------------------------------------------------------------------------------------------------------------------------------------------------------

            samples  pcnt function                       DSO
            _______ _____ ______________________________ ___________________________________________________________

              80.00 23.7% read_hpet                      [kernel.kallsyms]
              14.00  4.2% system_call                    [kernel.kallsyms]
              14.00  4.2% __ticket_spin_lock             [kernel.kallsyms]
              14.00  4.2% __ticket_spin_unlock           [kernel.kallsyms]
               8.00  2.4% hpet_legacy_next_event         [kernel.kallsyms]
               7.00  2.1% i8042_interrupt                [kernel.kallsyms]
               7.00  2.1% strcmp                         [kernel.kallsyms]
               6.00  1.8% _raw_spin_unlock_irqrestore    [kernel.kallsyms]
               6.00  1.8% pthread_mutex_lock             /lib/i386-linux-gnu/libpthread-2.13.so
               6.00  1.8% fget_light                     [kernel.kallsyms]
               6.00  1.8% __pthread_mutex_unlock_usercnt /lib/i386-linux-gnu/libpthread-2.13.so
               5.00  1.5% native_sched_clock             [kernel.kallsyms]
               5.00  1.5% drm_addbufs_sg                 /lib/modules/2.6.38-8-generic/kernel/drivers/gpu/drm/drm.ko
```

默认情况下，第一列显示自运行开始以来的样本总数。 通过按“Z”键，可以将其更改为打印自上次刷新以来的样本数。 回想一下，当处理器未处于停止状态（即未空闲）时，循环事件会计算 CPU 周期。 因此，这不等同于挂钟时间。 此外，该事件还受到频率缩放的影响。

还可以深入研究单个函数以查看哪些指令具有最多的样本。 要深入了解指定函数，请按“s”键并输入函数名称。 这里我们选择了顶层函数 noploop（上面没有显示）：

```shell {.line-numbers}
------------------------------------------------------------------------------------------------------------------------------------------
   PerfTop:    2090 irqs/sec  kernel:50.4%  exact:  0.0% [1000Hz cycles],  (all, 16 CPUs)
------------------------------------------------------------------------------------------------------------------------------------------
Showing cycles for noploop
  Events  Pcnt (>=5%)
       0  0.0%   00000000004003a1 <noploop>:
       0  0.0%     4003a1:   55                      push   %rbp
       0  0.0%     4003a2:   48 89 e5                mov    %rsp,%rbp
    3550 100.0%    4003a5:   eb fe                   jmp    4003a5 <noploop+0x4>
```

## 7. 使用 perf bench 进行基准测试

## 8. 故障排除和提示



## Reference

- [PMU counters and profiling basics.](https://easyperf.net/blog/2018/06/01/PMU-counters-and-profiling-basics)
- [How to monitor the full range of CPU performance events](http://www.bnikolic.co.uk/blog/hpc-prof-events.html)
- [perf Examples](https://www.brendangregg.com/perf.html)
- [PERF tutorial: Finding execution hot spots](http://sandsoftwaresound.net/perf/perf-tutorial-hot-spots/)
- [Application performance analysis Using Perf with PMU event, PEBS, LBR and Intel PT technologies](http://bos.itdks.com/4d8aac644c2140e7ae259c14fae8e36f.pdf)
- [4. PEBS(Precise Event Based Sampling)机制](https://www.it610.com/article/1274692411129348096.htm)
- [Linux perf_events status update](http://www.paradyn.org/petascale2013/slides/eranian13.pdf)
- [Gooda project](https://github.com/David-Levinthal/gooda)
- [Intel PEBS 那些事](https://zhuanlan.zhihu.com/p/377074185)
- [Advanced Hardware Profiling and Sampling (PEBS, IBS, etc.): Creating a New PAPI Sampling Interface](https://web.eece.maine.edu/~vweaver/projects/perf_events/sampling/pebs_ibs_sampling.pdf)