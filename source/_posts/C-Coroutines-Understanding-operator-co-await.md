---
title: 'C++ Coroutines: Understanding operator co_await'
categories:
- 编程开发
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-11-28 19:22:48
tags:
- Coroutine
- 协程
---

在上一篇关于[协程理论](https://lewissbaker.github.io/2017/09/25/coroutine-theory)的文章中，我描述了函数和协程之间的高级差异，但没有详细介绍协程的语法和语义，如 C++ 协程 TS ([N4680](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/n4680.pdf)) 所述。

Coroutines TS 添加到 C++ 语言的关键新功能是暂停协程的能力，允许它稍后恢复。 TS 提供的执行此操作的机制是通过新的 co_await 运算符。

了解 co_await 运算符的工作原理有助于揭开协程行为的神秘面纱以及它们如何暂停和恢复。 在这篇文章中，我将解释 co_await 运算符的机制并介绍相关的 Awaitable 和 Awaiter 类型概念。

但在深入探讨 co_await 之前，我想简要概述一下协程 TS，以提供一些背景信息。

## Coroutines TS 给了我们什么？

- 三个新的语言关键字：co_await、co_yield 和 co_return
- std::experimental 命名空间中的几种新类型：
  - coroutine_handle<P>
  - coroutine_traits<Ts...>
  - suspend_always
  - suspend_never
- 库编写者可以用来与协同程序交互并自定义其行为的通用机制。
- 一种使编写异步代码变得更加容易的语言工具！

C++ Coroutines TS 在语言中提供的功能可以被认为是协程的低级汇编语言。这些设施可能难以以安全的方式直接使用，主要供库编写者使用，以构建应用程序开发人员可以安全使用的更高级别的抽象。

该计划是将这些新的低级设施与标准库中的一些附带的高级类型一起交付到即将推出的语言标准（希望是 C++20）中，这些高级类型包装了这些低级构建块并使协程更容易被应用程序开发人员安全使用。

## Compiler <-> Library 交互

有趣的是，Coroutines TS 实际上并没有定义协程的语义，它没有定义如何生成返回给调用者的值，也没有定义如何处理传递给co_return语句的返回值或如何处理从协程传播出去的异常，也没有定义协程应该在哪个线程上恢复。

相反，它为库代码指定了一种通用机制，通过实现符合特定接口的类型来自定义协程的行为。 然后，编译器生成代码，调用库提供的类型实例的方法。 这种方法类似于库编写者可以通过定义 begin()/end() 方法和迭代器类型来自定义基于范围的 for 循环行为的方式。

事实上，Coroutines TS 没有为协程的机制规定任何特定的语义，这使它成为一个强大的工具。 它允许库编写者为各种不同的目的定义许多不同种类的协程。

例如，您可以定义一个异步生成单个值的协程，或者一个延迟生成一系列值的协程，或者一个通过在遇到 nullopt 值时提前退出来简化消耗 optional<T> 值的控制流。

协程TS定义了两种接口：Promise接口和Awaitable接口。

Promise 接口指定了自定义协程本身行为的方法。 库编写者能够自定义调用协程时会发生什么，协程返回时会发生什么（通过正常方式或通过未处理的异常）并自定义协程中任何 co_await 或 co_yield 表达式的行为。

Awaitable 接口指定了控制 co_await 表达式语义的方法。 当一个值是 co_awaited 时，代码被转换为对可等待对象的方法的一系列调用，允许它指定：是否挂起当前协程，在它挂起后执行一些逻辑以安排协程稍后恢复，以及在协程恢复后执行一些逻辑以产生 co_await 表达式的结果。

我将在以后的文章中详细介绍 Promise 接口，但现在让我们看看 Awaitable 接口。

## Awaiters and Awaitables: Explaining operator co_await

co_await 运算符是一个新的一元运算符，可以应用于值。 例如：co_await someValue。

co_await 运算符只能在协程的上下文中使用。不过，这有点像重言式，因为根据定义，任何包含使用 co_await 运算符的函数体都将被编译为协程。

支持 co_await 运算符的类型称为 Awaitable 类型。








