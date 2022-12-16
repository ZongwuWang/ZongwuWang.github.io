---
title: Adding custom instruction to Aarch64 ISA and running it on gem5
tags:
- gem5
- 指令扩展
- Aarch64
- ARM-v8
categories: 计算机体系架构
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2021-12-16 16:08:46
---

# Adding custom instruction to RISCV ISA and running it on gem5

本博客基于gem5-X源码进行扩展。

下载gem5-X源代码并创建分支
```shell
git clone https://github.com/ZongwuWang/gem5-X.git
git branch isaExtDemo
git checkout isaExtDemo
# 在修改出现错误时，使用"git checkout ."即可回到当前初始状态
```

## Reference

1. https://nitish2112.github.io/post/adding-instruction-riscv/
2. https://junningwu.haawking.com/tech/2019/11/28/%E4%BD%BF%E7%94%A8Gem5%E8%87%AA%E5%AE%9A%E4%B9%89RISC-V%E6%8C%87%E4%BB%A4%E9%9B%86-%E6%8C%81%E7%BB%AD%E6%9B%B4%E6%96%B0/
3. https://scholarworks.umass.edu/cgi/viewcontent.cgi?article=1262&context=masters_theses_2
4. https://www.eecg.utoronto.ca/~elsayed9/website/blog/gem5_arm_pseudo_inst.php
