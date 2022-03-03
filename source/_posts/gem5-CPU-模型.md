---
title: gem5 CPU 模型
date: 2021-11-29 00:12:54
tags:
- gem5
- CPU模型
- 计算机体系架构
categories: 计算机体系架构
password: www
abstract: Welcome to my blog, enter password to read.
message: Welcome to my blog, enter password to read.
---
# gem5 CPU 模型

## SimpleCPU

SimpleCPU 是一个纯功能的、有序的模型，适用于不需要详细模型的情况。这可以包括预热期、驱动主机的客户端系统，或者只是测试以确保程序正常工作。

它最近被重新编写以支持新的内存系统，现在分为三类：

- BasicSimpleCPU
- AtomicSimpleCPU
- TimingSimpleCPU

### BasicSimpleCPU

BaseSimpleCPU 有多种用途：

- 保存架构状态，统计 SimpleCPU 模型中通用的信息。
- 定义用于检查中断、设置获取请求、处理预执行设置、处理执行后操作以及将 PC 推进到下一条指令的函数。这些函数在 SimpleCPU 模型中也是通用的。
- 实现 ExecContext 接口。

BaseSimpleCPU 不能单独运行。您必须使用从 BaseSimpleCPU 继承的类之一，AtomicSimpleCPU 或 TimingSimpleCPU。

### AtomicSimpleCPU

AtomicSimpleCPU 是使用原子内存访问的 SimpleCPU 版本（有关详细信息，请参阅[内存系统](https://www.gem5.org/documentation/general_docs/memory_system/index.html#access-types)）。它使用来自原子访问的延迟估计来估计整体缓存访问时间。 AtomicSimpleCPU 是从 BaseSimpleCPU 派生出来的，它实现了读取和写入内存的功能，还有Tick，它定义了每个 CPU 周期发生的事情。它定义了用于连接内存的端口，并将 CPU 连接到缓存。

![](https://www.gem5.org/assets/img/AtomicSimpleCPU.jpg)

### TimingSimpleCPU

TimingSimpleCPU 是使用定时内存访问的 SimpleCPU 版本（有关详细信息，请参阅[内存系统](https://www.gem5.org/documentation/general_docs/memory_system/index.html#access-types)）。它在缓存访问时停止并在继续之前等待内存系统响应。与 AtomicSimpleCPU 一样，TimingSimpleCPU 也是从 BaseSimpleCPU 派生而来，并实现了相同的功能集。它定义了用于连接内存的端口，并将 CPU 连接到缓存。它还定义了必要的函数来处理从内存到发出的访问的响应。

![](https://www.gem5.org/assets/img/TimingSimpleCPU.jpg)

<font color=blue>AtomicSimpleCPU对时间仿真做了极致的简化，访存的时间不予考虑，只要发送请求立即就可返回数据。而TimingSimpleCPU在AtomicSimpleCPU的基础上加入了内存的实验仿真，无论是取指还是取数据都加入了与Memory交互的过程。</font>

## O3CPU

O3CPU 是我们针对 v2.0 版本的新详细模型。它是一个基于 Alpha 21264 的无序 CPU 模型。本页将为您提供 O3CPU 模型、流水线阶段和流水线资源的总体概述。我们已努力将代码记录在案，因此请浏览代码以了解有关 O3CPU 各部分如何工作的确切详细信息。

### Pipeline stages

- Fetch
  每个周期获取指令，根据所选策略选择从哪个线程获取指令。这个阶段是首先创建 DynInst 和处理分支预测的地方。
- Decode
  每个周期解码指令。还处理与 PC 相关的无条件分支的早期解析。
- Rename
  使用带有空闲列表的物理寄存器文件重命名指令。如果没有足够的寄存器可以重命名，或者后端资源已满，则将停止。还通过在重命名中暂停它们直到后端耗尽来处理此时的任何序列化指令。
- Issue/Execute/Writeback
  当对指令调用 execute() 函数时，我们的模拟器模型处理执行和写回，因此我们将这三个阶段合并为一个阶段。这个阶段（IEW）处理向指令队列调度指令，告诉指令队列发出指令，以及执行和写回指令。
- Commit
  每个周期提交指令，处理指令可能导致的任何故障。还处理在分支预测错误的情况下重定向前端。

### Execute-in-execute model

对于 O3CPU，我们已经努力使其具有高度的计时准确度。为了做到这一点，我们使用了一个在流水线的执行阶段实际执行指令的模型。大多数模拟器模型将在流水线的开始或结束处执行指令； SimpleScalar 和我们旧的详细 CPU 模型都在流水线的开头执行指令，然后将其传递给时序后端。这带来了两个潜在的问题：首先，时序后端可能会出现不会出现在程序结果中的错误。其次，通过在流水线的开头执行，指令全部按顺序执行，无序加载交互丢失。我们的模型能够避免这些缺陷并提供准确的时序模型。

### Template Policies

O3CPU 大量使用模板策略来获得一定程度的多态性，而不必使用虚函数。它使用模板策略将“Impl”传递给 O3CPU 中使用的几乎所有类。这个 Impl 在其中定义了流水线的所有重要类，例如特定的 Fetch 类、Decode 类、特定的 DynInst 类型、CPU 类等。它允许任何使用它作为模板参数的类能够获取 Impl 中定义的任何类的完整类型信息。通过获取完整的类型信息，不需要通常用于提供多态性的传统虚函数/基类。主要缺点是 CPU 必须在编译时完全定义，并且模板化类需要手动实例化。参见 src/cpu/o3/impl.hh 和 src/cpu/o3/cpu_policy.hh 例如 Impl 类。

### ISA independence

O3CPU 旨在尝试将依赖于 ISA 的代码和独立于 ISA 的代码分开。流水线阶段和资源都主要与 ISA 以及较低级别的 CPU 代码无关。 ISA 相关代码实现特定于 ISA 的功能。例如，AlphaO3CPU 实现了 Alpha 特定的功能，例如从错误中断（hwrei()）中硬件返回或读取中断标志。较低级别的 CPU，FullO3CPU，负责协调所有流水线阶段并处理其他独立于 ISA 的操作。我们希望这种分离可以更容易地实现未来的 ISA，因为希望只需要重新定义高级类。

### Interaction with ThreadContext

ThreadContext 为外部对象提供接口以访问 CPU 内的线程状态。然而，由于 O3CPU 是一个乱序 CPU，这有点复杂。虽然在任何给定周期中架构状态是什么已经明确定义，但如果架构状态改变会发生什么，则没有明确定义。因此，无需太多努力即可读取 ThreadContext，但写入 ThreadContext 和更改寄存器状态需要 CPU 刷新整个管道。这是因为可能有运行中的指令依赖于已更改的寄存器，并且不清楚他们是否应该查看寄存器更新。因此，对 ThreadContext 的访问有可能导致 CPU 模拟变慢。

### Backend Pipeline

#### Compute Instructions

计算指令更简单，因为它们不访问内存并且不与 LSQ 交互。下面包括一个高级调用链（仅重要功能），其中包含有关每个功能的描述。

```c++
Rename::tick()->Rename::RenameInsts()
IEW::tick()->IEW::dispatchInsts()
IEW::tick()->InstructionQueue::scheduleReadyInsts()
IEW::tick()->IEW::executeInsts()
IEW::tick()->IEW::writebackInsts()
Commit::tick()->Commit::commitInsts()->Commit::commitHead()
```

- 重命名 (Rename::renameInsts())。顾名思义，寄存器被重命名，指令被推送到 IEW 阶段。它检查 IQ/LSQ 是否可以保存新指令。
- 调度 (IEW::dispatchInsts())。此函数将重命名的指令插入 IQ 和 LSQ。
- 调度（InstructionQueue::scheduleReadyInsts()） IQ 管理就绪列表中的就绪指令（操作数就绪），并将它们调度到可用的 FU。 FU 的延迟在此处设置，并在 FU 完成后发送指令执行。
- 执行 (IEW::executeInsts())。这里调用计算指令的execute()函数并发送到commit。请注意 execute() 会将结果写入目标寄存器。
- 写回 (IEW::writebackInsts())。这里调用了 InstructionQueue::wakeDependents()。相关指令将添加到就绪列表中以进行调度。
- 提交 (Commit::commitInsts())。一旦指令到达 ROB 的头部，它将被提交并从 ROB 中释放。

#### Load Instruction

在执行之前，加载指令与计算指令共享相同的路径。

```c++
IEW::tick()->IEW::executeInsts()
  ->LSQUnit::executeLoad()
    ->StaticInst::initiateAcc()
      ->LSQ::pushRequest()
        ->LSQUnit::read()
          ->LSQRequest::buildPackets()
          ->LSQRequest::sendPacketToCache()
    ->LSQUnit::checkViolation()
DcachePort::recvTimingResp()->LSQRequest::recvTimingResp()
  ->LSQUnit::completeDataAccess()
    ->LSQUnit::writeback()
      ->StaticInst::completeAcc()
      ->IEW::instToCommit()
IEW::tick()->IEW::writebackInsts()
```

- LSQUnit::executeLoad() 将通过调用指令的 initialAcc() 函数来启动访问。通过执行上下文接口，initialAcc() 会调用initialMemRead() 并最终被定向到LSQ::pushRequest()。
- LSQ::pushRequest() 将分配一个 LSQRequest 来跟踪所有状态，并开始翻译。当翻译完成时，它将记录虚拟地址并调用 LSQUnit::read()。
- LSQUnit::read() 将检查负载是否与任何以前的存储有别名。
  - 如果它可以转发，那么它将为下一个周期安排WritebackEvent。
  - 如果它是别名但不能转发，它会调用 InstructionQueue::rescheduleMemInst() 和 LSQReuqest::discard()。
  - 否则，它将数据包发送到缓存。
- LSQUnit::writeback() 将调用 StaticInst::completeAcc()，它将加载的值写入目标寄存器。然后将指令推送到提交队列。 IEW::writebackInsts() 然后将它标记为完成并唤醒它的依赖项。从这里开始，它与计算指令共享相同的路径。

#### Store Instruction

存储指令类似于加载指令，但仅在提交后写回缓存。

```c++
IEW::tick()->IEW::executeInsts()
  ->LSQUnit::executeStore()
    ->StaticInst::initiateAcc()
      ->LSQ::pushRequest()
        ->LSQUnit::write()
    ->LSQUnit::checkViolation()
Commit::tick()->Commit::commitInsts()->Commit::commitHead()
IEW::tick()->LSQUnit::commitStores()
IEW::tick()->LSQUnit::writebackStores()
  ->LSQRequest::buildPackets()
  ->LSQRequest::sendPacketToCache()
  ->LSQUnit::storePostSend()
DcachePort::recvTimingResp()->LSQRequest::recvTimingResp()
  ->LSQUnit::completeDataAccess()
    ->LSQUnit::completeStore()
```

- 与 LSQUnit::read() 不同，LSQUnit::write() 只会复制存储数据，但不会将数据包发送到缓存，因为存储尚未提交。
- 提交存储后，LSQUnit::commitStores() 会将 SQ 条目标记为 canWB，以便 LSQUnit::writebackStores() 将存储请求发送到缓存。
- 最后，当响应返回时，LSQUnit::completeStore() 将释放 SQ 条目。

#### Branch Misspeculation

分支错误推测在 IEW::executeInsts() 中处理。它将通知提交阶段开始在错误推测的分支上压缩 ROB 中的所有指令。

```c++
IEW::tick()->IEW::executeInsts()->IEW::squashDueToBranch()
```

#### Memory Order Misspeculation

指令队列有一个 MemDepUnit 来跟踪内存顺序依赖性。如果 MemDepUnit 声明存在依赖关系，IQ 将不会调度指令。

在 LSQUnit::read() 中，如果可能，LSQ 将搜索可能的别名存储和转发。否则，当阻塞存储完成时，通过通知 MemDepUnit 来阻塞和重新调度加载。

LSQUnit::executeLoad/Store() 都会调用 LSQUnit::checkViolation() 来搜索 LQ 以查找可能的错误推测。如果找到，它将设置 LSQUnit::memDepViolator 并且 IEW::executeInsts() 将稍后启动以压缩错误推测的指令。

```c++
IEW::tick()->IEW::executeInsts()
  ->LSQUnit::executeLoad()
    ->StaticInst::initiateAcc()
    ->LSQUnit::checkViolation()
  ->IEW::squashDueToMemOrder()
```

## TraceCPU

### Overview

Trace CPU 模型回放弹性轨迹，这些轨迹是由附加到 O3 CPU 模型的 Elastic Trace Probe 生成的依赖和时间注释轨迹。 Trace CPU 模型的重点是以快速且合理准确的方式实现内存系统（缓存层次结构、互连和主内存）性能探索，而不是使用详细但缓慢的 O3 CPU 模型。这些跟踪是为在 SE 和 FS 模式下模拟的单线程基准测试开发的。通过将 Trace CPU 与经典内存系统以及不同的缓存设计参数和 DRAM 内存类型连接起来，它们已与 15 个内存敏感的 SPEC 2006 基准测试和少数 HPC 代理应用程序相关联。一般来说，弹性轨迹可以移植到其他模拟环境中。

出版物：
[&#34;Exploring System Performance using Elastic Traces: Fast, Accurate and Portable&#34;](https://ieeexplore.ieee.org/document/7818336) Radhika Jagtap, Stephan Diestelhorst, Andreas Hansson, Matthias Jung and Norbert Wehn SAMOS 2016

**跟踪生成和重放方法**

![](https://www.gem5.org/assets/img/Etrace_methodology.jpg)

### Elastic Trace Generation

Elastic Trace Probe Listener 侦听插入到 O3 CPU 管道阶段的探测点。它监视每条指令并通过记录数据 Read-After-Write 依赖关系和加载和存储之间的顺序依赖关系来创建依赖关系图。它将指令获取请求跟踪和弹性数据内存请求跟踪写为两个单独的文件，如下所示。

![](https://www.gem5.org/assets/img/Etraces_output.jpg)

#### Trace file formats

弹性数据内存跟踪和获取请求跟踪均使用 google protobuf 进行编码。

**Elastic Trace fields in protobuf format**

| Fields                       	| Discritption                                                                                         	|
|------------------------------	|------------------------------------------------------------------------------------------------------	|
| required uint64 seq_num      	| Instruction number used as an id for tracking dependencies                                           	|
| required RecordType type     	| RecordType enum has values: INVALID, LOAD, STORE, COMP                                               	|
| optional uint64 p_addr       	| Physical memory address if instruction is a load/store                                               	|
| optional uint32 size         	| Size in bytes of data if instruction is a load/store                                                 	|
| optional uint32 flags        	| Flags or attributes of the access, ex. Uncacheable                                                   	|
| required uint64 rob_dep      	| Past instruction number on which there is order (ROB) dependency                                     	|
| required uint64 comp_delay   	| Execution delay between the completion of the last dependency and the execution of the instruction   	|
| repeated uint64 reg_dep      	| Past instruction number on which there is RAW data dependency                                        	|
| optional uint32 weight       	| To account for committed instructions that were filtered out                                         	|
| optional uint64 pc           	| Instruction address, i.e. the program counter                                                        	|
| optional uint64 v_addr       	| Virtual memory address if instruction is a load/store                                                	|
| optional uint32 asid         	| Address Space ID                                                                                     	|

Python 中的解码脚本可在 util/decode_inst_dep_trace.py 中获得，它以 ASCII 格式输出跟踪。

**Example of a trace in ASCII**

```
1,356521,COMP,8500::

2,35656,1,COMP,0:,1:

3,35660,1,LOAD,1748752,4,74,500:,2:

4,35660,1,COMP,0:,3:

5,35664,1,COMP,3000::,4

6,35666,1,STORE,1748752,4,74,1000:,3:,4,5

7,35666,1,COMP,3000::,4

8,35670,1,STORE,1748748,4,74,0:,6,3:,7

9,35670,1,COMP,500::,7
```

指令提取跟踪中的每条记录都具有以下字段。

| Fields                   	| Discritption                                  	|
|--------------------------	|-----------------------------------------------	|
| required uint64 tick     	| Timestamp of the access                       	|
| required uint32 cmd      	| Read or Write (in this case always Read)      	|
| required uint64 addr     	| Physical memory address                       	|
| required uint32 size     	| Size in bytes of data                         	|
| optional uint32 flags    	| Flags or attributes of the access             	|
| optional uint64 pkt_id   	| Id of the access                              	|
| optional uint64 pc       	| Instruction address, i.e. the program counter 	|

util/decode_packet_trace.py 中的 Python 解码脚本可用于以 ASCII 格式输出跟踪。

**编译依赖：**

您需要安装 google 协议缓冲区，因为使用此记录跟踪。

```shell
sudo apt-get install protobuf-compiler
sudo apt-get install libprotobuf-dev
```

#### Scripts and options

- SE mode
  - build/ARM/gem5.opt [gem5.opt options] -d bzip_10Minsts configs/example/se.py [se.py options] --cpu-type=arm_detailed --caches --cmd=$M5_PATH/binaries/arm_arm/linux/bzip2 --options=$M5_PATH/data/bzip2/lgred/input/input.source -I 10000000 --elastic-trace-en --data-trace-file=deptrace.proto.gz --inst-trace-file=fetchtrace.proto.gz --mem-type=SimpleMemory
- FS mode: 为您感兴趣的区域创建一个检查点并从检查点恢复，但启用 O3 CPU 模型和跟踪
  - build/ARM/gem5.opt --outdir=m5out/bbench ./configs/example/fs.py [fs.py options] --benchmark bbench-ics
  - build/ARM/gem5.opt --outdir=m5out/bbench/capture_10M ./configs/example/fs.py [fs.py options] --cpu-type=arm_detailed --caches --elastic-trace-en --data-trace-file=deptrace.proto.gz --inst-trace-file=fetchtrace.proto.gz --mem-type=SimpleMemory --checkpoint-dir=m5out/bbench -r 0 --benchmark bbench-ics -I 10000000

### Replay with Trace CPU

上面生成的执行跟踪然后被跟踪 CPU 消耗，如下图所示。

![](https://www.gem5.org/assets/img/Trace_cpu_top_level.jpg)

Trace CPU 模型继承自 Base CPU 并与数据和指令 L1 缓存接口。跟踪 CPU 的示意图解释了主要逻辑和控制块，如下所示。

![](https://www.gem5.org/assets/img/Trace_cpu_detail.jpg)

#### Scripts and options

- 示例文件夹中的跟踪重放脚本可用于播放 SE 和 FS 生成的跟踪
  - build/ARM/gem5.opt [gem5.opt options] -d bzip_10Minsts_replay configs/example/etrace_replay.py [options] --cpu-type=trace --caches --data-trace-file=bzip_10Minsts/deptrace.proto.gz --inst-trace-file=bzip_10Minsts/fetchtrace.proto.gz --mem-size=4GB

| Fields                     	| Discritption                                                                                       	|
|----------------------------	|----------------------------------------------------------------------------------------------------	|
| required uint64 seq_num    	| Timestamp of the access                                                                            	|
| required RecordType type   	| Read or Write (in this case always Read)                                                           	|
| optional uint64 p_addr     	| Physical memory address if instruction is a load/store                                             	|
| optional uint32 size       	| Size in bytes of data if instruction is a load/store                                               	|
| optional uint32 flags      	| Flags or attributes of the access, ex. Uncacheable                                                 	|
| required uint64 rob_dep    	| Past instruction number on which there is order (ROB) dependency                                   	|
| required uint64 comp_delay 	| Execution delay between the completion of the last dependency and the execution of the instruction 	|
| repeated uint64 reg_dep    	| Past instruction number on which there is RAW data dependency                                      	|
| optional uint32 weight     	| To account for committed instructions that were filtered out                                       	|
| optional uint64 pc         	| Instruction address, i.e. the program counter                                                      	|
| optional uint64 v_addr     	| Virtual memory address if instruction is a load/store                                              	|
| optional uint32 asid       	| Address Space ID                                                                                   	|


## Minor CPU Model

本文档包含对Minor gem5 有序处理器模型的结构和功能的描述 。

推荐任何想要了解 Minor的内部组织、设计决策、C++ 实现和 Python 配置的人阅读。假设熟悉 gem5 及其一些内部结构。本文档旨在与Minor源代码一起阅读 并解释其一般结构，而不会过于拘泥于命名每个函数和数据类型。

### What is Minor?

Minor是一个有序的处理器模型，具有固定的流水线但可配置的数据结构和执行行为。它旨在用于对具有严格有序执行行为的处理器进行建模，并允许通过 MinorTrace/minorview.py 格式/工具可视化流水线中指令的位置。目的是提供一个框架，用于在微架构上将模型与具有类似功能的特定选定处理器相关联。

### Design Philosophy

#### Multithreading

该模型目前无法进行多线程处理，但在需要排列阶段数据以支持多线程处理的关键位置有 THREAD 注释。

#### Data structures

避免使用大量生命周期信息装饰数据结构。只有指令 ( MinorDynInst ) 包含其值未在构造时设置的大部分数据内容。

所有内部结构在构造时都有固定的大小。保存在队列和 FIFO 中的数据（MinorBuffer、 FUPipeline）应该有一个BubbleIF 接口，以便为每种类型提供不同的"bubble"/"no data value"选项。

级间“结构”数据打包在按值传递的结构中。只有MinorDynInst，在该行的数据ForwardLineData 和存储器接口对象Fetch1 :: FetchRequest 和LSQ :: LSQRequest的 ::new运行模式，同时分配。

### Model structure

MinorCPU类的对象由模型提供给 gem5。MinorCPU实现了（cpu.hh）的接口，可以提供数据和指令接口用于连接缓存系统。该模型通过 Python 以与其他 gem5 模型类似的方式配置。该配置传递给 MinorCPU::pipeline （属于Pipeline类），它实际上实现了处理器流水线。

从MinorCPU向下的主要单元所有权的层次结构如下所示：

```
MinorCPU
--- Pipeline - container for the pipeline, owns the cyclic 'tick' event mechanism and the idling (cycle skipping) mechanism.
--- --- Fetch1 - instruction fetch unit responsible for fetching cache lines (or parts of lines from the I-cache interface).
--- --- --- Fetch1::IcachePort - interface to the I-cache from Fetch1.
--- --- Fetch2 - line to instruction decomposition.
--- --- Decode - instruction to micro-op decomposition.
--- --- Execute - instruction execution and data memory interface.
--- --- --- LSQ - load store queue for memory ref. instructions.
--- --- --- LSQ::DcachePort - interface to the D-ache from Execute.
```

### Key data structures

#### Instruction and line identity: Instld (dyn_inst.hh)

```
- T/S.P/L - for fetched cache lines
- T/S.P/L/F - for instructions before Decode
- T/S.P/L/F.E - for instructions from Decode onwards
```

例如：

```
- 0/10.12/5/6.7
```

InstId字段是：

| Field                    	| Symbol 	| Generated by                                             	| Checked by                                                                                                                                                                                                                                                                                                                                                                                                        	| Function                                                                                                                                                                                          	|
|--------------------------	|--------	|----------------------------------------------------------	|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| InstId::threadId         	| T      	| Fetch1                                                   	| Everywhere the thread number is needed                                                                                                                                                                                                                                                                                                                                                                            	| Thread number (currently always 0).                                                                                                                                                               	|
| InstId::streamSeqNum     	| S      	| Execute                                                  	| Fetch1, Fetch2, Execute (to discard lines/insts)                                                                                                                                                                                                                                                                                                                                                                  	| Stream sequence number as chosen by Execute. Stream sequence numbers change after changes of PC (branches, exceptions) in Execue and are used to separate pre and post brnach instrucion streams. 	|
| InstId::predictionSeqNum 	| Fetch2 	| Fetch2 (while discarding lines after prediction)         	| Prediction sequence numbers represent branch prediction decisions. This is used by Fetch2 to mark lines/instructions/ according to the last followed branch prediction made by Fetch2. Fetch2 can signal to Fetch1 that it should change its fetch address and mark lines with a new prediction sequence number (which it will only do if the stream sequence number Fetch1 expects matches that of the request). 	|                                                                                                                                                                                                   	|
| InstId::lineSeqNum       	| Fetch1 	| (just for debugging)                                     	| Line fetch sequence number of this cache line or the line this instruction was extracted from.                                                                                                                                                                                                                                                                                                                    	|                                                                                                                                                                                                   	|
| InstId::fetchSeqNum      	| Fetch2 	| Fetch2 (as the inst. sequence number for branches)       	| Instruction fetch order assigned by Fetch2 when lines are decomposed into instructions.                                                                                                                                                                                                                                                                                                                           	|                                                                                                                                                                                                   	|
| InstId::execSeqNum       	| Decode 	| Execute (to check instruction identify in queues/FUs/LSQ 	| Instruction order after micro-op decomposition                                                                                                                                                                                                                                                                                                                                                                    	|                                                                                                                                                                                                   	|

序列号字段都是相互独立的，虽然，例如， 指令的InstId::execSeqNum总是 >= InstId::fetchSeqNum，比较没有用。

每个序列号字段的起始阶段为该字段保留一个计数器，该计数器可以递增以生成新的唯一编号。

#### Instructions: MinorDynInst (dyn_inst.hh)

MinorDynInst表示一条指令在流水线中的进展。一条指令可以是三件事：

| Things                	| Predicate                	| Explanation                                                                                                                                                	|
|-----------------------	|--------------------------	|------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| A bubble              	| MinorDynInst::isBubble() 	| no instruction at all, just a space-filler                                                                                                                 	|
| A fault               	| MinorDynInst::isFault()  	| a fault to pass down the pipeline in an insturction’s clothing                                                                                             	|
| A decoded instruction 	| MinorDynInst::isInst()   	| instructions are actually passed to the gem5 decoder in Fetch2 and so are created fully decoded. MinorDynInst::staticInst is the decoded instruction form. 	|

指令使用 gem5 RefCountingPtr ( base/refcnt.hh ) 包装器进行引用计数。因此，它们通常在代码中显示为 MinorDynInstPtr。请注意，当 RefCountingPtr 初始化为 nullptr 而不是支持BubbleIF::isBubble的对象时， 将原始 MinorDynInstPtrs 传递到Queues和其他类似结构的 stage.hh 而不装箱是危险的。

#### ForwardLineData (pipe_data.hh)

ForwardLineData 用于将缓存行从 Fetch1 传递到 Fetch2。与 MinorDynInsts 一样，它们可以是气泡（ForwardLineData::isBubble()）、带有故障的或可以包含由 Fetch1 获取的行（部分行）。ForwardLineData 携带的数据由一个从内存返回的 Packet 对象拥有，并且是显式内存管理的，一旦处理必须删除（通过 Fetch2 删除数据包）。

#### ForwardInstData (pipe_data.hh)

ForwardInstData 在它的ForwardInstData::insts 向量中最多可以包含ForwardInstData::width()指令。该结构用于在 Fetch2、Decode 和 Execute 之间传送指令，并在 Decode 和 Execute 中存储输入缓冲区向量。

#### Fetch1::FetchRequest ( fetch1.hh)

FetchRequests 代表 I-cache 行获取请求。用于 Fetch1 的内存队列，并 在遍历内存系统时从Packet::senderState中推入/弹出。

FetchRequests 包含用于该获取访问的内存系统请求 ( mem/request.hh )、数据包 (Packet, mem/packet.hh )，如果请求到达内存，以及可以填充 TLB 来源的故障字段预取错误（如果有）。

#### LSQ::LSQRequest ( execute.hh)

LSQRequests 类似于 FetchRequests，但用于 D-cache 访问。它们携带与内存访问相关的指令。

### The pipeline

```
------------------------------------------------------------------------------
    Key:

    [] : inter-stage BufferBuffer
    ,--.
    |  | : pipeline stage
    `--'
    ---> : forward communication
    <--- : backward communication

    rv : reservation information for input buffers

                ,------.     ,------.     ,------.     ,-------.
 (from  --[]-v->|Fetch1|-[]->|Fetch2|-[]->|Decode|-[]->|Execute|--> (to Fetch1
 Execute)    |  |      |<-[]-|      |<-rv-|      |<-rv-|       |     & Fetch2)
             |  `------'<-rv-|      |     |      |     |       |
             `-------------->|      |     |      |     |       |
                             `------'     `------'     `-------'
------------------------------------------------------------------------------
```

四级流水线级通过MinorBuffer FIFO（stage.hh，最终派生自TimeBuffer）结构连接在一起，允许对级间延迟进行建模。在前向的相邻阶段之间有一个MinorBuffers（例如：将行从 Fetch1 传递到 Fetch2），并且在 Fetch2 和 Fetch1 之间，在后向方向上有一个承载分支预测的缓冲区。

阶段 Fetch2、Decode 和 Execute 具有输入缓冲区，在每个循环中，这些缓冲区可以接受来自前一阶段的输入数据，并且可以在该阶段未准备好处理该数据时保存该数据。输入缓冲区以与接收数据相同的形式存储数据，因此 Decode 和 Execute 的输入缓冲区包含来自其前一阶段的输出指令向量（ForwardInstData ( pipe_data.hh )），其中指令和气泡位于与单个缓冲区条目相同的位置.

级输入缓冲器提供一个可预留（stage.hh）接口到其以前的阶段，以允许槽在其输入缓冲器被保留，并传达他们的输入缓冲器占用向后以允许前一阶段计划是否应使在输出给定周期。

#### Event handling: MinorActivityRecorder (activity.hh, pipeline.hh)

Minor 本质上是一个周期可调用模型，具有基于流水线活动跳过周期的一些能力。外部事件主要由回调接收（例如Fetch1::IcachePort::recvTimingResp）并导致流水线被唤醒以服务推进请求队列。


## Execution Basics

## Visualization
