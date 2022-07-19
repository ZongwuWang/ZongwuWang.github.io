---
title: DynamoRIO使用说明
categories: 计算机体系架构
date: 2022-07-15 20:41:52
tags:
- DynamoRIO
- 二进制插桩
- 性能分析
---

1. 从[DynamoRIO Repository](https://github.com/DynamoRIO/dynamorio/releases)下载安装包，并解压

```shell {.line-numbers}
wget https://github.com/DynamoRIO/dynamorio/releases/download/cronbuild-9.0.19181/DynamoRIO-Linux-9.0.19181.tar.gz
tar xzvf DynamoRIO-Linux-9.0.19181.tar.gz
cd DynamoRIO-Linux-9.0.19181
```

2. 构建工具

```shell {.line-numbers}
mkdir build
cd build
cmake -DDynamoRIO_DIR=../cmake ../samples	# 构建samples中的samples工具到build/bin路径中
make
```

3. 运行

```shell {.line-numbers}
cd $DynamoRIO_HOME
./bin64/drrun -c build/bin/libmemtrace_x86_text.so -- ls	# 在build/bin中存在运行log
```

## Reference

- [How to Build a Tool](https://dynamorio.org/page_build_client.html)
- [dynamoRIO的基本使用(毕设笔记2)](https://blog.csdn.net/fenggang2333/article/details/113054565)
- [CGO 2017 Tutorial: Building Dynamic Tools with DynamoRIO on x86 and ARMv8](https://dynamorio.org/page_tutorial_cgo17.html)