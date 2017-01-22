---
layout: post
date: 2017-01-21
title: Haskell And Swift （递归二）
feature-img: "img/darkgray.jpg"
---

[前一篇文章](https://redtwowolf.github.io/2017/01/16/Haskell-And-Swift-Recursion.html)中已经认识了 **递归** 是什么，并利用递归实现了斐波拉契数列。这篇就来看看更多的递归操作以及如何在 *Swift* 中更高效的使用递归。

更多的递归函数
---

> **zip**

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

2. 匹配第三个模式，(1:xs) ('a':ys) 然后递归调用 zip'
-- (1,'a'):zip' xs ys

3. 仍然匹配第三个模式，(2,[]) ('b',[])  继续递归调用 zip'
-- (1,'a'):(2,'b'):zip' [] []

4. 匹配第一个模式
-- (1,'a'):(2,'b'):[]

5. 得到结果
-- [(1,'a'),(2,'b')]
{% endhighlight %}

> **maximum**

**maximum** 函数作用是返回一个 List 中的最大值。

{% highlight haskell %}
ghci>maximum [1, 2, 9] -- 9
{% endhighlight %}

如何用递归的思路实现它？取一个 List 中的最大值或者最小值无非就是比较，把一个 List 看作又头部和尾部组成，只需要比较头和尾，谁大那么谁就是 *maximum* 。

{% highlight haskell %}
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "What's maximum of empty list? you tell me."
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)
{% endhighlight %}

以上就是所述思路的实现。在 **test.hs** 中编辑 *maximum'* 函数，对于空 List 不知道最大值是什么，所以以 **error** 函数报错，这也模仿了 *Prelude.maximum* ，对于单个元素的就更简单了，连考虑都不用直接返回，多个元素的 List 则分为头和尾利用 **max** 函数比较找出最大值。

{% highlight haskell %}
ghci>max
max       max'      maxBound  maximum   maximum'

ghci>maximum' [1, 2]
2

ghci>maximum' [1, 9, 7]
9

ghci>maximum' "Haskell"
's'
{% endhighlight %}

比如找出 [1, 9, 7] 这个 List 中最大值的执行过程是这样：

{% highlight haskell %}
1. maximum' [1, 9, 7]

2. 匹配第三个模式，(1:xs) = max 1 (maximum' xs) -- 开始递归调用

3. maximum' xs 继续匹配第三那个模式，(9:[7]) = max 1 (max 9 (maximum' [7])) -- 继续递归调用

4. maximum' [7] 匹配第二个模式，直接返回 7

5. 这时看起来是这样 max 1 (max 9 7) -- 所以结果是 9 啦！！！

{% endhighlight %}
