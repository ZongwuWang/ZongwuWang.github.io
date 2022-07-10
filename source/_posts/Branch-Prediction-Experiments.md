---
title: Branch Prediction Experiments
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-04-06 15:14:49
tags:
- 分支预测
categories: 计算机体系架构
---

## 一、 问题概述

现在的分支预测技术都依赖于片上动态学习，但是OS会有时间片的概念，Linux每5~800ms会切换一次进程。因此，切换进程回导致针对当前应用程序学习到的精度下降（模型的泛化性不高）。

## 二、 实验设置

- 如何获取实际硬件的分支预测准确率？
- 如何仿真分支预测准确率？
- 如何评估线程切换导致的分支预测率抖动？

1. 评估不同分支预测器准确度可以使用intel提供的pin工具生成trace，然后使用ChampSim进行仿真。但是，如何获取实际Intel CPU的分支预测准确度呢？

在网上查到以下几种方式：

- [使用Intel Vtune](https://community.intel.com/t5/Analyzers/How-to-measure-Branch-Mispredict-Rate-in-Vtune/m-p/1304964)(https://community.intel.com/t5/Analyzers/Calculation-of-branch-misprediction/m-p/781430)
- 