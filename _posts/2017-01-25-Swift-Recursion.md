---
layout: post
date: 2017-01-25
title: Swift 中的递归、尾递归
img: "blue.jpg"
---

**递归** 就是重复调用自身的一种技巧。

在之前的 [Haskell And Swift Recursion](https://github.com/redtwowolf/2017/01/19/Haskell-And-Swift-Recursion.html) 这篇文章中学习和使用递归时，不管是 Haskell 还是 Swift 递归的效率都不高。当时用 Swift 实现了一个获取第 n 个斐波拉契数的函数 *fibonacci*

{% highlight swift %}
// fibonacci
func fibonacci(n: Int) -> Int {
    guard n > 0 else {
        fatalError("you should input a positive integer.")
    }
    return n < 3 ? 1 : fibonacci(n: n - 1) + fibonacci(n: n - 2)
}

fibonacci(n: 10)
// 55
{% endhighlight %}

递归实现一些算法往往比循环要简洁明了，但是效率比较低，原因是每次递归调用都要分配和管理栈帧，这甚至可能导致栈溢出。

尾递归
---
---

**尾递归** 是指在递归函数中，递归调用的结果直接返回而不会做其他任何操作，当然递归语句是在尾部。

尾递归只是递归调用而没有其他运算，所以相对递归来说效率提高不少。如果把上述的 *fibonacci* 函数用尾递归的方式改写，它看起来是这样：

{% highlight swift %}
func fib(n: Int, acc1: Int = 1, acc2: Int = 2) -> Int {
    if n < 3 {
        return acc1
    }
    return fib(n: n - 1, acc1: acc2, acc2: acc1 + acc2)
}

fib(n: 10)
// 55
{% endhighlight %}

通过下面两张图就能非常直观的感受到尾递归的效率很显著。

*fibonacci*
![](http://ogkg37m8j.bkt.clouddn.com/image/jpg/haskellandswift/function/recursion.jpg)

*fib*
![](http://ogkg37m8j.bkt.clouddn.com/image/jpg/haskellandswift/function/tailRecursion.jpg)

可以看出效率高了 7、8 倍。

这是因为编译器会对尾递归做了优化，那到底优化了什么呢？尾递归函数 *fib* 直接将结果返回而不做其他任何操作，实际上是利用两个累加器一直保存最新的值。在 *fib* 这个例子中，累加器 *acc* 总是保留最后一次递归调用返回的数据，积累之前的调用结果，这样保证了当前栈帧可以重复使用，从而提高效率。


栈
---
---

（Stack）是一种有序的数据结构，遵循先进后出的原则。
![stack](http://ogkg37m8j.bkt.clouddn.com/image/jpg/swiftrecursion/stack.jpg)

栈帧
---
---

（Stack Frame）就是函数运行环境，或者说为函数调用提供的一种数据结构。

栈帧为函数调用提供一套环境，就像流水线上的一个产品，它处在一大堆生产设备之间，周围生产制造的设备提供了一套环境，而这些生产设备就是函数调用。栈帧为函数调用提供数据结构，就像各式各样的机器为生产制造组成一条生产线一样。每个函数在被调用时都会在栈区形成一个栈帧的数据结构，在这个结构中存放了函数的参数、局部变量、返回地址等数据。每个函数的每次调用，都有它自己独立的一个栈帧。

![](http://ogkg37m8j.bkt.clouddn.com/image/jpg/swiftrecursion/stackframe.jpg)

* esp （Extended Stack Pointer）栈指针寄存器，存放一个指针，该指针永远指向系统栈最上面一个栈帧的栈顶。
* ebp （Extended Base Pointer）基址指针寄存器，存放一个指针，该指针永远指向系统栈最上面一个栈帧的底部。
