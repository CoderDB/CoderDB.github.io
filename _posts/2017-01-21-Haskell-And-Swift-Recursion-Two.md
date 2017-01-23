---
layout: post
date: 2017-01-21
title: Haskell And Swift （递归二）
feature-img: "img/darkgray.jpg"
---

[前一篇文章](https://redtwowolf.github.io/2017/01/16/Haskell-And-Swift-Recursion.html)中已经认识了 **递归** 是什么，并利用递归实现了斐波拉契数列。这篇就来看看如何更好的使用递归。

更多的递归函数
---

> **repeat**

**repeat** 函数返回某个元素的无限 List 。

{% highlight haskell %}
repeat 3
[3,3,3,3,3,3,3,3,3,3......]
{% endhighlight %}

用递归去实现 **repeat** 非常简单。

{% highlight haskell %}
repeat' :: a -> [a]
repeat' x = x:repeat' x
{% endhighlight %}

很简单吧！在 **test.hs** 文件中 声明 *repeat'* 函数，它接受一个参数并返回包含这个参数的 List 。*repeat' 3* 的执行过程就是不停的将 3 插入到 *repeat' 3* 返回的 List 中。

{% highlight haskell %}
ghci>rep
repeat     repeat'    replicate

ghci>repeat' 4
[4,4,4,4,4,4,4,4,4,.......

ghci>take 5 (repeat' 6 )
[6,6,6,6,6]
-- 这里用到了 take 函数，表着急，下面说，不过你应该已经知道他能干啥了！
{% endhighlight %}

> **take**

**take** 函数返回一个 List 的前 n 项。

{% highlight haskell %}
ghci>:t take
take :: Int -> [a] -> [a]

ghci>take 2 [1, 2, 3, 4, 5]
[1,2]

ghci>take 3 "Haskell"
"Has"

ghci>take (-10) [1, 2]
[]
{% endhighlight %}

不过 **take** 函数有几个边界条件，当取负数或 0 个 List 元素时会返回空 List ，在空 List 中取元素当然也返回空 List 。用递归实现它看起来像这样：

{% highlight haskell %}
take' :: (Integral n) => n -> [a] -> [a]
take' n _
    | n <= 0   = []
take' _ []     = []
take' n (x:xs) = x:take' (n-1) xs
{% endhighlight %}

还记得 **guard** 吗？ *take'* 函数的第一个模式中就用到它了，并且这个 **guard** 没有 **otherwise** 部分哦！这表示当 n > 0 时就直接进入下一模式。 *take'* 函数的前两个模式分别实现了刚说的边界条件。提醒一下，模式匹配的顺序很重要，如果把第二个模式和第一个模式相互交换，那么最先匹配的则是空 List，而不是小于等于 0 的数，在这里就算交换了对性能看起来影响并不大。到底判断一个 List 是否为空简单呢？还是判断一个数小于 0 简单呢？🤔🤔🤔🤔🤔🙇🙇🙇🏿🙇🏿🙇🏿🙇🏿🙇🏿🙇🏿🙇🏿🙇🏿🙇🏿
将 *take'* 函数加载进来测试一下。
{% highlight haskell %}
ghci>take
take       take'      takeWhile

ghci>take' 10 (repeat' 5)
[5,5,5,5,5,5,5,5,5,5]

ghci>take' 3 "Haskell"
"Has"
{% endhighlight %}

看看 *take' 3 "Haskell"* 是怎么工作的：

{% highlight haskell %}
1. take' 3 "Haskell"

2. 匹配第三个模式， 3 ('H':xs) = 'H':take' 2 xs -- 开始递归调用

3. 继续匹配第三个模式，2 ('a':xs) = 'a':take' 1 xs

4. 仍然匹配第三个模式，1 ('s':xs) = 's':take' 0 xs

5. 匹配第一个模式，返回 []

6. 现在结果看起来应该是这样 'H':'a':'s':[]
-- 所以结果是 "Has"
{% endhighlight %}

> **replicate**

**replicate** 函数返回 n 个重复元素的 List 。

{% highlight haskell %}
ghci>replicate 5 3
[3,3,3,3,3]

ghci>replicate 3 (1, 2)
[(1,2),(1,2),(1,2)]

ghci>replicate 3 'a'
"aaa"

ghci>replicate 3 "a"
["a","a","a"]
{% endhighlight %}

用递归来实现它。

{% highlight haskell %}
replicate' :: (Integral n) => n -> a -> [a]
replicate' n x
    | n <= 0 = []
    | otherwise = x:replicate' (n-1) x
{% endhighlight %}

测试测试🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰

{% highlight haskell %}
ghci>replicate
replicate   replicate'

ghci>replicate' 5 3
[3,3,3,3,3]

ghci>replicate' 3 "a"
["a","a","a"]

ghci>replicate' 3 (1, 2)
[(1,2),(1,2),(1,2)]

ghci>replicate' (-10) 5
[]
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

> **reverse**

**reverse** 函数将一个 List 首尾颠倒并返回。

{% highlight haskell %}
ghci>reverse [1, 2, 3]
[3,2,1]

ghci>reverse "Haskell"
"lleksaH"
{% endhighlight %}

在 *Haskell* 中将一个 List 分为头部和尾部是非常有用有效又清晰的的方法。用递归实现 **reverse** 还是这个思路，把头和尾颠倒一下就👌了！😄😄😄😄😄

{% highlight haskell %}
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]
{% endhighlight %}

测试一下 *reverse'* 看它是否如你所想。

{% highlight haskell %}
ghci>reverse
reverse   reverse'

ghci>reverse' "Haskell"
"lleksaH"

ghci>reverse' [1, 2, 3]
[3,2,1]

ghci>reverse' ""
""
{% endhighlight %}

总结
---
---

写了这么多递归，也发现了一些递归的规律。总是将一个问题分解成多个模块，然后单独为每个模块匹配合适的代码，很有成效的将一个复杂问题分解成几个简单的小问题。总是要有边界条件，就像 **if** 语句的判断条件一样，考虑好边界条件之后，只需要单独针对一个元素去考虑真正解决问题代码，然后其他的元素都是递归调用自身。就像斐波拉契数列，定义好（0 = error "some error", 1 = 1, 2 = 2）这些边界条件，剩下只需要考虑 $$a_n = a_{n-1} + a_{n-2}$$ 就像考虑 3 = 2 + 1 一样，而其余元素都是递归调用。真正像列数学题一样的编程，真的是倍爽。

* [可以在这里下载到相关的 Playground](https://github.com/redtwowolf/redtwowolf.github.io/tree/master/_code/HaskellAndSwift/Recursion.playground)
* [test.hs](https://github.com/redtwowolf/redtwowolf.github.io/blob/master/_code/HaskellAndSwift/test.hs)
