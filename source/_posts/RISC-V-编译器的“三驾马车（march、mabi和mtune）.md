---
title: RISC-V 编译器的“三驾马车（march、mabi和mtune）
date: 2021-11-18 19:49:49
tags:
- 编译器
- RISC-V
categories: 编译器 
password: www
abstract: Welcome to my blog, enter password to read.
message: Welcome to my blog, enter password to read.
---

# RISC-V 编译器的“三驾马车（march、mabi和mtune）

<!-- TOC -->

- [RISC-V 编译器的“三驾马车（march、mabi和mtune）](#risc-v-编译器的三驾马车marchmabi和mtune)
  - [翻译说明](#翻译说明)
  - [译文](#译文)
    - [-march 参数](#-march-参数)
    - [-mabi 参数](#-mabi-参数)
    - [-mtune 参数](#-mtune-参数)
  - [译者注](#译者注)

<!-- /TOC -->

## 翻译说明

最近关注RISC V，发现Sifive的博客质量比价高，这里就转译到中文，给不喜欢看英文的一个参考，此转译不一定一对一的英对中，而是处理之后的，如发现错误或其它问题，请及时提出来，谢谢。
译者自己的一些说明都放到最后。

## 译文

在登上RISC-V这列快车前，我们停下来看看一看售票厅：里面有RISC-V列车专用的票（GCC命令行参数）。所有这些-m指定的参数都是专门为RISC-V架构移植的。通常我们尽量保证参数和其它架构的参数一致，但能够搞定大多数参数的同时，总会有一些原因会让需要我们另起炉灶重新制造一些新的轮子（参数）。本文讨论RISC-V ISA最基本的3个参数: -march、 -mabi和 -mtune。

长期以来一个我们有一个很大的优势就是在SiFive的接口稳定之前，有大把的时间来考虑RISC-V的C/C++编译器的命令行接口。我们可以让GNU工具包的命令参数和LLVM工具包的命令参数保持一致，同时我们也可以避免需要用户像之前那样通过-Wa或-Wl传递参数给编译器和连接器。

为了让RISC-V编译器命令行在将来易于扩展，我们制定了一个策略就是用户必须使用如下3个参数来描述他们需要编译的目标:

- -march=ISA 用于选择目标的架构，这个参数告诉编译器可以使用哪些指令或者哪种寄存器；
- -mabi=ABI 选择目标应用程序接口(ABI)，这个可以控制程序调用约定规则（例如使用哪种寄存器传递哪种参数，使用哪种寄存器返回数据）和数据在内存中的布局；
- -mtune=CODENAME 用于选择目标微架构，此参数可以告知GCC每条指令的性能，可以让工具进行一些针对目标的代码优化。

### -march 参数

-march 参数是RISC-V规范手册上定义的，编译器由-march控制怎么生成指令集，而目标RISC-V系统必须运行在自身兼容的指令集上。每个系统都有自己兼容的指令集，具体可以参看芯片手册。

这里需要说明一点的是: 对于2.2版本以上的规范，目前编译器支持三种接班指令集类型（应该没有基于2.2版本以下流片的吧？）：

- RV32I: 32位指令集，寄存器为32位；
- RV32E: RV32I指令集的一种嵌入式方案，寄存器仅仅为16位；
- RV64I: RV32I指令集的64位方案，寄存器为64位。

除了上述指定集外，规范还指定了一些扩展，目前定义且被编译器支持的扩展如下：

- M: 整数乘除
- A: 原子指令集
- F: 单精度浮点
- D: 双精度浮点
- C: 压缩指令集

RISC-V ISA命名规范为基本指令集字符串加上支持扩展字符构成整个架构字符串，例如支持整数乘除的32位指令集架构命名为RV32IM，用户可以选择指令集架构让GCC仅仅生成对应架构的代码，-march参数小写，例如 -march=rv32im。

在不支持特定操作的RISC-V系统上，模拟代码可用于提供缺失的功能。例如下面的C代码

```c
 double dmul(double a, double b) {
      return a * b;
    }
```

对于有D扩展的架构会直接生成浮点乘法指令:

```shell
 $ riscv64-unknown-elf-gcc test.c -march=rv64imafdc -mabi=lp64d -o- -S -O3
    dmul:
      fmul.d  fa0,fa0,fa1
      ret
```

对于没有D扩展的架构会生成算法模拟的代码：

```shell
 $ riscv64-unknown-elf-gcc test.c -march=rv64i -mabi=lp64 -o- -S -O3
    dmul:
      add     sp,sp,-16
      sd      ra,8(sp)
      call    __muldf3
      ld      ra,8(sp)
      add     sp,sp,16
      jr      ra
```

M和F也有类似的模拟代码来扩展对应的C特性实现的。遗憾的在撰写本文时,还没有敲定一个A扩展的模拟代码,因为他们拒绝作为Linux上游过程的一部分——这在未来可能会改变,但是现在我们计划要求Linux兼容机器包含A扩展，这将是RISC-V平台规范的一部分（此文是17年8月写的，现在不知道敲定没有？）。

### -mabi 参数

对GCC的-mabi参数指定了编译器生成整数和浮点相关代码所遵循的ABI。就像-march的参数指定了硬件兼容的代码指令集一样，-mabi参数指定了软件生成的代码链接的规则。我们使用了整数ABI（ilp32或lp64）的标准命名方案，并附加了一个用于选择ABI所使用的浮点寄存器（ilp32与ilp32f与ilp32d）的单字母组合。为了让不同软件生成的对象连接在一起，所有软件必须遵循相同的ABI。

RISC-V 定义了2种整数ABI和三种浮点ABI, 参数将它们作为一个整体字符串。整数ABI命令规则如下：

- ilp32: int, long, 和指针都是32位长, long long 是64位的类型，char是8位而short是16位；
- lp64: long和指针都是64位，其它和ilp32一样。

浮点ABI是RISC-V专用扩展支持的(GCC的ABI参数主要用于告知编译器能不能用浮点寄存器传递参数，而ISA参数定义了要不要生成专用浮点指令代码，这两点有点差异，需要体会)：

- "" (空字符串): 不能将任何浮点寄存器传递参数；
- f: 可以将最长32位浮点寄存器传递参数，目标架构必须有F扩展;
- d: 可以将最长64位浮点寄存器传递参数，目标架构必须要D扩展。

就像架构集字符串规则, ABI字符串规则也是整数加浮点两部分组成。为了更进一步理解ISA和ABI 2个独立的参数的使用，我们来看一看下面的-march/-mabi组合：

- -march=rv32imafdc -mabi=ilp32d: 系统支持硬件双精度浮点运算，双精度浮点寄存器可以做参数传递，有点类似于ARM架构的 -mfloat-abi=hard参数；
- -march=rv32imac -mabi=ilp32: 系统不支持浮点指令集，也没有浮点寄存器，有点类似于ARM架构的-mfloat-abi=soft参数；
- -march=rv32imafdc -mabi=ilp32: 硬件支持浮点运算但是不能将任何浮点寄存器作为参数传递，有点类似于ARM架构的-mfloat-abi=softfp参数，通常用于在支持硬浮点的平台上对接一个使用软件浮点的二进制文件；
- -march=rv32imac -mabi=ilp32d: 非法的参数。

我们再来举个例子，我们看看下面使用双精度参数的C代码，为了在汇编中显示出参数的位置，我们反转了参数在使用时的顺序：

```c
    double dmul(double a, double b) {
      return b * a;
    }
```

我们开始使用简单点的参数（如果ABI或ISA包括硬件浮点的功能，C编译器将不会优化专用的浮点指令）：下面的场景生成了模拟浮点处理的代码，参数都是以整数的形式进行传递。正如汇编代码展示的，双精度参数使用了2个寄存器来传递参数, 且参数顺序是颠倒的， ra寄存器被保存到堆栈(被调用函数保存), 模拟代码被调用, 堆栈是松散的（堆栈申请了16个字节，但就存了一个返回地址），结果被返回 (结果被__muldf3函数存放到了a0,a1中)。

```shell
    $ riscv64-unknown-elf-gcc test.c -march=rv32imac -mabi=ilp32 -o- -S -O3
    dmul:
      mv      a4,a2
      mv      a5,a3
      add     sp,sp,-16
      mv      a2,a0
      mv      a3,a1
      mv      a0,a4
      mv      a1,a5
      sw      ra,12(sp)
      call    __muldf3
      lw      ra,12(sp)
      add     sp,sp,16
      jr      ra
```

第二个例子我们将使用双精度浮点指令：这种情况编译器直接生成了fmul.d指令进行乘法计算，且寄存器的顺序也是和参数反的，fa0作为返回值。

```shell
    $ riscv64-unknown-elf-gcc test.c -march=rv32imafdc -mabi=ilp32d -o- -S -O3
    dmul:
      fmul.d  fa0,fa1,fa0
      ret
```

最后一个场景我们将会展示为什么要分2个参数-march 和 -mabi传递给 RISC-V 编译器：用户可能会生成一些通用型的代码，包括可以运行在那些没有专用扩展的平台，但这些代码又必须要发挥那些支持扩展平台的优势。在将传统的库集成到新系统时用户通常都会遇到这种困扰，为了解决这个问题我们设计了编译器参数和多库路径，以便干净利落的完成这个任务。

生成的代码的本质是混合了上面2种输出: 参数使用ilp32 ABI的方式传递到函数 (与之相对的是使用 ilp32d ABI定义的方式传参数)，进入到函数体内部就可以充分使用rv32imafdc 架构的优势进行结果计算。执行流程就是先把整数参数(双精度参数的整数形式)存到堆栈，在函数中把它加载到浮点寄存器中进行运算，并将结果存到堆栈并按照整数ABI兼容的方式保存到返回寄存器中(a0 和 a1)。相对于第二种方式来说好像没有啥效率，但是它发挥了D扩展的性能优势，至少比那些模拟函数跑的快吧。

```shell
    $ riscv64-unknown-elf-gcc test.c -march=rv32imafdc -mabi=ilp32 -o- -S -O3
    dmul:
      add     sp,sp,-16
      sw      a0,8(sp)
      sw      a1,12(sp)
      fld     fa5,8(sp)
      sw      a2,8(sp)
      sw      a3,12(sp)
      fld     fa4,8(sp)
      fmul.d  fa5,fa5,fa4
      fsd     fa5,8(sp)
      lw      a0,8(sp)
      lw      a1,12(sp)
      add     sp,sp,16
      jr      ra
```

最后一个场景组合是不合法的。编译器没有办法生成这样的代码，又要马儿跑，又不给马儿吃草，那怎么可能?啥，非要执行，那可以：

```shell
    $ riscv64-unknown-elf-gcc test.c -march=rv32imac -mabi=ilp32d -o- -S -O3
    cc1: error: requested ABI requires -march to subsume the 'D' extension
```

### -mtune 参数

最后一个编译器参数涉及到指定目标，这是最简单的一种。虽然-march参数可能导致系统无法执行代码，而-mabi参数可能导致对象之间不兼容，但-mtune参数只会改变生成的代码的性能。就目前的情况来看，我们真的没有任何针对RISC-V系统的调优模型。除非您刚刚向GCC端口添加了一个新的调优参数，否则您可能不需要用这个参数来做任何事情。

## 译者注

这是第一篇翻译文章，sifive的blog整体水平还是不错的，有能力直接看英文比较爽，还是翻译中还是有些问题，可能是能力有所不及：

- 最开始那个火车的比喻感觉很新奇，但是英文版本看了N遍不明白这个比喻的意义，为了不糟蹋作者的一片苦心，我还是翻译了，有点变动，唯一相同的是中文的感觉也没啥意义；
- -march和-mabi参数分离应该不是RISC-V独创，ARM目前也有嘛，-mabi第三个场景我本来是抱极大的兴趣去看怎么解决使用传统库提升性能，甚至是提升传统库的性能，最后发现库本身没有浮点加速加速的话，仅仅是接口对接上了，库代码还是加速不了；multilib可以可以选择最优的库，这个还是最优解，如果是库的钩子函数，性能的确可以提升，我想ARM应该也是这样做的吧；
- 译文中有译者的添油加醋，如果影响到您的阅读体验，请提出。

> 此文章来源为 https://www.sifive.com/blog/2017/08/14/all-aboard-part-1-compiler-args/
> 译文转载自：https://genekong.com/2018/09/20/part-1-risc-v-%e7%bc%96%e8%af%91%e5%99%a8%e7%9a%84%e4%b8%89%e9%a9%be%e9%a9%ac%e8%bd%a6%ef%bc%88-march%e3%80%81-mabi%e3%80%81-%e5%92%8c-mtune%ef%bc%89/