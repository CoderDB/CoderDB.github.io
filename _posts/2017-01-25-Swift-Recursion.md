---
layout: post
date: 2017-01-25
title: Swift 中的递归以及效率
feature-img: "img/blue.jpg"
---

**递归** 就是重复调用自身的一种技巧。

在 [Haskell And Swift Recursion](https://github.com/redtwowolf/2017/01/19/Haskell-And-Swift-Recursion.html) 这篇文章中学习和使用递归时，发现递归的效率并不高，不管是 Haskell 还是 Swift 。当时用 Swift 实现了一个获取 n 个斐波拉契数列的函数 *fibonaccis*

{% highlight swift %}
// fibonacci'
func fibonaccis(n: Int) -> [Int] {
    switch n {
    case _ where n <= 0:
        fatalError("you should input a positive integer.")
    case 1:
        return [1]
    case 2:
        return [1, 1]
    default:
        let tail = fibonaccis(n: n - 1).dropFirst()
        return [1, 1] + zipWith(fst: Array(tail), snd: fibonaccis(n: n - 2))
    }
}


fibonaccis(n: 10)
// [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
{% endhighlight %}

递归实现一些算法往往比循环要简洁明了，但是效率比较低，原因是每次调用都要分配和管理栈帧，甚至可能导致栈溢出。
