---
title: m5ops in gem5
categories: 计算机体系架构
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-09-13 09:32:58
tags:
- gem5
- simulator
- m5op
---

在阅读[Wisconsin CS752课程设计Homework 2](https://www.gem5.org/documentation/learning_gem5/gem5_101/homework-2)时，其中提及了使用m5op进行代码标定，在此简单记录在c++代码中使用m5op的方法：

以x86架构为例，

1. 在$GEM5_ROOT/util/m5目录下，构建M5和libm5

```shell {.line-numbers}
scons build/x86/out/m5
```

2. 在c++代码中使用m5op
   - 包含头文件"#include <gem5/m5ops>"
   - 使用m5函数
```c++ {.line-numbers}
<!-- 示例 -->
#include <cstdio>
#include <random>
#include <gem5/m5ops.h>
//#include "/share/ERICA/gem5/include/gem5/m5ops.h"

// TODO: Add m5ops in code
#define M5

int main() {
	const int N = 1000;
	double alpha = 0.5;
	alignas(64) double X[N], Y[N];
	printf("&X = %p\n", &X);
	printf("&Y = %p\n", &Y);
	std::random_device rd;
	std::mt19937 gen(rd());
	std::uniform_real_distribution<double> dis(1,2);
	for (int i = 0; i < N; i++)
	{
		X[i] = dis(gen);
		Y[i] = dis(gen);
	}

	// Start of daxpy loop
	#ifdef M5
	m5_reset_stats(0,0);
	#endif
	for (int i = 0; i < N; i++)
	{
		Y[i] = alpha * X[i] + Y[i];
	}
	#ifdef M5
	//m5_exit(0);
	m5_dump_stats(0, 0);
	#endif
	// End of daxpy loop

	double sum = 0;
	for (int i = 0; i < N; i++)
	{
		sum += Y[i];
	}
	
	printf("%lf\n", sum);

	return 0;
}
```

3. Makefile中修改
   - Add gem5/include to your compiler's include search path
   - Add gem5/util/m5/build/x86/out to the linker search path
   - Link against libm5.a

```Makefile {.line-numbers}
GEM5_PATH = /share/ERICA/gem5
CXXFLAGS += -I$(GEM5_PATH)/include
LDFLAGS  += -L$(GEM5_PATH)/util/m5/build/x86/out  -l m5

all:
	g++ -static daxpy.cpp $(CXXFLAGS) $(LDFLAGS) -o daxpy

.PYHOY: clean

clean:
	@rm daxpy
```


其余更多的内容，参考https://www.gem5.org/documentation/general_docs/m5ops/