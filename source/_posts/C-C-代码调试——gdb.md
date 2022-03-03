---
title: C_C++代码调试——gdb
date: 2021-10-18 21:12:28
tags: 
- 编程开发
- gdb
categories: 编程开发
password: www
abstract: Welcome to my blog, enter password to read.
message: Welcome to my blog, enter password to read.
---

# C_C++代码调试——gdb

<!-- TOC -->

- [C_C++代码调试——gdb](#c_c代码调试gdb)
	- [1. 开发环境](#1-开发环境)
	- [2. gdb简介](#2-gdb简介)
		- [gdb常用功能概览](#gdb常用功能概览)
	- [Reference](#reference)

<!-- /TOC -->

## 1. 开发环境

gcc: 用于开发纯C语言的程序
g++: 开发C/C++程序

二者区别：

- **文件后缀名的处理方式不同** gcc会将后缀为.c的文件当作C程序，将后缀为.cpp的文件当作C++程序；g++会将后缀为.c和.cpp的都当作C++程序。gcc和g++都可以用于编译C和C++代码。
- **链接方式不同** gcc不会自动链接C++库（比如STL标准库），g++会自动链接C++库。
- **预处理宏不同** g++会自动添加一些预处理宏，比如__cplusplus，但是gcc不会。

通用Makefile
```Makefile
EXECUTABLE:= chapter_3
LIBDIR:=
LIBS:=
INCLUDES:=.
SRCDIR:=

CC:=g++
CFLAGS:= -g -Wall -O0 -static -static-libgcc -static-libstdc++
CPPFLAGS:= $(CFLAGS)
CPPFLAGS+= $(addprefix -I,$(INCLUDES))
CPPFLAGS+= -I.
CPPFLAGS+= -MMD

RM-F:= rm -f

SRCS:= $(wildcard *.cpp) $(wildcard $(addsuffix /*.cpp, $(SRCDIR)))
OBJS:= $(patsubst %.cpp,%.o,$(SRCS))
DEPS:= $(patsubst %.o,%.d,$(OBJS))
MISSING_DEPS:= $(filter-out $(wildcard $(DEPS)),$(DEPS))
#MISSING_DEPS_SOURCES:= $(wildcard $(patsubst %.d,%.cpp,$(MISSING_DEPS)))


.PHONY : all deps objs clean
all:$(EXECUTABLE)
deps:$(DEPS)

objs:$(OBJS)
clean:
	@$(RM-F) *.o
	@$(RM-F) *.d

ifneq ($(MISSING_DEPS),)
$(MISSING_DEPS):
	@$(RM-F) $(patsubst %.d,%.o,$@)
endif
-include $(DEPS)
$(EXECUTABLE) : $(OBJS)
	$(CC) -o $(EXECUTABLE) $(OBJS) $(addprefix -L,$(LIBDIR)) $(addprefix -l,$(LIBS))
```

## 2. gdb简介

### gdb常用功能概览

| 支持的功能                	| 描述                                                 	|
|---------------------------	|------------------------------------------------------	|
| 断点管理                  	| 设置断点、查看断点                                   	|
| 调试执行                  	| 逐语句、逐过程执行                                   	|
| 查看数据                  	| 在调试状态下查看变量数据、内存数据等                 	|
| 运行时修改变量值          	| 在调试状态下修改某个变量的值                         	|
| 显示源代码                	| 查看源代码信息                                       	|
| 搜索源代码                	| 对源代码进行查找                                     	|
| 调用堆栈管理              	| 查看堆栈信息                                         	|
| 线程管理                  	| 调试多线程程序，查看线程信息                         	|
| 进程管理                  	| 调试多个线程                                         	|
| 崩溃转储（core dump）分析 	| 分析core dump文件                                    	|
| 调试启动方式              	| 用不同的方式调试进程，比如加载参数启动、附加到进程等 	|

测试代码
```c++
#include <malloc.h>
#include <string.h>

struct NODE
{
	int		ID;
	char	Name[40];
	int		age;
	NODE*	prev;
	NODE*	next;
};
struct NODE *node_head = NULL;
int member_id = 0;
void add_member()
{
	struct NODE *new_node = (NODE*)malloc(sizeof(NODE));
	new_node->next = NULL;
	NODE* prev_node = node_head->prev;
	if(prev_node)
	{
		prev_node->next = new_node;
		new_node->prev = prev_node;
		node_head->prev = new_node;
	}
	else
	{
		node_head->next = new_node;
		new_node->prev = node_head;
		node_head->prev = new_node;
	}
	new_node->ID = member_id++;
	printf("请输入会员姓名，然后按回车\n");
	scanf("%s", new_node->Name);
	printf("请输入会员年龄，然后按回车\n");
	scanf("%d", &new_node->age);

	printf("添加新会员成功\n");
}

int main(int argc, char* argv[])
{
	node_head = (struct NODE*)malloc(sizeof(NODE));
	node_head->next = node_head->prev = NULL;
	printf("会员管理系统\n1.录入会员信息\nq:退出\n");
	while(true)
	{
		switch(getchar())
		{
			case '1':
				add_member();
				break;
			case 'q':
				return 0;
			default:
				break;
		}
	}
	return 0;
}
```


- 启动调试：gdb <executable file>
- gdb调试已运行进程: gdb debugme <pid>
- gdb释放已运行进程：gdb detach
- 运行：r
- 添加输入参数：set args admin passward
- 附加到进程：gdb attach pid
- 在源代码的某一行设置断点：break(b) 文件名:行号
- 为函数设置断点：break 函数名
- 为继承关系同名函数指定断点：break className:funcName
- 使用正则表达式设置函数断点：rbreak(rb) 正则表达式，如：rb test_fun*
- 通过偏移量设置断点：b +偏移量 / b -偏移量
- 设置条件断点：b 断点 条件，如：b main.cpp:79 if i==900
- 在指令地址上设置断点（如果调试程序没有符号信息，而我们又想在某些地方设置断点时，则可以使用在指令地址上设置断点的功能）：b *指令地址
  先使用无调试符号的方式生成可执行文件（去除编译-g选项）。启动gdb并调试，然后在测试函数cond_fun_test上设置一个断点。因为没有调试符号信息，所以第一步先获得cond_fun_test函数的地址（p cond_fun_test），该命令会获得函数cond_fun_test的函数地址（0x400a0b），然后为地址设置断点(b * 0x400a0b).
- 设置临时断点（只命中一次）：tbreak(tb) 断点
- 启用/禁用断点：disable/enable 断点编号，如：disable 4-10
- 查看断点：info breadpoints; info break; info b; i b
- 启用断点一次：enable once 断点编号
- 启用断点并删除：enable delete 断点编号
- 启用断点并命中N次：enable count 数量 断点编号
- 忽略断点前N次命中：ignore 断点编号 次数
- 删除所有断点：delete
- 删除指定断点：delete 断点编号，如：delete 5 6
- 删除指令范围的断点：delete 范围，如：delete 5-7 10-12
- 删除指定函数的断点：clear 函数
- 删除指定行号的断点：clear 行号
- 保存断点: save breakpoints gdb.cfg
- 从文件加载断点：source gdb.cfg
- 继续运行并跳过当前断点N次：continue 次数
- 继续运行直到当前函数执行完成：finish
- 单步执行：step(s)
- 逐过程执行：next(n)
- 运行到当前函数返回: finish
- 查看当前函数：info args; i args
- 查看/修改变量的值：print 变量名；p 变量名；print 变量名=值 或者 set 变量名 = new value
- 查看结构体/类的值
  set print null-stop; set print pretty; p *new_node;
- 查看数组：set print array on; p 数组名
- 自动显示变量的值：display 变量名，如：display {var1, var2, var3}
- 查看已经设置的自动显示的变量信息：info display
- 取消自动变量的显示：undisplay 编号
- 取消所有自动变量的显示：undisplay
- 删除所有的自动显示：delete display
- 删除部分变量的自动显示：delete display 序号
- 暂时禁用自动显示：disable display 序号
- 恢复禁用的自动显示：enable display 序号
- 显示源代码：list(l)
- 设置每次显示代码的行数：set listsize 20
- 查看指定函数的代码：list 函数名
- 查看内存：x /选项 地址
- 查看寄存器
  info register: 查看所有的整型寄存器
  info all-register: 查看所有寄存器，包含浮点寄存器
  info 寄存器名：查看特定寄存器
- 查看调用栈
  backtrace（bt）：栈回溯
  bt 栈帧数量：查看指令数量的栈帧
- 切换栈帧，查看每一个栈帧对应的程序上下文：frame 栈帧号; f 帧地址
- 查看当前帧的所有局部变量值：info locals
- 查看帧信息：info frame; info frame 栈帧号（不需要切换栈帧）
- 线程管理（暂略）

很多时候，程序只有在一些特定条件下才会出现BUG，比如某个变量的值发生变化时，或者几个因素同时发生变化时。观察点（watchpoint）或者监视点可以用来发现或者定位该类型的BUG。可以设置为监控一个变量或者一个表达式的值，当这个值或者表达式的值发生变化时程序会暂停，而不需要提前在某些地方设置断点。
在某些系统中，gdb是以软观察点的方式来实现的。通过单步执行程序的方式来监控变量的值是否发生改变，每执行一步就会检查变量是否发生变化。这种做法会比正常执行慢上百倍，但有时为了找到不容易发现的BUG，这是值得的。
而在有些系统中（比如LINUX），gdb是以硬件方式实现观察点功能，这并不会降低程序运行的速度。

- 设置观察点：watch 变量或表达式，如：watch count=5
- 读取观察点：rwatch 变量或表达式。当变量或表达式被读取时，程序会发生中断
- 读写观察点：awatch 变量或表达式。无论这个变量是被读取还是被写入，程序都会发生中断
- 查看所有观察点：info watchpoints
- 禁用/启用/删除观察点：disable/enable/delete 观察点编号


有一些bug，可能很难复现，当好不容易复现一次，且刚刚进入程序的入口时，我们需要珍惜这个来之不易的机会。如果只使用基本命令的话，对于大部分代码，我们都需要使用step来步进。这样无疑会耗费大量的时间，因为大部分的代码可能都没有问题。可是一旦不小心使用next，结果恰好该语句的函数调用返回出错。那么对于这次来之不易的机会，我们只得到了部分信息，即确定问题出在该函数，但是哪里出错还是不清楚。于是还需要再一次的复现bug，时间就这样浪费了。所以，对于这种问题，就是checkpoint大显身手的时候。

- 保存checkpoints：checkpoints
- 查看所有checkpoints: info checkpoints
- 恢复checkpoints: restart <checkpoints_index>

捕获点（catchpoint）指的是程序在发生某事件时，gdb能够捕获这些事件并使程序停止执行。该功能可以支持很多时间，比如C++异常、载入动态库等。语法如下：
catch 事件
可以捕获的事件如下所示：

- throw: 在C++代码中执行throw语句时程序会中断
- catch: 当代码中执行到catch语句块时会中断，也就是说代码捕获异常时会中断
- exec、fork、vfork: 调用这些系统函数时会中断，主要适用于HP-UNIX
- load/unload: 加载或者卸载动态库时
- 代码搜索
  search 正则表达式
  forward-search 正则表达式
  reverse-search 正则表达式
- 查看变量类型：ptype 可选参数 变量或类型
  
在调试过程中，很多时候我们希望代码能够被反复执行，因为我们希望能够多次查看问题，以便更加仔细地观察问题。有时候又希望直接跳过某些代码，比如环境的问题、不能满足某些条件、部分代码没有意义或者会执行失败等。

- 跳转执行：jump 位置

窗口管理：gdb可以同时显示几个窗口。

- 命令窗口：gdb命令输入和结果输出的窗口，该窗口始终是可见的。
- 源代码窗口：显示程序源代码的窗口，会随着代码的执行自动显示代码对应的行。
- 汇编窗口：汇编窗口也会随着代码的执行而变化，显示代码对应的汇编代码行。
- 寄存器窗口：显示寄存器的值。
  
窗口layout管理命令：

- 显示下一个窗口：layout next
- 显示前一个窗口：layout prev
- 只显示源代码窗口：layout src
- 只显示汇编窗口：layout asm
- 显示源代码和汇编窗口：layout split
- 显示寄存器窗口，域源代码以及汇编窗口一起显示：layout regs
- 设置窗口为活动窗口，以便能够响应上下滚动键：focus next | prev | src | asm | regs | split
- 调节窗口大小：winheight src +/-5
- 刷新屏幕：refresh
- 更新源代码窗口：update
- 关闭除命令窗口之外的窗口：tui disable


调用shell命令：shell 命令；!命令

assert宏使用（暂略）

内容来源于《C/C++代码调试的艺术》，此处只涉及gdb基本功能。此书还涉及多线程死锁调试、调试动态库、内存检查、远程调试、转储文件调试分析、发行版调试、调试高级话题等章节。

## Reference

- 《C/C++代码调试的艺术》
- [gdb调试断点的保存](https://blog.csdn.net/yang15225094594/article/details/29599117)