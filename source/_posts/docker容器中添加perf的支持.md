---
title: docker容器中添加perf的支持
categories:
  - 系统环境
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2023-01-06 16:04:59
tags:
- docker
- perf
---

1. [Run docker with --cap-add SYS_ADMIN](https://stackoverflow.com/questions/44745987/use-perf-inside-a-docker-container-without-privileged)
2. 在[容器中安装perf](https://stackoverflow.com/questions/46674444/is-it-possible-to-run-linux-perf-tool-inside-docker-container)，以ubuntu 20.04为例：
   ```shell {.line-numbers}
   apt-get install linux-tools-generic
   ln -s /usr/lib/linux-tools/3.13.0-141-generic/perf /usr/bin/perf
   ```