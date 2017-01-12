---
layout: post
date: 2017-01-11
title: Haskell And Swift (Type)
feature-img: "img/pink.jpg"
---

<h2>Type</h2>
---

**Haskell** 是静态类型，就是说 Haskell 中所有的东西都有自己的类型，且在编译时已经确定。使用 **:t** 命令即可得到表达式的类型，这已经在之前的文章里面使用过。

{% highlight haskell %}
-- 单个字符
ghci>:t 'a'
'a' :: Char

-- 数字
ghci>:t 1
1 :: Num t => t
ghci>:t 1.0
1.0 :: Fractional t => t

-- Bool
ghci>:t False
False :: Bool

ghci>:t 1 == 1
1 == 1 :: Bool

-- Tuple
ghci>:t (1, 2)
(1, 2) :: (Num t1, Num t) => (t, t1)

ghci>:t ('a', 1)
('a', 1) :: Num t => (Char, t)

-- List
ghci>: [1, 2]
[1, 2] :: Num t => [t]

ghci>:t "Haskell"
"Haskell" :: [Char]

-- 函数
ghci>:t head
head :: [a] -> a

ghci>:t odd
odd :: Integral a => a -> Bool

ghci>:t sum
sum :: (Foldable t, Num a) => t a -> a
{% endhighlight %}

**::** 表示这是什么类型。如果你想察看某一表达式的类型，就用 **:t** 。下面声明一个带类型声明的函数，在 **test.hs** 中，编写以下内容，
{% highlight haskell %}
circumference :: Float -> Float
circumference r = 2 * pi * r
{% endhighlight %}
然后使用 **:l** 将 **test.hs** 加载进来，像这样👇👇👇👇👇👇👇
{% highlight haskell %}
ghci>:l test.hs
[1 of 1] Compiling Main             ( test.hs, interpreted )
Ok, modules loaded: Main.
ghci>
{% endhighlight %}
这样我们就可以在 ghci 下调用啦！来算一算半径是10的圆的周长。
{% highlight haskell %}
ghci>circumference 10
62.831856

-- 声明的是 Float 单精度浮点类型
ghci>:t circumference
circumference :: Float -> Float

-- pi 是关键字
ghci>pi
3.141592653589793
{% endhighlight %}
在 **test.hs** 中再声明一个 **circumference'** 同样也是求圆周长的函数，但它的参数和返回值类型都是 **Double** ，还有一个名为 **circleArea** 参数返回值也都是 **Double** 计算圆面积的函数。
{% highlight haskell %}
circumference' :: Double -> Double
circumference' r = 2 * pi * r

circleArea :: Double -> Double
circleArea r = pi * r * r
-- 你也可以像这样调用另一个函数 circumference' r ^ 2 / (4 * pi)
{% endhighlight %}
用 **:r** 命令将 **test.hs** 文件 reload 一次，再来计算一下半径为10的圆的周长和面积。
{% highlight haskell %}
ghci>:r
[1 of 1] Compiling Main             ( test.hs, interpreted )
Ok, modules loaded: Main.

ghci>circumference' 10
62.83185307179586

ghci>circleArea 10
314.1592653589793
{% endhighlight %}

<h2>Type Variables</h2>
---
{% highlight haskell %}
ghci>:t head
head :: [a] -> a
{% endhighlight %}
这里的 **a** 是什么？类型？不是，在 Haskell 中凡是类型的首字母必须大写，像 **Char, Float Bool** 等，所以不能声明首字母大写的变量或函数。在[前一篇](https://redtwowolf.github.io/2017/01/05/Haskell-And-Swift.html)文章中我们有提到过 **head** 并分析了 **a** 发现它与泛型很像，在 Haskell 中它被称为类型变量，使用到类型变量的函数称作 *多态函数* 。**head** 就是一个多态函数。
