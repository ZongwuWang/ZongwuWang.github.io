---
title: VIM和shell的切换
date: 2021-09-14 15:56:07
tags: 系统环境
categories: 系统环境
---

# VIM和shell的切换

解决vim编辑文件时需要执行系统命令的问题，存在三种方式：

1. ctrl+Z将vim挂起，执行完shell命令之后使用fg将vim返回前台执行。多任务挂起时，先使用jobs参看vim id，然后使用fg %id恢复任务；
2. 在vim normal模式下使用！{shell cmd}执行shell命令，不需要输入{}；
3. 在vim normal模式下使用:shell命令重启一个新的shell，执行完命令后关闭shell返回vim。

## 保存vim会话

保存当前vim编辑状态，以便下次编辑时恢复文件列表、窗口布局、全局变量、选项以及其他信息。

1. 创建一个会话文件，在vim normal模式下输入:mksession vimbook.vim
2. 在vim normal模式下还原保存的会话输入:source vimbook.vim
3. 在启动vim时直接恢复会话：vim -S vimbook.vim

## Reference

[1] https://blog.csdn.net/u014703817/article/details/45741397