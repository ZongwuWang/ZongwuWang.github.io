---
title: Ubuntu系统解决上不去github问题
date: 2021-10-26 14:14:39
tags: 系统环境
categories: 系统环境
---

# Ubuntu系统解决上不去github问题

环境： Ubuntu系统，Firefox浏览器

1. 找有效的IP地址

登入网站[https://github.com.ipaddress.com](https://github.com.ipaddress.com), 复制IP地址备用。

2. 修改hosts文件

```bash
sudo vim /etc/hosts
```

打开hosts文件后写入备用的“IP地址+域名”后保存。

> 140.82.112.3 github.com

3. 重启DNS

```bash
sudo /etc/init.d/nscd restart
```
如果出现nscd命令找不到：
```bash
sudo apt-get install nscd
```
成功安装后再重启DNS。

本文转载自：https://blog.csdn.net/weixin_38638559/article/details/115005658
