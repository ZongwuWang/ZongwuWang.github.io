---
title: Linux查看物理CPU个数、核数、逻辑CPU个数(转)
date: 2021-11-01 19:22:41
tags: 系统环境
categories: 系统环境
---

# Linux查看物理CPU个数、核数、逻辑CPU个数(转)

## 基础背景

1. 总核数 = 物理CPU个数 X 每颗物理CPU的核数 
2. 总逻辑CPU数 = 物理CPU个数 X 每颗物理CPU的核数 X 超线程数

## 相关命令

1. 查看物理CPU个数
```shell
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l
```

2. 查看每个物理CPU中core的个数(即核数)
```shell
cat /proc/cpuinfo| grep "cpu cores"| uniq
```

3. 查看逻辑CPU的个数
```shell
cat /proc/cpuinfo| grep "processor"| wc -l
```

## 其他环境命令

1. 查看CPU信息（型号）
```shell
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
```

2. 查看内存信息
```shell
cat /proc/meminfo
```

3. 查看Linux 内核
```shell
uname -a
cat /proc/version
```

4. 查看机器型号（机器硬件型号，需要sudo权限）
```shell
dmidecode | grep "Product Name"
dmidecode
```

5. 查看linux 系统版本
```shell
cat /etc/redhat-release
lsb_release -a
cat  /etc/issue
```

6. 查看linux系统和CPU型号，类型和大小
```shell
cat /proc/cpuinfo
```

7. 查看linux 系统内存大小的信息，可以查看总内存，剩余内存，可使用内存等信息
```shell
cat /proc/meminfo
```