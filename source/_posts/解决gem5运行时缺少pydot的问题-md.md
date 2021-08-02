---
title: 解决gem5运行时缺少pydot的问题.md
date: 2021-08-01 22:50:02
tags:
---

# 解决gem5运行时缺少pydot的问题

在运行gem5时，会显示：

> warn: No dot file generated. Please install pydot to generate the dot file and pdf.

作为一个高度强迫症患者，实在无法忍受每次运行出现这个刺眼的warning，而且在进行系统仿真的时候，产生的config.dot.svg和config.dot.pdf等文件还可以可视化整个系统的架构，为此记录一下我解决这个问题的方法。

在网上搜索博客，基本上都是如下的[解决方案](https://blog.csdn.net/mjl960108/article/details/79981794)：

> sudo apt install python-pydot python-pydot-ng graphviz 

但是运行时会事与愿违：

> root@9187b8755600:~/gem5/m5out# apt install python-pydot python-pydot-ng graphviz 
> Reading package lists... Done
> Building dependency tree
> Reading state information... Done
> E: Unable to locate package python-pydot
> E: Unable to locate package python-pydot-ng

找不到安装包，也有博客指出需要使用pip命令安装，但是ubuntu自带的python无法找到pip命令，而也最好不要使用conda的虚拟python环境，因为无法定位到虚拟环境中的scons命令，这个我至今也没有解决，而是直接安装docker环境，配置python2.7和python3.8，用于不同版本的gem5，非常方便。

为此解决系统python环境缺少pydot的方法如下：

1. 下载[pydot源](https://pypi.org/project/pydot/#files)
> wget https://files.pythonhosted.org/packages/13/6e/916cdf94f9b38ae0777b254c75c3bdddee49a54cc4014aac1460a7a172b3/pydot-1.4.2.tar.gz
2. 解压文件
3. 安装pydot
> python setup.py install (for python2.7)
> python3 setup.py install (for python3.8)

完美解决！！！
