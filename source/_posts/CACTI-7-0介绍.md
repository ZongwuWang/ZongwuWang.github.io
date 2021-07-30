---
title: CACTI 7.0介绍
date: 2021-07-29 01:13:38
tags: 计算机体系架构
---

# CACTI 7.0介绍

## 1. CACTI发展
CACTI是HP公司推出的一款开源开源工具，广泛应用于对cache/DRAM的延时，功耗，cycle time[^1]和面积的评估。

[^1]: <font color=gray>(暂时不知道如何翻译比较好，感觉前面的延时指的是各个部分的延时信息，这边的cycle time应该指的是访问周期)</font>

CACTI最初由Dr. Jouppi和Dr. Wilton于1993年开发，此后经历了六次版本的迭代。

## 2. CACTI支持的特性

- 以下memory的功耗、延时、cycle time的建模
  - direct mapped caches
  - set-associative caches
  - fully associative caches
  - Embedded DRAM memories
  - Commodity DRAM memories
- 多端口UCA(uniform cache access)，多端口的NUCA(non-uniform cache access)的建模
- 工作温度对泄露功耗的影响
- 路由功耗模型
- 具有不同延迟、功耗和面积属性的互连模型，包括低摆幅线模型
- 用于执行功率、延迟、面积和带宽之间权衡分析的接口
- 该工具使用的所有工艺特定值均从 ITRS 获得，目前该工具支持 90nm、65nm、45nm 和 32nm 技术节点
- 用于计算DDR总线延迟和能量的芯片IO模型。用户可以模拟不同的负载（扇出）并评估对频率和能量的影响。该模型可用于研究LR-DIMM、R-DIMM等。
- Version 7.0在6.5版本的基础之上还融合了CACTI 3D

## 3. CACTI的使用方法

```bash
git clone https://github.com/HewlettPackard/cacti
cd cacti
# modify the xxx.cfg for self configuration
make
./cacti -infile xxx.cfg
```
