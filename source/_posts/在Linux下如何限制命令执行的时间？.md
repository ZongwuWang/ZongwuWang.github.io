---
title: 在Linux下如何限制命令执行的时间？
categories:
  - 系统环境
date: 2023-01-30 14:08:47
tags:
- 命令行
---

在Linux下如何限制命令执行的时间？两种解决方法，如下：

- [Linux命令——timeout](https://blog.csdn.net/xiaqunfeng123/article/details/54315390)
  运行指定的命令，如果在指定时间后仍在运行，则杀死该进程。用来控制程序运行的时间。
- command & pid=$! ;sleep 2;kill -9 $pid


> 本文转载自https://www.cnblogs.com/jingzhishen/p/6758459.html