---
title: GraphChi基准测试使用
categories:
  - Benchmark
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-12-13 11:46:31
tags:
- Benchmark
- Java
- GraphChi
---

Benchmark仓库：https://github.com/GraphChi/graphchi-java.git
Wiki：https://code.google.com/archive/p/graphchi/wikis

GraphChi支持edge list和adjacency list两种格式的图输入，从[Example Applications: Introduction](https://code.google.com/archive/p/graphchi/wikis/ExampleApps.wiki)中介绍的网址中，我们可以下载很多输入图数据集。

以[Social circles: Facebook](http://snap.stanford.edu/data/ego-Facebook.html)数据集为例，[facebook_combined.txt.gz](http://snap.stanford.edu/data/facebook_combined.txt.gz)中数据格式为edge list，下载数据集之后进行解压就可以直接读取。

JDK版本：
为了与JDK版本适配，Scala版本需要2.12及以下，否则容易出问题。所以在pom.xml中修改scala dependency如下：

```xml {.line-numbers}
<dependency>
  <groupId>org.scala-lang</groupId>
  <artifactId>scala-library</artifactId>
  <version>2.12.0</version>
</dependency>
```

创建包含所有依赖的graphchi.jar：

```shell {.line-numbers}
mvn assembly:assembly -DdescriptorId=jar-with-dependencies
```

生成package：

```shell {.line-numbers}
mvn package
```

运行：

```shell {.line-numbers}
java -Xmx2048m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar  edu.cmu.graphchi.apps.Pagerank dataset/facebook_combined.txt 1 edgelist
```
