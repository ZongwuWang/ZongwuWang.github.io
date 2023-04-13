---
title: gdb 调试glibc源码
categories:
  - 编程开发
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2023-02-11 16:21:51
tags:
- glibc
- gdb
---

最近为了研究自旋锁和互斥锁的内部实现机制，需要调试glibc的源码，在此记录glibc源码调试的过程。

## 1. 确定当前系统的glibc版本

首先需要确定当前系统glibc的版本，这可以通过以下两种方式实现：

```shell {.line-numbers}
$ ldd --version
ldd (Ubuntu GLIBC 2.31-0ubuntu9.9) 2.31
Copyright (C) 2020 自由软件基金会。
这是一个自由软件；请见源代码的授权条款。本软件不含任何没有担保；甚至不保证适销性
或者适合某些特殊目的。
由 Roland McGrath 和 Ulrich Drepper 编写。
$ /lib/x86_64-linux-gnu/libc.so.6
GNU C Library (Ubuntu GLIBC 2.31-0ubuntu9.9) stable release version 2.31.
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 9.4.0.
libc ABIs: UNIQUE IFUNC ABSOLUTE
For bug reporting instructions, please see:
<https://bugs.launchpad.net/ubuntu/+source/glibc/+bugs>.
```

## 2. 下载glibc源码，并切换到相应版本

```shell {.line-numbers}
$ git clone https://github.com/bminor/glibc.git
$ cd glibc
$ git checkout release/2.31/master
```

## 3. 编译带调试信息的可执行文件，并设置glibc源码路径

使用`-g`编译，在gdb命令行中通过`directory <glibc_path>`设置glibc源码路径。
在[^1]中，作者使用的是glibc的根路径，但是在我复现的时候，没办法关联到对应的文件。但是在step in到glibc的函数时，会提示在某个文件的某一行，可以通过`find`在glibc源码路径下进一步定位到子目录。
可以使用`show directories`查看设置的结果。

```shell {.line-numbers}
(gdb) show directories 
Source directories searched: /root/glibc/nptl:$cdir:$cwd
```

[^1]: [vscode + ubuntu调试glibc源码](https://www.bilibili.com/video/BV1RZ4y187ts)