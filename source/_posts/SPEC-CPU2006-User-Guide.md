---
title: SPEC CPU2006 User Guide
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-05-21 05:18:54
tags:
- SPEC
- CPU2006
- Benchmark
categories: 计算机体系架构
---

## SPEC CPU2006简介

SPEC是标准性能评估公司（Standard Performance Evaluation Corporation）的简称。SPEC是由计算机厂商、系统集成商、大学、研究机构、咨询等多家公司组成的非营利性组织，这个组织的目标是建立、维护一套用于评估计算机系统的标准。

在早些年，业界使用的是其上一个版本SPEC CPU 2000。和SPEC CPU 2000一样，SPEC CPU 2006包括了CINT2006和C FP2006两个子项目，前者用于测量和对比整数性能，而后者则用于测量和对比浮点性能，SPEC CPU 2006中对SPEC CPU 2000中的一些测试进行了升级，并抛弃/加入了一些测试，因此两个版本测试得分并没有可比较性。

SPEC CPU测试中，测试系统的处理器、内存子系统和使用到的编译器（SPEC CPU提供的是源代码，并且允许测试用户进行一定的编译优化）都会影响最终的测试性能，而I/O（磁盘）、网络、操作系统和图形子系统对于SPEC CPU2006的影响非常的小。

An ounce of honest data is worth a pound of marketing hype（一盎司诚实的数据值得一磅的市场宣传）是SPEC组织成立的座右铭，为了保持数据的公平、可信度以及有效，SPEC CPU测试使用了现实世界的应用程序，而不是用循环的算术操作来进行基准测试。SPEC CPU 2006包括了12项整数运算和17项浮点运算，除此之外，还有两个随机数产生测试程序998.sperand（整数）和999.specrand（浮 点），它们虽然也包含在套件中并得到运行，但是它们并不进行计时以获得得分。这两个测试主要是用来验证一些其他组件中会用到的PRNG随机数生成功能的正确性。各个测试组件基本上由C和Fortran语言编写，有7个测试项目使用了C++语言，而Fortran语言均用来编写浮点部分。

CINT2006包括C编译程序、量子计算机仿真、下象棋程序等，CFP2006包括有限元模型结构化网格法、分子动力学质点法、流体动力学稀疏线性代数法等。为了简化测试结果，SPEC决定使用单一的数字来归纳所有12种整数基准程序。具体方法是将被测计算机的执行时间标准化，即将被测计算机的执行时间除一个参考处理器的执行时间，结果称为SPECratio。SPECratio值越大，表示性能越快（因为SPECratio是执行时间的倒数）。CINT2006或CFP2006的综合测试结果是取SPECratio的几何平均值。

以下是SPEC CPU 2006具体的测试项目和说明:

**SPEC CPU 2006 v1.0.1测试项目**

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky">子项目</th>
    <th class="tg-0pky">语言</th>
    <th class="tg-0pky">原型/组件</th>
    <th class="tg-0pky">说明</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0pky" colspan="4">整数测试</td>
  </tr>
  <tr>
    <td class="tg-0pky">400.perlbenchPERL编程语言</td>
    <td class="tg-0pky">ANSI C</td>
    <td class="tg-0pky">Perl v5.8.7 SpamAssassin v2.61Digest-MD5 v2.33HTML-Parser v3.35MHonArc v2.6. 8IO-stringy v1.205MailTools v1.60TimeDate v1.16</td>
    <td class="tg-0pky">负载由三个script组成：主负载是垃圾邮件检测软件SpamAssassin，一个是email到HTML的转换器MHonArc，最后一个是specdiff</td>
  </tr>
  <tr>
    <td class="tg-0pky">401.bzip2<br>压缩</td>
    <td class="tg-0pky">ANSI C</td>
    <td class="tg-0pky">bzip2 v1.0.3</td>
    <td class="tg-0pky">负载包括六个部分：<br>两个小的JPEG图片<br>一个程序<br>一个tar包起的几个源程序文件<br>一个HTML文件<br>混合文件，包括压缩起来的高可压缩文件及不怎么可压缩的文件<br>测试分别使用了三个不同的压缩等级进行压缩和解压缩</td>
  </tr>
  <tr>
    <td class="tg-0pky">403.gcc<br>C编译器</td>
    <td class="tg-0pky">C</td>
    <td class="tg-0pky">gcc v3.2</td>
    <td class="tg-0pky">对9组C代码进行了编译</td>
  </tr>
  <tr>
    <td class="tg-0pky">429.mcf<br>组合优化</td>
    <td class="tg-0pky">ANSI C w/libm</td>
    <td class="tg-0pky">MCF v1.2</td>
    <td class="tg-0pky">MCF是一个用于大型公共交通中的单站车辆调度的程序<br>429.mcf运行于32/64位模型时分别需要约860/1700MB的内存</td>
  </tr>
  <tr>
    <td class="tg-0pky">445.gobmk<br>人工智能：围棋</td>
    <td class="tg-0pky">C</td>
    <td class="tg-0pky"></td>
    <td class="tg-0pky">围棋</td>
  </tr>
  <tr>
    <td class="tg-0pky">456.hmmer<br>基因序列搜索</td>
    <td class="tg-0pky">C</td>
    <td class="tg-0pky"></td>
    <td class="tg-0pky">使用HMMS(Hidden Markov Models，隐马尔科夫模型) 基因识别方法进行基因序列搜索</td>
  </tr>
  <tr>
    <td class="tg-0pky">458.sjeng<br>人工智能：国际象棋</td>
    <td class="tg-0pky">ANSI C</td>
    <td class="tg-0pky">Sjeng v11.2</td>
    <td class="tg-0pky">国际象棋</td>
  </tr>
  <tr>
    <td class="tg-0pky">462.libquantum<br>物理：量子计算</td>
    <td class="tg-0pky">ISO/IEC 9899:1999("C99")</td>
    <td class="tg-0pky"></td>
    <td class="tg-0pky">libquantum是模拟量子计算机的库文件，用来进行量子计算机应用的研究</td>
  </tr>
  <tr>
    <td class="tg-0pky">464.h264ref<br>视频压缩</td>
    <td class="tg-0pky">C</td>
    <td class="tg-0pky">h264avc v9.3</td>
    <td class="tg-0pky">使用两种配置对两个YUV格式源文件进行H.264编码</td>
  </tr>
  <tr>
    <td class="tg-0pky">471.omnetpp<br>离散事件仿真</td>
    <td class="tg-0pky">C++</td>
    <td class="tg-0pky">OMNeT++</td>
    <td class="tg-0pky">包括约8000台计算机和900个交换机/集线器，以及混合了各种从10Mb到1000Mb速率的大型CSMA/CD协议以太网络模拟</td>
  </tr>
  <tr>
    <td class="tg-0pky">473.astar<br>寻路算法</td>
    <td class="tg-0pky">C++</td>
    <td class="tg-0pky"></td>
    <td class="tg-0pky">实现了2D寻路算法A*的三种不同版本</td>
  </tr>
  <tr>
    <td class="tg-0pky">483.xalancbmk<br>XML处理</td>
    <td class="tg-0pky">C++</td>
    <td class="tg-0pky">Xalan-C++ v1.8 mod<br>Xerces-C++ v2.5.0</td>
    <td class="tg-0pky">XML文档/XSL表到HTML文档的转换</td>
  </tr>
  <tr>
    <td class="tg-0pky" colspan="4">浮点测试</td>
  </tr>
  <tr>
    <td class="tg-0pky">410.bwaves<br>流体力学</td>
    <td class="tg-0pky">Fortran 77</td>
    <td class="tg-0pky"></td>
    <td class="tg-0pky">对三维瞬跨音速粘性流中冲击波的模拟计算</td>
  </tr>
  <tr>
    <td class="tg-0pky">416.gamess<br>量子化学</td>
    <td class="tg-0pky">Fortran</td>
    <td class="tg-0pky">GMAESS</td>
    <td class="tg-0pky">三种SCF自洽场计算：<br>胞嘧啶分子<br>水和Cu2+离子<br>三唑离子</td>
  </tr>
  <tr>
    <td class="tg-0pky">433.milc<br>量子力学</td>
    <td class="tg-0pky">C</td>
    <td class="tg-0pky">MILC</td>
    <td class="tg-0pky">四维SU(3)格点规范理论的模拟，用来研究QCD量子色动力学、夸克及胶子</td>
  </tr>
  <tr>
    <td class="tg-0pky">434.zeusmp<br>物理：计算流体力学</td>
    <td class="tg-0pky">Fortran 77/REAL*8</td>
    <td class="tg-0pky">ZEUS-MP</td>
    <td class="tg-0pky">用来计算理想、非相对论条件下的流体力学和磁流体力学，434.zeusmp模拟计算了一个统一磁场中的3D冲击波</td>
  </tr>
  <tr>
    <td class="tg-0pky">435.gromacs<br>生物化学/分子力学</td>
    <td class="tg-0pky">C &amp; Fortran</td>
    <td class="tg-0pky">GROMACS</td>
    <td class="tg-0pky">GROMACS是一个分子力学计算套件，然而也可以用于非生物系统，435.gromacs模拟了在一个水和离子溶液中的蛋白质溶菌酶结构在各种实验手段如核磁共振的X光照射下的变化</td>
  </tr>
  <tr>
    <td class="tg-0pky">436.cactusADM<br>物理：广义相对论</td>
    <td class="tg-0pky">Fortran 90, ANSI C</td>
    <td class="tg-0pky">Cactus<br>BenchADM</td>
    <td class="tg-0pky">436.cactusADM对时空曲率由内部物质决定的爱因斯坦演化方程进行求解，爱因斯坦演化方程由10个标准ADM 3+1分解的二阶非线性偏微分方程组成。</td>
  </tr>
  <tr>
    <td class="tg-0pky">437.leslie3d<br>流体力学</td>
    <td class="tg-0pky">Fortran 90</td>
    <td class="tg-0pky">LESlie3d</td>
    <td class="tg-0pky">LESlie3d是用来计算湍流的计算流体力学程序，437.leslie3d计算了一个如燃油注入燃烧室的时间分层混合流体。</td>
  </tr>
  <tr>
    <td class="tg-0pky">444.namd<br>生物/分子</td>
    <td class="tg-0pky">C++</td>
    <td class="tg-0pky">NAMD</td>
    <td class="tg-0pky">NAMD是一个大型生物分子系统并行计算程序，444.namd模拟了了92224个原子组成的A-I载脂蛋白</td>
  </tr>
  <tr>
    <td class="tg-0pky">447.dealII<br>有限元分析</td>
    <td class="tg-0pky">C++ w/Boost lib</td>
    <td class="tg-0pky">deal.II lib</td>
    <td class="tg-0pky">deal.II是定位于自适应有限元及误差估计的C++库，447.dealII对非常系数的亥姆霍兹方程进行求解，它使用了基于二元加权误差估计生成最佳网格的自适应方法，该方程在3维得解</td>
  </tr>
  <tr>
    <td class="tg-0pky">450.soplex<br>线形编程、优化</td>
    <td class="tg-0pky">ANSI C++</td>
    <td class="tg-0pky">SoPlex v1.2.1</td>
    <td class="tg-0pky">SoPlex使用单纯形算法解线性方程</td>
  </tr>
  <tr>
    <td class="tg-0pky">453.povray<br>影像光线追踪</td>
    <td class="tg-0pky">ISO C++</td>
    <td class="tg-0pky">POV-Ray</td>
    <td class="tg-0pky">POV-Ray是一个光线追踪渲染软件，453.povray渲染一幅1280x1024的反锯齿国际象棋棋盘图像</td>
  </tr>
  <tr>
    <td class="tg-0pky">454.calculix<br>结构力学</td>
    <td class="tg-0pky">Fortran 90 &amp; C w/SPOOLES code</td>
    <td class="tg-0pky">CalculiX</td>
    <td class="tg-0pky">CalculiX是一个用于线性及非线性三位结构力学的有限元分析软件，454.calculix计算了一个高速旋转的压缩盘片在离心力的作用下的应力和变形情况</td>
  </tr>
  <tr>
    <td class="tg-0pky">459.GemsFDTD<br>计算电磁学</td>
    <td class="tg-0pky">Fortran 90</td>
    <td class="tg-0pky">GmesTD from GEMS</td>
    <td class="tg-0pky">459.GemsFDTD使用FDTD（有限差分时域）方法求解三维时域中的麦克斯韦方程，计算了一个理想导体的雷达散射截面</td>
  </tr>
  <tr>
    <td class="tg-0pky">465.tonto<br>量子化学</td>
    <td class="tg-0pky">Fortran 95</td>
    <td class="tg-0pky">Tonto</td>
    <td class="tg-0pky">Tonto是一个面向对象的量子化学程序包，465.tonto计算面向量子晶体学，它基于一个符合X光衍射实验数据的、约束的分子Hartree-Fock波函数</td>
  </tr>
  <tr>
    <td class="tg-0pky">470.lbm<br>流体动力学</td>
    <td class="tg-0pky">ANSI C</td>
    <td class="tg-0pky"></td>
    <td class="tg-0pky">470.lbm使用LBM（格子波尔兹曼方法）模拟非压缩流体，它模拟了两种情况：类似活塞推动的剪切驱动流体和管道流体，测试包含了3000个步骤</td>
  </tr>
  <tr>
    <td class="tg-0pky">481.wrf<br>天气预报</td>
    <td class="tg-0pky">Fortran 90 &amp; C</td>
    <td class="tg-0pky">WRF v2.0.2</td>
    <td class="tg-0pky">481.wrf基于WRF(Weather Research and Forecastin)模型，对NCAR的数据进行了计算，数据包括了UTC 2001.06.11到UTC 2001.06.12以三小时为间隔的数据</td>
  </tr>
  <tr>
    <td class="tg-0pky">482.sphinx3<br>语音识别</td>
    <td class="tg-0pky">C</td>
    <td class="tg-0pky">Sphinx-3</td>
    <td class="tg-0pky">语音识别</td>
  </tr>
</tbody>
</table>

SPEC CPU2006的详细文档参考[^1].

## SPEC CPU2006安装

### 系统需求

SPEC CPU2006安装的系统需求可参考[^2]，系统最好选择Linux，并且选择硬盘、内存空间足够的服务器。
这边最重要的一点是SPEC CPU2006属于早期版本，因此需要确保工具链适配。
> Since SPEC supplies only source code for the benchmarks, you will need either:
> A set of compilers for the result(s) you intend to measure:
> For SPECint2006: Both C99 and C++98 compilers
> For SPECfp2006: All three of C99, C++98 and Fortran-95 compilers
> --or--
> A pre-compiled set of benchmark executables, given to you by another user of the same revision of SPEC CPU2006, and any run-time libraries that may be required for those executables.
> Please notice that you cannot generate a valid CPU2006 result unless you meet all of requirement E.1.a, or E.1.b, or E.1.c. For example, if you are attempting to build the floating point suite but lack a Fortran-95 compiler, you will not be able to measure a SPECfp2006 result.

这边简单列举本次安装的软硬件环境：

```shell
$ uname -a
Linux yangrui-PowerEdge-R840 4.15.0-142-generic #146~16.04.1-Ubuntu SMP Tue Apr 13 09:27:15 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
$ gcc -v
gcc version 4.8.5 (Ubuntu 4.8.5-4ubuntu2)
$ g++ -v 
gcc version 4.8.5 (Ubuntu 4.8.5-4ubuntu2)
```

安装时仅需要gcc和g++就可以，但是真正编译benchmark时还需要gfortran。这边要确保使用低版本的编译工具链。

### 安装步骤[^3]

1. Review Pre-requisites
2. Create destination. Have enough space, avoid space
3. Mount the DVD
   购买之后会受到一个iso文件下载链接，下载之后进行mount
   ```shell
   mount -o loop cpu2006.iso <mount destination>
   ```
4. 安装
   运行./install.sh进行安装，会使用默认的安装位置和toolset，可以通过以下参数进行修改，一般toolset不需要修改，会自动检测出当前系统的toolset。

	```shell
	Usage: ./install.sh [-e toolset,...] [-d dest_dir] [-u toolset]
	-e toolset,...          List names of toolsets to _NOT_ use
	-u toolset              Specify the name of the toolset to use
	-d dest_dir             Specify the destination directory for installation
	-f                      Perform non-interactive installation if possible
	```

5. 简单测试是否安装成功
   
   ```shell
   cd $SPEC
   source shrc
   # Try to build one benchmark
   cd $SPEC/config
   cp Example-linux64-amd64-gcc43+.cfg my.cfg
   runspec --config=my.cfg --action=build --tune=base bzip2
   # Try running one benchmark with the teset dataset
   runspec --config=my.cfg --size=test --noreportable --tune=base --iterations=1 bzip2
   # Try a real dataset
   runspec --config=my.cfg --size=ref --noreportable --tune=base --iterations=1 bzip2
   # Try a full (reportable) run
   runspec --tune=base --config=my.cfg int
   ```

SPEC CPU2006的运行使用runspec命令，需要通过shrc/cshrc设置环境变量。runspec的使用可参考[^4]。


## gem5运行SPEC CPU2006

本次实验采用的时ARM架构，由于SPEC CPU2006本身并没有加入对ARM架构的config支持，因此在流程上需要有一些微调。

### SPEC CPU2006静态交叉编译

由于gem5是虚拟了一个ARM架构的CPU，因此使用gem5仿真SE模式或是FS模式的ARM架构都需要进行静态编译，防止运行时缺少动态库。(FS采用的linux内核并不一定包含动态库，即使包含了动态库版本可能还有问题。) 

使用交叉编译首先需要安装对应的工具链，即aarch64-linux-gnu-交叉编译工具链。一种方式是直接使用apt安装默认的gnu工具链，但是会存在两个问题：

- 工具链版本不能使用默认的高版本
- 工具链中不包含aarch64-linux-gnu-gfortran

因此，这边选用了gcc-linaro-4.9.4-2017.01-x86_64_aarch64-linux-gnu工具链，安装包可以在其官网下载，然后解压使用。如果系统没有安装默认gnu工具链，则可以直接使用环境变量定义工具链路径，如果已经安装默认工具链，则需要使用update-alternative修改默认工具。

完成静态编译则比较简单，安装合适工具链之后，通过config文件中两处修改即可完成静态交叉编译的配置。

```shell
# 支持交叉编译
CC                 = aarch64-linux-gnu-gcc
CXX                = aarch64-linux-gnu-g++
FC                 = aarch64-linux-gnu-gfortran
# 支持静态编译
COPTIMIZE   = -O2 -fno-strict-aliasing -static
CXXOPTIMIZE = -O2 -fno-strict-aliasing -static
FOPTIMIZE   = -O2 -fno-strict-aliasing -static
```

同样使用runspec命令进行静态编译，并生成运行的配置文件，这边为了方便编写了build_setup.sh脚本。

```shell
 #!/bin/bash

# $1: <arm|amd>
# $2: <bzip2 default>

if [ -x$1 != x ]
then
    arch=$1
else
    arch=amd
fi
if [ -x$2 != x ]
then
    bench=$2
else
    bench=bzip2
fi

echo arch=$arch

echo bench=$bench

runspec --config=my_${arch}64.cfg --action=build --tune=base ${bench}
runspec --config=my_${arch}64.cfg --action=setup --size=test --noreportable --tune=base --iterations=1 ${bench}
```

如生成arm架构的CINT配置，直接运行"./build_setup.sh arm int"命令，就会在各个bench目录下生成run文件夹。

### gem5运行设置

这边主要参考$GEM5/config/example/se.py的过程进行bench程序的配置，网上大多都是参考Mark Gottscho 2014年的一篇博客[^5]，其中中文博客可以参考[^6]和[^7]。

配置文件spec06_config.py
首先，从config/example/se.py配置文件中复制一个配置文件spec_config.py。并对其进行更改。

{% folding green close, spec06_config.py %}
```python
# Copyright (c) 2012-2013 ARM Limited
# All rights reserved.
#
# The license below extends only to copyright in the software and shall
# not be construed as granting a license to any other intellectual
# property including but not limited to intellectual property relating
# to a hardware implementation of the functionality of the software
# licensed hereunder.  You may use the software subject to the license
# terms below provided that you ensure that this notice is replicated
# unmodified and in its entirety in all distributions of the software,
# modified or unmodified, in source code or in binary form.
#
# Copyright (c) 2006-2008 The Regents of The University of Michigan
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met: redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer;
# redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution;
# neither the name of the copyright holders nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Simple test script
#
# "m5 test.py"

from __future__ import print_function
from __future__ import absolute_import

# import optparse
import argparse
import sys
import os

import m5
from m5.defines import buildEnv
from m5.objects import *
from m5.params import NULL
from m5.util import addToPath, fatal, warn

addToPath('../')

from ruby import Ruby

from common import Options
from common import Simulation
from common import CacheConfig
from common import CpuConfig
from common import ObjectList
from common import MemConfig
from common.FileSystemConfig import config_filesystem
from common.Caches import *
from common.cpu2000 import *
import spec06_benchmarks

def get_processes(options):
    """Interprets provided options and returns a list of processes"""

    multiprocesses = []
    outputs = []
    errouts = []

    workloads = options.benchmark.split(';')

    if options.benchmark_stdout != "":
        outputs = options.benchmark_stdout.split(';')
    elif options.output != "":
        outputs = options.output.split(';')

    if options.benchmark_stderr != "":
        errouts = options.benchmark_stderr.split(';')
    elif options.errout != "":
        errouts = options.errout.split(';')

    idx = 0
    for wrkld in workloads:
        if wrkld:
            print('Selected SPEC_CPU2006 benchmark')
            if wrkld == 'perlbench':
                print('--> perlbench')
                process = spec06_benchmarks.perlbench
            elif wrkld == 'bzip2':
                print('--> bzip2')
                process = spec06_benchmarks.bzip2
            elif wrkld == 'gcc':
                print
                '--> gcc'
                process = spec06_benchmarks.gcc
            elif wrkld == 'bwaves':
                print
                '--> bwaves'
                process = spec06_benchmarks.bwaves
            elif wrkld == 'gamess':
                print
                '--> gamess'
                process = spec06_benchmarks.gamess
            elif wrkld == 'mcf':
                print
                '--> mcf'
                process = spec06_benchmarks.mcf
            elif wrkld == 'milc':
                print
                '--> milc'
                process = spec06_benchmarks.milc
            elif wrkld == 'zeusmp':
                print
                '--> zeusmp'
                process = spec06_benchmarks.zeusmp
            elif wrkld == 'gromacs':
                print
                '--> gromacs'
                process = spec06_benchmarks.gromacs
            elif wrkld == 'cactusADM':
                print
                '--> cactusADM'
                process = spec06_benchmarks.cactusADM
            elif wrkld == 'leslie3d':
                print
                '--> leslie3d'
                process = spec06_benchmarks.leslie3d
            elif wrkld == 'namd':
                print
                '--> namd'
                process = spec06_benchmarks.namd
            elif wrkld == 'gobmk':
                print
                '--> gobmk'
                process = spec06_benchmarks.gobmk
            elif wrkld == 'dealII':
                print
                '--> dealII'
                process = spec06_benchmarks.dealII
            elif wrkld == 'soplex':
                print
                '--> soplex'
                process = spec06_benchmarks.soplex
            elif wrkld == 'povray':
                print
                '--> povray'
                process = spec06_benchmarks.povray
            elif wrkld == 'calculix':
                print
                '--> calculix'
                process = spec06_benchmarks.calculix
            elif wrkld == 'hmmer':
                print
                '--> hmmer'
                process = spec06_benchmarks.hmmer
            elif wrkld == 'sjeng':
                print
                '--> sjeng'
                process = spec06_benchmarks.sjeng
            elif wrkld == 'GemsFDTD':
                print
                '--> GemsFDTD'
                process = spec06_benchmarks.GemsFDTD
            elif wrkld == 'libquantum':
                print
                '--> libquantum'
                process = spec06_benchmarks.libquantum
            elif wrkld == 'h264ref':
                print
                '--> h264ref'
                process = spec06_benchmarks.h264ref
            elif wrkld == 'tonto':
                print
                '--> tonto'
                process = spec06_benchmarks.tonto
            elif wrkld== 'lbm':
                print
                '--> lbm'
                process = spec06_benchmarks.lbm
            elif wrkld == 'omnetpp':
                print
                '--> omnetpp'
                process = spec06_benchmarks.omnetpp
            elif wrkld == 'astar':
                print
                '--> astar'
                process = spec06_benchmarks.astar
            elif wrkld == 'wrf':
                print
                '--> wrf'
                process = spec06_benchmarks.wrf
            elif wrkld == 'sphinx3':
                print
                '--> sphinx3'
                process = spec06_benchmarks.sphinx3
            elif wrkld== 'xalancbmk':
                print
                '--> xalancbmk'
                process = spec06_benchmarks.xalancbmk
            elif wrkld == 'specrand_i':
                print
                '--> specrand_i'
                process = spec06_benchmarks.specrand_i
            elif wrkld == 'specrand_f':
                print
                '--> specrand_f'
                process = spec06_benchmarks.specrand_f
            else:
                print
                "No recognized SPEC2006 benchmark selected! Exiting."
                sys.exit(1)
            process.cwd = os.getcwd()

            if len(outputs) > idx:
                process.output = outputs[idx]
            if len(errouts) > idx:
                process.errout = errouts[idx]

            multiprocesses.append(process)
            idx += 1

        else:
            print >> sys.stderr, "Need --benchmark switch to specify SPEC CPU2006 workload. Exiting!\n"
            sys.exit(1)

    if options.smt:
        assert(options.cpu_type == "DerivO3CPU")
        return multiprocesses, idx
    else:
        return multiprocesses, 1

# ...snip...
parser = argparse.ArgumentParser()
Options.addCommonOptions(parser)
Options.addSEOptions(parser)


# NAVIGATE TO THIS POINT

# ...snip...

parser.add_argument("-b", "--benchmark", default="", help="The SPEC benchmark to be loaded.")
parser.add_argument("--benchmark_stdout", default="", help="Absolute path for stdout redirection for the benchmark.")
parser.add_argument("--benchmark_stderr", default="", help="Absolute path for stderr redirection for the benchmark.")


if '--ruby' in sys.argv:
    Ruby.define_options(parser)

# (options, args) = parser.parse_args()
args = parser.parse_args()

# if args:
#     print("Error: script doesn't take any positional arguments")
#     sys.exit(1)


multiprocesses, numThreads = get_processes(args)


(CPUClass, test_mem_mode, FutureClass) = Simulation.setCPUClass(args)
CPUClass.numThreads = numThreads

# Check -- do not allow SMT with multiple CPUs
if args.smt and args.num_cpus > 1:
    fatal("You cannot use SMT with multiple CPUs!")

np = args.num_cpus
mp0_path = multiprocesses[0].executable
system = System(cpu = [CPUClass(cpu_id=i) for i in range(np)],
                mem_mode = test_mem_mode,
                mem_ranges = [AddrRange(args.mem_size)],
                cache_line_size = args.cacheline_size)

if numThreads > 1:
    system.multi_thread = True

# Create a top-level voltage domain
system.voltage_domain = VoltageDomain(voltage = args.sys_voltage)

# Create a source clock for the system and set the clock period
system.clk_domain = SrcClockDomain(clock =  args.sys_clock,
                                   voltage_domain = system.voltage_domain)

# Create a CPU voltage domain
system.cpu_voltage_domain = VoltageDomain()

# Create a separate clock domain for the CPUs
system.cpu_clk_domain = SrcClockDomain(clock = args.cpu_clock,
                                       voltage_domain =
                                       system.cpu_voltage_domain)

# If elastic tracing is enabled, then configure the cpu and attach the elastic
# trace probe
#if options.elastic_trace_en:
#    CpuConfig.config_etrace(CPUClass, system.cpu, options)

# All cpus belong to a common cpu_clk_domain, therefore running at a common
# frequency.
for cpu in system.cpu:
    cpu.clk_domain = system.cpu_clk_domain

if ObjectList.is_kvm_cpu(CPUClass) or ObjectList.is_kvm_cpu(FutureClass):
    if buildEnv['TARGET_ISA'] == 'x86':
        system.kvm_vm = KvmVM()
        for process in multiprocesses:
            process.useArchPT = True
            process.kvmInSE = True
    else:
        fatal("KvmCPU can only be used in SE mode with x86")

# Sanity check
if args.simpoint_profile:
    if not ObjectList.is_noncaching_cpu(CPUClass):
        fatal("SimPoint/BPProbe should be done with an atomic cpu")
    if np > 1:
        fatal("SimPoint generation not supported with more than one CPUs")

for i in range(np):
    if args.smt:
        system.cpu[i].workload = multiprocesses
    elif len(multiprocesses) == 1:
        system.cpu[i].workload = multiprocesses[0]
    else:
        system.cpu[i].workload = multiprocesses[i]

    if args.simpoint_profile:
        system.cpu[i].addSimPointProbe(args.simpoint_interval)

    if args.checker:
        system.cpu[i].addCheckerCpu()

    if args.bp_type:
        bpClass = ObjectList.bp_list.get(args.bp_type)
        system.cpu[i].branchPred = bpClass()

    if args.indirect_bp_type:
        indirectBPClass = \
            ObjectList.indirect_bp_list.get(args.indirect_bp_type)
        system.cpu[i].branchPred.indirectBranchPred = indirectBPClass()

    system.cpu[i].createThreads()

if args.ruby:
    Ruby.create_system(args, False, system)
    assert(args.num_cpus == len(system.ruby._cpu_ports))

    system.ruby.clk_domain = SrcClockDomain(clock = args.ruby_clock,
                                        voltage_domain = system.voltage_domain)
    for i in range(np):
        ruby_port = system.ruby._cpu_ports[i]

        # Create the interrupt controller and connect its ports to Ruby
        # Note that the interrupt controller is always present but only
        # in x86 does it have message ports that need to be connected
        system.cpu[i].createInterruptController()

        # Connect the cpu's cache ports to Ruby
        system.cpu[i].icache_port = ruby_port.slave
        system.cpu[i].dcache_port = ruby_port.slave
        if buildEnv['TARGET_ISA'] == 'x86':
            system.cpu[i].interrupts[0].pio = ruby_port.master
            system.cpu[i].interrupts[0].int_master = ruby_port.slave
            system.cpu[i].interrupts[0].int_slave = ruby_port.master
            system.cpu[i].itb.walker.port = ruby_port.slave
            system.cpu[i].dtb.walker.port = ruby_port.slave
else:
    MemClass = Simulation.setMemClass(args)
    system.membus = SystemXBar()
    system.system_port = system.membus.slave
    CacheConfig.config_cache(args, system)
    MemConfig.config_mem(args, system)
    config_filesystem(system, args)

system.workload = SEWorkload.init_compatible(mp0_path)

if args.wait_gdb:
    for cpu in system.cpu:
        cpu.wait_for_remote_gdb = True

root = Root(full_system = False, system = system)
Simulation.run(args, root, system, FutureClass)
```
{% endfolding %}

bench输入
然后写一个脚本解决bench的输入问题，并在spec06_config.py中使用。

{% folding green close, spec06_benchmarks.py %}
```python
##spec06_benchmarks.py
import m5
from m5.objects import *

# These three directory paths are not currently used.
# gem5_dir = '<FULL_PATH_TO_YOUR_GEM5_INSTALL>'
# spec_dir = '<FULL_PATH_TO_YOUR_SPEC_CPU2006_INSTALL>'
# out_dir = '<FULL_PATH_TO_DESIRED_OUTPUT_DIRECTORY>'

GEM5_DIR='/share/NearCachePublic/src/gem5/'
#<PATH_TO_YOUR_GEM5_INSTALL>                          # Install location of gem5
SPEC_DIR='/share/NearCachePublic/src/cpu_2006/benchspec/CPU2006/'

dir_suffix = '/run/run_base_ref_gcc43-64bit.0000/'
exe_suffix = '_base.gcc43-64bit'

# temp
# binary_dir = spec_dir
# data_dir = spec_dir

# 400.perlbench
perlbench = Process(pid=400)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'400.perlbench'+dir_suffix
perlbench.executable = fullpath+'perlbench' + exe_suffix
# TEST CMDS
# perlbench.cmd = [perlbench.executable] + ['-I.', fullpath+'/lib',fullpath+ 'attrs.pl']
# REF CMDS
perlbench.cmd = [perlbench.executable] + ['-I'+fullpath+'/lib', fullpath+'/checkspam.pl', '2500', '5', '25', '11', '150', '1', '1', '1', '1']
# perlbench.cmd = [perlbench.executable] + ['-I'+fullpath+'/lib',fullpath+ 'diffmail.pl', '4', '800', '10', '17', '19', '300']
# perlbench.cmd = [perlbench.executable] + ['-I'+fullpath+'/lib',fullpath+ 'splitmail.pl', '1600', '12', '26', '16', '4500']
# perlbench.output = out_dir+'perlbench.out'

# 401.bzip2
bzip2 = Process(pid=401)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'401.bzip2'+dir_suffix
bzip2.executable = fullpath+'bzip2' + exe_suffix
# TEST CMDS
# bzip2.cmd = [bzip2.executable] + [fullpath+'input.program', '5']
# REF CMDS
bzip2.cmd = [bzip2.executable] + [fullpath+'input.source', '280']
# bzip2.cmd = [bzip2.executable] + [fullpath+'chicken.jpg', '30']
# bzip2.cmd = [bzip2.executable] + [fullpath+'liberty.jpg', '30']
# bzip2.cmd = [bzip2.executable] + [fullpath+'input.program', '280']
# bzip2.cmd = [bzip2.executable] + [fullpath+'text.html', '280']
# bzip2.cmd = [bzip2.executable] + [fullpath+'input.combined', '200']
# bzip2.output = out_dir + 'bzip2.out'

# 403.gcc
gcc = Process(pid=403)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'403.gcc'+dir_suffix
gcc.executable = fullpath+'gcc' + exe_suffix
# TEST CMDS
# gcc.cmd = [gcc.executable] + [fullpath+'cccp.i', '-o',fullpath+ 'cccp.s']
# REF CMDS
gcc.cmd = [gcc.executable] + [fullpath+'166.i', '-o', fullpath+'166.s']
# gcc.cmd = [gcc.executable] + [fullpath+'200.i', '-o',fullpath+ '200.s']
# gcc.cmd = [gcc.executable] + [fullpath+'c-typeck.i', '-o',fullpath+ 'c-typeck.s']
# gcc.cmd = [gcc.executable] + [fullpath+'cp-decl.i', '-o',fullpath+ 'cp-decl.s']
# gcc.cmd = [gcc.executable] + [fullpath+'expr.i', '-o',fullpath+ 'expr.s']
# gcc.cmd = [gcc.executable] + [fullpath+'expr2.i', '-o',fullpath+ 'expr2.s']
# gcc.cmd = [gcc.executable] + [fullpath+'g23.i', '-o',fullpath+ 'g23.s']
# gcc.cmd = [gcc.executable] + [fullpath+'s04.i', '-o',fullpath+ 's04.s']
# gcc.cmd = [gcc.executable] + [fullpath+'scilab.i', '-o',fullpath+ 'scilab.s']
# gcc.output = out_dir + 'gcc.out'

# 410.bwaves
bwaves = Process(pid=410)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'410.bwaves'+dir_suffix
bwaves.executable = fullpath+'bwaves' + exe_suffix
# TEST CMDS
# bwaves.cmd = [bwaves.executable]
# REF CMDS
bwaves.cmd = [bwaves.executable]
# bwaves.output = out_dir + 'bwaves.out'

# 416.gamess
gamess = Process(pid=416)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'416.gamess'+dir_suffix
gamess.executable = fullpath+'gamess' + exe_suffix
# TEST CMDS
# gamess.cmd = [gamess.executable]
# gamess.input = fullpath+'exam29.config'
# REF CMDS
gamess.cmd = [gamess.executable]
gamess.input = fullpath+'cytosine.2.config'
# gamess.cmd = [gamess.executable]
# gamess.input = fullpath+'h2ocu2+.gradient.config'
# gamess.cmd = [gamess.executable]
# gamess.input = fullpath+'triazolium.config'
# gamess.output = out_dir + 'gamess.out'

# 429.mcf
mcf = Process(pid=429)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'429.mcf'+dir_suffix
mcf.executable = fullpath+'mcf' + exe_suffix
# TEST CMDS
# mcf.cmd = [mcf.executable] + [fullpath+'inp.in']
# REF CMDS
mcf.cmd = [mcf.executable] + [fullpath+'inp.in']
# mcf.output = out_dir + 'mcf.out'

# 433.milc
milc = Process(pid=433)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'433.milc'+dir_suffix
milc.executable = fullpath+'milc' + exe_suffix
# TEST CMDS
# milc.cmd = [milc.executable]
# milc.input = fullpath+'su3imp.in'
# REF CMDS
milc.cmd = [milc.executable]
milc.input = fullpath+'su3imp.in'
# milc.output = out_dir + 'milc.out'

# 434.zeusmp
zeusmp = Process(pid=434)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'434.zeusmp'+dir_suffix
zeusmp.executable = fullpath+'zeusmp' + exe_suffix
# TEST CMDS
# zeusmp.cmd = [zeusmp.executable]
# REF CMDS
zeusmp.cmd = [zeusmp.executable]
# zeusmp.output = out_dir + 'zeusmp.out'

# 435.gromacs
gromacs = Process(pid=435)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'435.gromacs'+dir_suffix
gromacs.executable = fullpath+'gromacs' + exe_suffix
# TEST CMDS
# gromacs.cmd = [gromacs.executable] + ['-silent','-deffnm',fullpath+ 'gromacs', '-nice','0']
# REF CMDS
gromacs.cmd = [gromacs.executable] + ['-silent', '-deffnm', fullpath+'gromacs', '-nice', '0']
# gromacs.output = out_dir + 'gromacs.out'

# 436.cactusADM
cactusADM = Process(pid=436)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'436.cactusADM'+dir_suffix
cactusADM.executable = fullpath+'cactusADM' + exe_suffix
# TEST CMDS
# cactusADM.cmd = [cactusADM.executable] + [fullpath+'benchADM.par']
# REF CMDS
cactusADM.cmd = [cactusADM.executable] + [fullpath+'benchADM.par']
# cactusADM.output = out_dir + 'cactusADM.out'

# 437.leslie3d
leslie3d = Process(pid=437)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'437.leslie3d'+dir_suffix
leslie3d.executable = fullpath+'leslie3d' + exe_suffix
# TEST CMDS
# leslie3d.cmd = [leslie3d.executable]
# leslie3d.input = fullpath+'leslie3d.in'
# REF CMDS
leslie3d.cmd = [leslie3d.executable]
leslie3d.input = fullpath+'leslie3d.in'
# leslie3d.output = out_dir + 'leslie3d.out'

# 444.namd
namd = Process(pid=444)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'444.namd'+dir_suffix
namd.executable = fullpath+'namd' + exe_suffix
# TEST CMDS
# namd.cmd = [namd.executable] + ['--input', fullpath+'namd.input', '--output', fullpath+'namd.out', '--iterations', '1']
# REF CMDS
namd.cmd = [namd.executable] + ['--input', fullpath+'namd.input', '--output', fullpath+'namd.out', '--iterations', '38']
# namd.output = out_dir + 'namd.out'

# 445.gobmk
gobmk = Process(pid=445)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'445.gobmk'+dir_suffix
gobmk.executable = fullpath+'gobmk' + exe_suffix
# TEST CMDS
# gobmk.cmd = [gobmk.executable] + ['--quiet','--mode', 'gtp']
# gobmk.input = fullpath+'dniwog.tst'
# REF CMDS
gobmk.cmd = [gobmk.executable] + ['--quiet', '--mode', 'gtp']
gobmk.input = fullpath+'13x13.tst'
# gobmk.cmd = [gobmk.executable] + ['--quiet','--mode', 'gtp']
# gobmk.input = fullpath+'nngs.tst'
# gobmk.cmd = [gobmk.executable] + ['--quiet','--mode', 'gtp']
# gobmk.input = fullpath+'score2.tst'
# gobmk.cmd = [gobmk.executable] + ['--quiet','--mode', 'gtp']
# gobmk.input = fullpath+'trevorc.tst'
# gobmk.cmd = [gobmk.executable] + ['--quiet','--mode', 'gtp']
# gobmk.input = fullpath+'trevord.tst'
# gobmk.output = out_dir + 'gobmk.out'

# 447.dealII
####### NOT WORKING #########
dealII = Process(pid=447)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'447.dealII'+dir_suffix
dealII.executable = fullpath+'dealII' + exe_suffix
# TEST CMDS
####### NOT WORKING #########
dealII.cmd = [gobmk.executable]+['8']
# REF CMDS
####### NOT WORKING #########
# dealII.output = out_dir + 'dealII.out'

# 450.soplex
soplex = Process(pid=450)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'450.soplex'+dir_suffix
soplex.executable = fullpath+'soplex' + exe_suffix
# TEST CMDS
# soplex.cmd = [soplex.executable] + ['-m10000',fullpath+ 'test.mps']
# REF CMDS
soplex.cmd = [soplex.executable] + ['-m45000', fullpath+'pds-50.mps']
# soplex.cmd = [soplex.executable] + ['-m3500', fullpath+'ref.mps']
# soplex.output = out_dir + 'soplex.out'

# 453.povray
povray = Process(pid=453)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'453.povray'+dir_suffix
povray.executable = fullpath+'povray' + exe_suffix
# TEST CMDS
# povray.cmd = [povray.executable] + [fullpath+'SPEC-benchmark-test.ini']
# REF CMDS
povray.cmd = [povray.executable] + [fullpath+'SPEC-benchmark-ref.ini']
# povray.output = out_dir + 'povray.out'

# 454.calculix
calculix = Process(pid=454)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'454.calculix'+dir_suffix
calculix.executable = fullpath+'calculix' + exe_suffix
# TEST CMDS
# calculix.cmd = [calculix.executable] + ['-i', 'beampic']
# REF CMDS
calculix.cmd = [calculix.executable] + ['-i', 'hyperviscoplastic']
# calculix.output = out_dir + 'calculix.out'

# 456.hmmer
hmmer = Process(pid=456)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'456.hmmer'+dir_suffix
hmmer.executable = fullpath+'hmmer' + exe_suffix
# TEST CMDS
# hmmer.cmd = [hmmer.executable] + ['--fixed', '0', '--mean', '325', '--num', '45000', '--sd', '200', '--seed', '0', fullapth+'bombesin.hmm']
# REF CMDS
hmmer.cmd = [hmmer.executable] + [fullpath+'nph3.hmm', fullpath+'swiss41']
# hmmer.cmd = [hmmer.executable] + ['--fixed', '0', '--mean', '500', '--num', '500000', '--sd', '350', '--seed', '0', fullpath+'retro.hmm']
# hmmer.output = out_dir + 'hmmer.out'

# 458.sjeng
sjeng = Process(pid=458)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'458.sjeng'+dir_suffix
sjeng.executable = fullpath+'sjeng' + exe_suffix
# TEST CMDS
# sjeng.cmd = [sjeng.executable] + [fullpath+'test.txt']
# REF CMDS
sjeng.cmd = [sjeng.executable] + [fullpath+'ref.txt']
# sjeng.output = out_dir + 'sjeng.out'

# 459.GemsFDTD
GemsFDTD = Process(pid=459)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'459.GemsFDTD'+dir_suffix
GemsFDTD.executable = fullpath+'GemsFDTD' + exe_suffix
# TEST CMDS
# GemsFDTD.cmd = [GemsFDTD.executable]
# REF CMDS
GemsFDTD.cmd = [GemsFDTD.executable]
# GemsFDTD.output = out_dir + 'GemsFDTD.out'

# 462.libquantum
libquantum = Process(pid=462)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'462.libquantum'+dir_suffix
libquantum.executable = fullpath+'libquantum' + exe_suffix
# TEST CMDS
# libquantum.cmd = [libquantum.executable] + ['33','5']
# REF CMDS [UPDATE 10/2/2015]: Sparsh Mittal has pointed out the correct input for libquantum should be 1397 and 8, not 1297 and 8. Thanks!
libquantum.cmd = [libquantum.executable] + ['1397', '8']
# libquantum.output = out_dir + 'libquantum.out'

# 464.h264ref
h264ref = Process(pid=464)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'464.h264ref'+dir_suffix
h264ref.executable = fullpath+'h264ref' + exe_suffix
# TEST CMDS
# h264ref.cmd = [h264ref.executable] + ['-d', fullpath+'foreman_test_encoder_baseline.cfg']
# REF CMDS
h264ref.cmd = [h264ref.executable] + ['-d', fullpath+'foreman_ref_encoder_baseline.cfg']
# h264ref.cmd = [h264ref.executable] + ['-d', fullpath+'foreman_ref_encoder_main.cfg']
# h264ref.cmd = [h264ref.executable] + ['-d', fullpath+'sss_encoder_main.cfg']
# h264ref.output = out_dir + 'h264ref.out'

# 465.tonto
tonto = Process(pid=465)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'465.tonto'+dir_suffix
tonto.executable = fullpath+'tonto' + exe_suffix
# TEST CMDS
# tonto.cmd = [tonto.executable]
# REF CMDS
tonto.cmd = [tonto.executable]
# tonto.output = out_dir + 'tonto.out'

# 470.lbm
lbm = Process(pid=470)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'470.lbm'+dir_suffix
lbm.executable = fullpath+'lbm' + exe_suffix
# TEST CMDS
# lbm.cmd = [lbm.executable] + ['20', fullpath+'reference.dat', '0', '1', fullpath+'100_100_130_cf_a.of']
# REF CMDS
lbm.cmd = [lbm.executable] + ['300', fullpath+'reference.dat', '0', '0', fullpath+'100_100_130_ldc.of']
# lbm.output = out_dir + 'lbm.out'

# 471.omnetpp
omnetpp = Process(pid=471)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'471.omnetpp'+dir_suffix
omnetpp.executable = fullpath+'omnetpp' + exe_suffix
# TEST CMDS
# omnetpp.cmd = [omnetpp.executable] + [fullpath+'omnetpp.ini']
# REF CMDS
omnetpp.cmd = [omnetpp.executable] + [fullpath+'omnetpp.ini']
# omnetpp.output = out_dir + 'omnetpp.out'

# 473.astar
astar = Process(pid=473)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'473.astar'+dir_suffix
astar.executable = fullpath+'astar' + exe_suffix
# TEST CMDS
# astar.cmd = [astar.executable] + [fullpath+'lake.cfg']
# REF CMDS
astar.cmd = [astar.executable] + [fullpath+'rivers.cfg']
# astar.output = out_dir + 'astar.out'

# 481.wrf
wrf = Process(pid=481)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'481.wrf'+dir_suffix
wrf.executable = fullpath+'wrf' + exe_suffix
# TEST CMDS
# wrf.cmd = [wrf.executable]
# REF CMDS
wrf.cmd = [wrf.executable]
# wrf.output = out_dir + 'wrf.out'

# 482.sphinx3
sphinx3 = Process(pid=482)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'482.sphinx3'+dir_suffix
sphinx3.executable = fullpath+'sphinx_livepretend' + exe_suffix
# TEST CMDS
# sphinx3.cmd = [sphinx3.executable] + [fullpath+'ctlfile', fullpath, fullpath+'args.an4']
# REF CMDS
sphinx3.cmd = [sphinx3.executable] + [fullpath+'ctlfile', fullpath, fullpath+'args.an4']
# sphinx3.output = out_dir + 'sphinx3.out'

# 483.xalancbmk
######## NOT WORKING ###########
xalancbmk = Process(pid=483)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'483.xalancbmk'+dir_suffix
xalancbmk.executable = fullpath+'Xalan' + exe_suffix
# TEST CMDS
######## NOT WORKING ###########
xalancbmk.cmd = [xalancbmk.executable] + ['-v',fullpath+'test.xml',fullpath+'xalanc.xsl']
# REF CMDS
######## NOT WORKING ###########
# xalancbmk.output = out_dir + 'xalancbmk.out'

# 998.specrand
specrand_i = Process(pid=998)  # Update June 7, 2017: This used to be LiveProcess()
fullpath=SPEC_DIR+'998.specrand'+dir_suffix
specrand_i.executable = fullpath+'specrand' + exe_suffix
# TEST CMDS
# specrand_i.cmd = [specrand_i.executable] + ['324342', '24239']
# REF CMDS
specrand_i.cmd = [specrand_i.executable] + ['1255432124', '234923']
# specrand_i.output = out_dir + 'specrand_i.out'
# 999.specrand
specrand_f = Process(pid=999)  # Update June 7, 2017: This used to be LiveProces using std::in;
fullpath=SPEC_DIR+'999.specrand'+dir_suffix
specrand_f.executable = fullpath+'specrand' + exe_suffix
# TEST CMDS
# specrand_f.cmd = [specrand_f.executable] + ['324342', '24239']
# REF CMDS
specrand_f.cmd = [specrand_f.executable] + ['1255432124', '234923']
# specrand_f.output = out_dir + 'specrand_f.out'
```
{% endfolding %}

为了使运行更简单。分别为运行写了单线程和多线程版本脚本程序。

单线程运行

{% folding green close, run_gem5_arm_spec06_benchmark.sh %}
```shell
#!/bin/bash
#
# run_spec2006.sh
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


############ DIRECTORY VARIABLES: MODIFY ACCORDINGLY #############
GEM5_DIR=/share/NearCachePublic/src/gem5
#<PATH_TO_YOUR_GEM5_INSTALL>                          # Install location of gem5
SPEC_DIR=/share/NearCachePublic/src/cpu_2006
#<PATH_TO_YOUR_SPEC_CPU2006_INSTALL>                  # Install location of your SPEC2006 benchmarks

ARCH=ARM
#YOUR gem5 arch
##################################################################

ARGC=$# # Get number of arguments excluding arg0 (the script itself). Check for help message condition.
# if [[ "$ARGC" != 2 ]]; then # Bad number of arguments.
#     echo "run_gem5_alpha_spec06_benchmark.sh  Copyright (C) 2014 Mark Gottscho"
#     echo "This program comes with ABSOLUTELY NO WARRANTY; for details see <http://www.gnu.org/licenses/>."
#     echo "This is free software, and you are welcome to redistribute it under certain conditions; see <http://www.gnu.org/licenses/> for details."
#     echo ""
#     echo "This script runs a single gem5 simulation of a single SPEC CPU2006 benchmark for Alpha ISA."
#     echo ""
#     echo "USAGE: run_gem5_alpha_spec06_benchmark.sh <BENCHMARK> <OUTPUT_DIR>"
#     echo "EXAMPLE: ./run_gem5_alpha_spec06_benchmark.sh bzip2 /FULL/PATH/TO/output_dir"
#     echo ""
#     echo "A single --help help or -h argument will bring this message back."
#     exit
# fi

if [ x$1 != x ]
then
	BENCHMARK=$1
else
	BENCHMARK=bzip2
fi

if [ x$2 != x ]
then
	OUTPUT_DIR_Prefix=$2
else
	OUTPUT_DIR_Prefix=/share/NearCachePublic/src/gem5/spec_results
fi

OUTPUT_DIR=${OUTPUT_DIR_Prefix}/${BENCHMARK}

# Get command line input. We will need to check these.
# BENCHMARK=$1                    # Benchmark name, e.g. bzip2
# OUTPUT_DIR=$2                   # Directory to place run output. Make sure this exists!
RUN_SUFFIX=run/run_base_ref_gcc43-64bit.0000
######################### BENCHMARK CODENAMES ####################
PERLBENCH_CODE=400.perlbench
BZIP2_CODE=401.bzip2
GCC_CODE=403.gcc
BWAVES_CODE=410.bwaves
GAMESS_CODE=416.gamess
MCF_CODE=429.mcf
MILC_CODE=433.milc
ZEUSMP_CODE=434.zeusmp
GROMACS_CODE=435.gromacs
CACTUSADM_CODE=436.cactusADM
LESLIE3D_CODE=437.leslie3d
NAMD_CODE=444.namd
GOBMK_CODE=445.gobmk
DEALII_CODE=447.dealII
SOPLEX_CODE=450.soplex
POVRAY_CODE=453.povray
CALCULIX_CODE=454.calculix
HMMER_CODE=456.hmmer
SJENG_CODE=458.sjeng
GEMSFDTD_CODE=459.GemsFDTD
LIBQUANTUM_CODE=462.libquantum
H264REF_CODE=464.h264ref
TONTO_CODE=465.tonto
LBM_CODE=470.lbm
OMNETPP_CODE=471.omnetpp
ASTAR_CODE=473.astar
WRF_CODE=481.wrf
SPHINX3_CODE=482.sphinx3
XALANCBMK_CODE=483.xalancbmk
SPECRAND_INT_CODE=998.specrand
SPECRAND_FLOAT_CODE=999.specrand
##################################################################

# Check BENCHMARK input
#################### BENCHMARK CODE MAPPING ######################
BENCHMARK_CODE="none"
if [[ "$BENCHMARK" == "perlbench" ]]; then
    BENCHMARK_CODE=$PERLBENCH_CODE
fi
if [[ "$BENCHMARK" == "bzip2" ]]; then
    BENCHMARK_CODE=$BZIP2_CODE
fi
if [[ "$BENCHMARK" == "gcc" ]]; then
    BENCHMARK_CODE=$GCC_CODE
fi
if [[ "$BENCHMARK" == "bwaves" ]]; then
    BENCHMARK_CODE=$BWAVES_CODE
fi
if [[ "$BENCHMARK" == "gamess" ]]; then
    BENCHMARK_CODE=$GAMESS_CODE
fi
if [[ "$BENCHMARK" == "mcf" ]]; then
    BENCHMARK_CODE=$MCF_CODE
fi
if [[ "$BENCHMARK" == "milc" ]]; then
    BENCHMARK_CODE=$MILC_CODE
fi
if [[ "$BENCHMARK" == "zeusmp" ]]; then
    BENCHMARK_CODE=$ZEUSMP_CODE
fi
if [[ "$BENCHMARK" == "gromacs" ]]; then
    BENCHMARK_CODE=$GROMACS_CODE
fi
if [[ "$BENCHMARK" == "cactusADM" ]]; then
    BENCHMARK_CODE=$CACTUSADM_CODE
fi
if [[ "$BENCHMARK" == "leslie3d" ]]; then
    BENCHMARK_CODE=$LESLIE3D_CODE
fi
if [[ "$BENCHMARK" == "namd" ]]; then
    BENCHMARK_CODE=$NAMD_CODE
fi
if [[ "$BENCHMARK" == "gobmk" ]]; then
    BENCHMARK_CODE=$GOBMK_CODE
fi
if [[ "$BENCHMARK" == "dealII" ]]; then # DOES NOT WORK
    BENCHMARK_CODE=$DEALII_CODE
fi
if [[ "$BENCHMARK" == "soplex" ]]; then
    BENCHMARK_CODE=$SOPLEX_CODE
fi
if [[ "$BENCHMARK" == "povray" ]]; then
    BENCHMARK_CODE=$POVRAY_CODE
fi
if [[ "$BENCHMARK" == "calculix" ]]; then
    BENCHMARK_CODE=$CALCULIX_CODE
fi
if [[ "$BENCHMARK" == "hmmer" ]]; then
    BENCHMARK_CODE=$HMMER_CODE
fi
if [[ "$BENCHMARK" == "sjeng" ]]; then
    BENCHMARK_CODE=$SJENG_CODE
fi
if [[ "$BENCHMARK" == "GemsFDTD" ]]; then
    BENCHMARK_CODE=$GEMSFDTD_CODE
fi
if [[ "$BENCHMARK" == "libquantum" ]]; then
    BENCHMARK_CODE=$LIBQUANTUM_CODE
fi
if [[ "$BENCHMARK" == "h264ref" ]]; then
    BENCHMARK_CODE=$H264REF_CODE
fi
if [[ "$BENCHMARK" == "tonto" ]]; then
    BENCHMARK_CODE=$TONTO_CODE
fi
if [[ "$BENCHMARK" == "lbm" ]]; then
    BENCHMARK_CODE=$LBM_CODE
fi
if [[ "$BENCHMARK" == "omnetpp" ]]; then
    BENCHMARK_CODE=$OMNETPP_CODE
fi
if [[ "$BENCHMARK" == "astar" ]]; then
    BENCHMARK_CODE=$ASTAR_CODE
fi
if [[ "$BENCHMARK" == "wrf" ]]; then
    BENCHMARK_CODE=$WRF_CODE
fi
if [[ "$BENCHMARK" == "sphinx3" ]]; then
    BENCHMARK_CODE=$SPHINX3_CODE
fi
if [[ "$BENCHMARK" == "xalancbmk" ]]; then # DOES NOT WORK
    BENCHMARK_CODE=$XALANCBMK_CODE
fi
if [[ "$BENCHMARK" == "specrand_i" ]]; then
    BENCHMARK_CODE=$SPECRAND_INT_CODE
fi
if [[ "$BENCHMARK" == "specrand_f" ]]; then
    BENCHMARK_CODE=$SPECRAND_FLOAT_CODE
fi
# Sanity check
if [[ "$BENCHMARK_CODE" == "none" ]]; then
    echo "Input benchmark selection $BENCHMARK did not match any known SPEC CPU2006 benchmarks! Exiting."
    exit 1
fi

##################################################################
# Check OUTPUT_DIR existence
if [[ ! -d "$OUTPUT_DIR_Prefix" ]]; then
    echo "Output directory $OUTPUT_DIR_Prefix does not exist! Exiting."
    exit 1
else
	if [[ ! -d "$OUTPUT_DIR" ]]; then
		mkdir $OUTPUT_DIR
	fi
fi

RUN_DIR=$SPEC_DIR/benchspec/CPU2006/$BENCHMARK_CODE/$RUN_SUFFIX     # Run directory for the selected SPEC benchmark
SCRIPT_OUT=$OUTPUT_DIR/runscript.log                                                                    # File log for this script's stdout henceforth

################## REPORT SCRIPT CONFIGURATION ###################
echo "Command line:"                                | tee $SCRIPT_OUT
echo "$0 $*"                                        | tee -a $SCRIPT_OUT
echo "================= Hardcoded directories ==================" | tee -a $SCRIPT_OUT
echo "GEM5_DIR:                                     $GEM5_DIR" | tee -a $SCRIPT_OUT
echo "SPEC_DIR:                                     $SPEC_DIR" | tee -a $SCRIPT_OUT
echo "==================== Script inputs =======================" | tee -a $SCRIPT_OUT
echo "BENCHMARK:                                    $BENCHMARK" | tee -a $SCRIPT_OUT
echo "OUTPUT_DIR:                                   $OUTPUT_DIR" | tee -a $SCRIPT_OUT
echo "==========================================================" | tee -a $SCRIPT_OUT
##################################################################

#################### LAUNCH GEM5 SIMULATION ######################
echo "" | tee -a $SCRIPT_OUT
echo "" | tee -a $SCRIPT_OUT
echo "--------- Here goes nothing! Starting gem5! ------------" | tee -a $SCRIPT_OUT
echo "" | tee -a $SCRIPT_OUT
echo "" | tee -a $SCRIPT_OUT

# Actually launch gem5!
##根据需要对此进行修改

$GEM5_DIR/build/$ARCH/gem5.opt \
--outdir=$OUTPUT_DIR \
--debug-file=${BENCHMARK}.out \
$GEM5_DIR/configs/example/spec06_config.py \
--benchmark=$BENCHMARK \
--benchmark_stdout=$OUTPUT_DIR/$BENCHMARK.out \
--benchmark_stderr=$OUTPUT_DIR/$BENCHMARK.err \
--num-cpus=1 \
--cpu-type=MinorCPU \
--cpu-clock=2.4GHz \
--caches \
--cacheline_size=64 \
--l1d_size=64kB --l1i_size=32kB --l1i_assoc=8 --l1d_assoc=8 \
--l2cache --l2_size=2MB --l2_assoc=8 \
--l3_size=32MB --l3_assoc=4 \
--mem-type=DDR3_1600_8x8 \
--mem-channels=2 \
--mem-ranks=8 \
--mem-size=4096MB -I 2000000 \
> $SCRIPT_OUT
```
{% endfolding %}

可以使用如下命令单线程运行gem5仿真:

```shell
cd $PATH_TO_YOUR_GEM5_INSTALL  
./run_spec2006.sh  <BENCHMARK_NAME>  <FULL_PATH_TO_OUT_DIRECTORY>
```
多线程运行
对上面的run_spec2006.sh进行修改最后的部分，得到多线程版本的脚本。

```shell
# Actually launch gem5!
$GEM5_DIR/build/$ARCH/gem5.opt \
--debug-flags=MemoryAccess \
--outdir=$OUTPUT_DIR \
--debug-file=${BENCHMARK}.out \
$GEM5_DIR/configs/tutorial/spec06_config.py \
--benchmark=$BENCHMARK \
--benchmark_stdout=$OUTPUT_DIR/$BENCHMARK.out \
--benchmark_stderr=$OUTPUT_DIR/$BENCHMARK.err \
--num-cpus=4 \
--cpu-type=DerivO3CPU \
--cpu-clock=2.4GHz \
--caches \
--cacheline_size=64 \
--l1d_size=64kB --l1i_size=32kB --l1i_assoc=8 --l1d_assoc=8 \
--l2cache --l2_size=2MB --l2_assoc=8 \
--l3_size=32MB --l3_assoc=4 \
--ruby \
--mem-type=DDR4_2400_8x8 \
--mem-channels=2 \
--mem-ranks=8 \
--mem-size=4096MB -I 2000000 \
| tee -a $SCRIPT_OUT
```

可以使用如下命令单线程运行gem5仿真：

```shell
cd $PATH_TO_YOUR_GEM5_INSTALL  
./run_spec2006.sh  <BENCHMARK_NAME1;BENCHMARK_NAME2;BENCHMARK_NAME3;BENCHMARK_NAME4>  <FULL_PATH_TO_OUT_DIRECTORY>
```

bench间使用”;”分隔，主要保证bench数目和cpu数目要匹配。



[^1]: https://www.spec.org/cpu2006/Docs/
[^2]: https://www.spec.org/cpu2006/Docs/system-requirements.html
[^3]: https://www.spec.org/cpu2006/Docs/install-guide-unix.html
[^4]: https://www.spec.org/cpu2006/Docs/runspec.html
[^5]: https://markgottscho.wordpress.com/2014/09/20/tutorial-easily-running-spec-cpu2006-benchmarks-in-the-gem5-simulator/
[^6]: https://tomsworkspace.github.io/2020/09/22/gem5%E8%BF%90%E8%A1%8CSPECCPU2006benchmark/
[^7]: https://blog.csdn.net/fandroid/article/details/45701463