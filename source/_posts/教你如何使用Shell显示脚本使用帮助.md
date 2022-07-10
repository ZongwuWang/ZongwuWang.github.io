---
title: 教你如何使用Shell显示脚本使用帮助
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-05-21 21:06:47
tags:
- Shell
categories: 编程开发
---

## 导读

**日常执行脚本的时候，时间久了不知道脚本的作用和实行了哪些功能，需要重新看脚本源码。因此，需要对脚本做一下输出帮助。**

执行script.sh -h来显示脚本使用帮助。

格式参考：

```shell
###
### my-script — does one thing well
###
### Usage:
###   my-script <input> <output>
###
### Options:
###   <input>   Input file to read.
###   <output>  Output file to write. Use '-' for stdout.
###   -h        Show this message.

help() {
    sed -rn 's/^### ?//;T;p' "$0"
}

if [[ $# == 0 ]] || [[ "$1" == "-h" ]]; then
    help
    exit 1
fi
```

sed -rn 's/^### ?//;T;p' "$0"说明：

	$0：脚本名；
	-rn：使用扩展元字符集，屏蔽默认输出；
	s/^### ?//：匹配### 开头的行，并删掉### ；
	T：若前面替换失败则跳转的sed脚本最后；
	p：输出替换后的结果；

执行script.sh -h：

```shell
[root@test ~]# ./aa.sh -h

my-script — does one thing well

Usage:
  my-script <input> <output>

Options:
  <input>   Input file to read.
  <output>  Output file to write. Use '-' for stdout.
  -h        Show this message.
```

注：本文转载自[教你如何使用Shell显示脚本使用帮助](https://www.linuxprobe.com/shell-out-help.html)