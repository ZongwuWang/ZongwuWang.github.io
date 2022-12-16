---
title: Epsilon 垃圾收集器
categories:
  - 编程开发
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-12-15 15:42:19
tags:
- GC
- JVM
---

## 一、简介

Epsilon（A No-Op Garbage Collector）垃圾回收器控制内存分配，但是不执行任何垃圾回收工作。一旦java的堆被耗尽，jvm就直接关闭。设计的目的是提供一个完全消极的GC实现，分配有限的内存分配，最大限度降低消费内存占用量和内存吞吐时的延迟时间。一个好的实现是隔离代码变化，不影响其他GC，最小限度的改变其他的JVM代码。

## 二、使用场景

- Performance testing,什么都不执行的GC非常适合用于差异性分析。no-op GC可以用于过滤掉GC诱发的新能损耗，比如GC线程的调度，GC屏障的消耗，GC周期的不合适触发，内存位置变化等。此外有些延迟者不是由于GC引起的，比如scheduling hiccups, compiler transition hiccups，所以去除GC引发的延迟有助于统计这些延迟。
- Memory pressure testing, 在测试java代码时，确定分配内存的阈值有助于设置内存压力常量值。这时no-op就很有用，它可以简单地接受一个分配的内存分配上限，当内存超限时就失败。例如：测试需要分配小于1G的内存，就使用-Xmx1g参数来配置no-op GC，然后当内存耗尽的时候就直接crash。
- VM interface testing, 以VM开发视角，有一个简单的GC实现，有助于理解VM-GC的最小接口实现。它也用于证明VM-GC接口的健全性。
- Extremely short lived jobs, 一个短声明周期的工作可能会依赖快速退出来释放资源，这个时候接收GC周期来清理heap其实是在浪费时间，因为heap会在退出时清理。并且GC周期可能会占用一会时间，因为它依赖heap上的数据量。
- Last-drop latency improvements, 对那些极端延迟敏感的应用，开发者十分清楚内存占用，或者是几乎没有垃圾回收的应用，此时耗时较长的GC周期将会是一件坏事。
- Last-drop throughput improvements, 即便对那些无需内存分配的工作，选择一个GC意味着选择了一系列的GC屏障，所有的OpenJDK GC都是分代的，所以他们至少会有一个写屏障。避免这些屏障可以带来一点点的吞吐量提升。

## 三、案例

**使用G1垃圾收集器**

代码：

```java {.line-numbers}
public class TestEpsilon {   public static void main(String[] args) {
       System.out.println("程序开始");
       boolean flag = true;
       List<Garbage> list = new ArrayList<>();
       long count = 0;
       while (flag) {
           list.add(new Garbage(list.size() + 1));
           if (list.size() == 1000000 && count == 0) {
               list.clear();
               count++;
           }
       }
       System.out.println("程序结束");
   }

}

class Garbage {   private int number;   public Garbage(int number) {
       this.number = number;
   }   /**
    * GC在清除对象时，会调用finalize()方法
    */
   @Override
   public void finalize() {
       System.out.println(this + " : " + number + " is dying");
   }   public int getNumber() {
       return number;
   }   public void setNumber(int number) {
       this.number = number;
   }

}
```

启动参数：

```shell {.line-numbers}
-Xms100m -Xmx100m
```

运行程序后，结果如下：

```shell {.line-numbers}
程序开始
...
com.gf.demo8.Garbage@15ddf76b : 305097 is dying
com.gf.demo8.Garbage@35e52705 : 305224 is dying
com.gf.demo8.Garbage@32c14bc1 : 305362 is dying
com.gf.demo8.Garbage@7521660a : 305705 is dying
com.gf.demo8.Garbage@f3da16a : 305948 is dying
com.gf.demo8.Garbage@13fc7287 : 306089 is dying
   at java.base/java.lang.ref.Finalizer.register(Finalizer.java:66)
   at java.base/java.lang.Object.<init>(Object.java:50)
   at com.gf.demo8.Garbage.<init>(TestEpsilon.java:28)
   at com.gf.demo8.TestEpsilon.main(TestEpsilon.java:14)
...
```

会发现G1一直回收对象，直到内存不够用。

**使用Epsilon垃圾收集器**

启动参数：

UnlockExperimentalVMOptions：解锁隐藏的虚拟机参数。

```shell {.line-numbers}
-XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xms100m -Xmx100m
```

运行程序后，结果如下：

```shell {.line-numbers}
程序开始
Terminating due to java.lang.OutOfMemoryError: Java heap space
```

会发现很快就内存溢出了，因为Epsilon不会去回收对象。

> 本文转载自：https://cloud.tencent.com/developer/article/1431157