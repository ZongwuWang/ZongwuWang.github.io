---
title: mcpat架构性能探究
categories: 计算机体系架构
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-11-18 10:03:27
tags:
- McPAT
- gem5
- Simulator
- Area
- Power
- Timing
---

<!-- TOC -->

- [1. 简介](#1-简介)
- [2. McPAT使用](#2-mcpat使用)
	- [2.1 What McPAT is](#21-what-mcpat-is)
	- [2.2 What McPAT is NOT](#22-what-mcpat-is-not)
	- [2.3 How to use the tool?](#23-how-to-use-the-tool)
- [3. 性能评估结果与分析](#3-性能评估结果与分析)
- [Reference](#reference)

<!-- /TOC -->

## 1. 简介

这篇博客试图通过McPAT工具探索现有CPU中不同模块的面积功耗占比。

## 2. McPAT使用

McPAT: (M)ulti(c)ore (P)ower, (A)rea, and (T)iming

### 2.1 What McPAT is

- 架构集成功耗、面积和时序建模框架，专注于功耗和面积建模，以目标时钟速率作为设计约束
  - 同时考虑功耗、面积和时序
  - 完整的功率范围
  - 电源管理技术(clock gating to reduce dynamic power and power-saving states to reduce static power)
- 众核处理器建模框架
  - 不同的内核、非内核和系统 (I/O) 组件
  - 跨堆栈的整体建模：来自 ITRS 预测的技术模型（也支持用户定义的 vdd），基于现代处理器的处理器建模
- 灵活、可扩展和高（即架构）级别的框架
  - 架构研究框架
  - 灵活使研究人员的生活更轻松
    - 预填充的微架构配置（也可以由有经验的用户更改！）
    - 多级自动优化
  - 易于扩展和移植的分层建模框架
    - 独立的 TDP
    - 与性能模拟器（或机器分析统计数据）配对以进行细粒度研究

### 2.2 What McPAT is NOT

- 硬件设计EDA平台； 也不是性能模拟器
  - McPAT 基于经验和曲线拟合对复杂逻辑和模拟构建块进行建模（高级框架最实用的建模方法），如果关注复杂逻辑或模拟组件的细节，请使用 RTL/SPICE/...（而不是 McPAT）
    - 解决方案 1：用户将这些模型替换为从 EDA 工具中获得的内部模型
    - 解决方案2：用户将他们基于EDA的详细模型贡献回社区共享
  - 使用性能模拟器（如gem5）进行性能模拟（McPAT 不能做性能模拟）
  - 限制性环境
    - 它是一个框架（而不是黑盒工具）
    - 其内置模型供参考和提供方法示例
      - McPAT 的内置模型包括简化的假设（例如，所有指令类型的统一指令窗口）
      - McPAT 提供构建块，因此它是可组合的
      - 用户在使用内置模型或编写自己的模型时应始终了解方法
  
### 2.3 How to use the tool?

McPAT 从基于 XML 的接口获取输入参数，然后计算输入系统的面积和峰值功率。
请注意，峰值功率是绝对最坏情况下的功率，甚至可能高于 TDP。

1. Steps to run McPAT:
   -  define the target processor using inorder.xml or OOO.xml 
   -  run the "mcpat" binary:
      -  ./mcpat -infile <*.xml>  -print_level < level of detailed output>
      -  ./mcpat -h (or mcpat --help) will show the quick help message
2. Optimization:
   McPAT will try its best to satisfy the target clock rate.     When it cannot find a valid solution, it gives out warnings,     while still giving a solution that is closest to the timing     constraints and calculate power based on it. The optimization     will lead to larger power/area numbers for target higher clock    rate. McPAT also provides the option "-opt_for_clk" to turn on     ("-opt_for_clk 1") and off this strict optimization for the     timing constraint. When it is off, McPAT always optimize     component for ED^2P without worrying about meeting the     target clock frequency. By turning it off, the computation time     can be reduced, which suites for situations where target clock rate    is conservative.
3. Outputs:
   McPAT outputs results in a hierarchical manner. Increasing the "-print_level" will show detailed results inside each component. For each component, major parts are shown, and associated pipeline registers/control logic are added up in total area/power of each components. In general, McPAT does not model the area/overhead of the pad     frame used in a processor die.
4. How to use the XML interface for McPAT 
   The XML is hierarchical from processor level to micro-architecture level. McPAT support both heterogeneous and homogeneous manycore processors. 
   1). For heterogeneous processor setup, each component (core, NoC, cache,     		and etc) must have its own instantiations (core0, core1, ..., coreN).     		Each instantiation will have different parameters as well as its stats.Thus, the XML file must have multiple "instantiation" of each type of     		heterogeneous components and the corresponding hetero flags must be set     		in the XML file. Then state in the XML should be the stats of "a" instantiation     		(e.g. "a" cores). The reported runtime dynamic is of a single instantiation     		(e.g. "a" cores). Since the stats for each (e.g. "a" cores) may be different,    		we will see a whole list of (e.g. "a" cores) with different dynamic power,    		and total power is just a sum of them. 
   2). For homogeneous processors, the same method for heterogeneous can     		also be used by treating all homogeneous instantiations as heterogeneous.     		However, a preferred approach is to use a single representative for all     		the same components (e.g. core0 to represent all cores) and set the     		processor to have homogeneous components (e.g. <param name="homogeneous_cores    		" value="1"/> ). Thus, the XML file only has one instantiation to represent     		all others with the same architectural parameters. The corresponding homo     		flags must be set in the XML file.  Then, the stats in the XML should be     		the aggregated stats of the sum of all instantiations (e.g. aggregated stats     		of all cores). In the final results, McPAT will only report a single     		instantiation of each type of component, and the reported runtime dynamic power    		is the sum of all instantiations of the same type. This approach can run fast     		and use much less memory.
5. Guide for integrating McPAT into performance simulators and bypassing the XML interface
   The detailed work flow of McPAT has two phases: the initialization phase and    the computation phase. Specifically, in order to start the initialization phase a     user specifies static configurations, including parameters at all three levels,     namely, architectural, circuit, and technology levels. During the initialization     phase, McPAT will generate the internal chip representation using the configurations     set by the user.
   The computation phase of McPAT is called by McPAT or the performance simulator     during simulation to generate runtime power numbers. Before calling McPAT to     compute runtime power numbers, the performance simulator needs to pass the     statistics, namely, the activity factors of each individual components to McPAT     via the XML interface.
   The initialization phase is very time-consuming, since it will repeat many     times until valid configurations are found or the possible configurations are     exhausted. To reduce the overhead, a user can let the simulator to call McPAT     directly for computation phase and only call initialization phase once at the     beginning of simulation. In this case, the XML interface file is bypassed,     please refer to processor.cc to see how the two phases are called.
6. Sample input files:
   This package provide sample XML files for validating target processors. Please find the 
   enclosed Niagara1.xml (for the Sun Niagara1 processor), Niagara2.xml (for the Sun Niagara2 
   processor), Alpha21364.xml (for the Alpha21364 processor), Xeon.xml (for the Intel 
   Xeon Tulsa processor), and ARM_A9_2GHz.xml (for ARM Cortex A9 hard core 2GHz implementation from 
   ARM)
7. Modeling of power management techniques: 
   McPAT supports both DVS and power-gating. For DVS, users can use default ITRS projected vdd     at each technology node as supply voltage at DVS level 0 (DVS0) or define voltage at DVS0.     For power-gating, McPAT supports both default power-saving virtual supply voltage computed     automatically using technology parameters. Default means using technology (ITRS based)     lowest value for state-retaining power-gating User can also defined voltage for Power-saving states,     as shown in example file of Xeon.xml (search for power_gating_vcc). When using user-defined power-saving     virtual supply voltage, please understand the implications when setting up voltage for different sleep states.     For example, when deep sleep state is used (voltage lower than the technology allowed state retaining supply voltage),     the effects of losing data and cold start effects (beyond the scope of McPAT) must be considered when waking up the architecture.
   Power-gating and DVS cannot happen at the same time. Because power-gating happens when circuit is idle, while DVS happens when     circuit blocks are active. 



## 3. 性能评估结果与分析

TODO: 分析ARM-v8和Intel先进架构各个模块的面积、功耗，并与实际展示结果进行精度对比。


## Reference

- https://github.com/ZongwuWang/mcpat.git
-  @inproceedings{mcpat:micro,
 author = {Sheng Li and Jung Ho Ahn and Richard D. Strong and Jay B. Brockman and Dean M. Tullsen and Norman P. Jouppi},
 title =  "{McPAT: An Integrated Power, Area, and Timing Modeling Framework for Multicore and Manycore Architectures}",
 booktitle = {MICRO 42: Proceedings of the 42nd Annual IEEE/ACM International Symposium on Microarchitecture},
 year = {2009},
 pages = {469--480},
 }
