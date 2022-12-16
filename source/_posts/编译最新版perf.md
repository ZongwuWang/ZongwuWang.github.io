---
title: 编译最新版perf
categories:
  - 系统环境
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-12-13 14:29:17
tags:
- perf
---

最近在利用perf采样java gc性能时，遇到一个问题：想要采样一个java进程，但是又想限制采样时间。

阅读[perf record manual](https://man7.org/linux/man-pages/man1/perf-record.1.html)发现可以使用 ==--max-size== 选项来实现，但是默认安装的perf版本不支持这一选项，因此基于源码安装最新版perf。

Acme是Linux perf的maintainer，他的perf/core分支包含了perf工具的最新功能。所以如果想体验最新版本的perf，可以下载和编译Acme的perf：

```shell {.line-numbers}
sudo apt install flex bison libelf-dev systemtap-sdt-dev libaudit-dev libslang2-dev libperl-dev libdw-dev
git clone git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux -b perf/core
cd linux/tools/perf
make
```

## References

- http://www.postbits.de/linux-kernel-perf-from-source.html
- https://nanxiao.me/perf-note-6-build-newest-perf/
