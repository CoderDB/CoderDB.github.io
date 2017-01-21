---
layout: post
date: 2017-01-21
title: Haskell And Swift （递归二）
feature-img: "img/darkgray.jpg"
---

[前一篇文章](https://redtwowolf.github.io/2017/01/16/Haskell-And-Swift-Recursion.html)中已经认识了 **递归** 是什么，并利用递归实现了斐波拉契数列。这篇就来看看更多的递归操作以及如何在 *Swift* 中更高效的使用递归。

更多的递归函数
---

> zip

关于 **zip** 函数已经接触很多次了，也很熟悉它了。那么就来看看怎么实现它吧！

{% highlight haskell %}
zip' :: [a] -> [b] -> [(a, b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x, y):zip' xs ys
{% endhighlight %}

声明一个 *zip'* 函数在 **test.hs** 中，它接受两个 List 做参数，返回一个元素是 *Tuple* 的 List 。将 **test.hs** 加载到 ghci 测试一下🌰🌰🌰🌰🌰

{% highlight haskell %}
ghci>:l test.hs
[1 of 1] Compiling Main             ( test.hs, interpreted )
Ok, modules loaded: Main.

ghci>zip
zip       zip'      zip3      zipWith   zipWith3

ghci>zip' [1, 2] ['a', 'b']
[(1,'a'),(2,'b')]
{% endhighlight %}

*zip'* 函数有三个模式，第一、二个模式表示若参数中有一个 List 为空，则返回空 List ，第三个模式将两个参数 List 都分为首部和尾部，先将头部配对，剩下的尾部则递归调用自身，最终当触碰到边界条件时得到一个 [] ，这时将配对的头部插入到 [] 并返回。比如将 [1, 2] ['a', 'b'] 进行 *zip'* 的执行过程看起来像这样：

{% highlight haskell %}
1. zip' [1, 2] ['a', 'b']

2. 匹配第三个模式，(1:xs) ('a':ys)
-- (1,'a'):zip' xs ys

3. 仍然匹配第三个模式，(2,[]) ('b',[])
-- (1,'a'):(2,'b'):zip' [] []

4. 匹配第一个模式
-- (1,'a'):(2,'b'):[]

5. 得到结果
-- [(1,'a'),(2,'b')]
{% endhighlight %}
