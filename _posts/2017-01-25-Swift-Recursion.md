---
layout: post
date: 2017-01-25
title: Swift 中的递归以及效率
feature-img: "img/blue.jpg"
---

**递归** 就是重复调用自身的一种技巧。

在之前的 [Haskell And Swift Recursion](https://github.com/redtwowolf/2017/01/19/Haskell-And-Swift-Recursion.html) 这篇文章中学习和使用递归时，不管是 Haskell 还是 Swift 递归的效率都不高。当时用 Swift 实现了一个获取 n 个斐波拉契数的函数 *fibonacci*

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

递归实现一些算法往往比循环要简洁明了，但是效率比较低，原因是每次调用都要分配和管理栈帧，甚至可能导致栈溢出。

尾递归
---
---

**尾递归** 是指在递归函数中，递归调用的结果直接返回而不会做其他任何操作，当然递归语句是在尾部。

如果把上述的 *fibonacci* 函数用尾递归的方式改写，它看起来是这样：

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

这是因为编译器会对尾递归做了优化，那到底优化了什么呢？尾递归函数 *fib* 直接将结果返回而不做其他任何操作，实际上是利用两个累加器一直保存最新的值。
