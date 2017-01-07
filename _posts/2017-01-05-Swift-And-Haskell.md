---
layout: post
date: 2017-01-05
title: Swift And Haskell
feature-img: "img/orange.jpg"

---

<h2>一、为什么是 Haskell ?</h2>
---
一句话，只因 **Haskell** 有趣。

第一次看到 **Haskell** 这个字眼是在看[《函数式Swift》](https://objccn.io/products/functional-swift/)这本书中(是一本不错的书)，里面曾多次提到 **Haskell** 并与 **Swift** 做以比较，所以就起了了解 **Haskell** 的心思，一本书才读了不多，发现 **Haskell** 非常有趣，尤其是对数学的支持，简直无情，堪称完美。想像一下像做数学题一样编程是什么样子？

$$ f(x) = \int \frac{2x^2+4x+6}{x-2} $$

<h2>二、常量 </h2>
在 **Swift** 中声明一个 **常量** 像这样
{% highlight swift %}
let a = 5
let some: String = "something"
{% endhighlight %}
在 **Haskell** 中声明 **常量**
{% highlight haskell %}
Prelude> let a = 5
Prelude> let some = "something"
{% endhighlight %}
[GHC](https://www.haskell.org/ghc/download_ghc_7_0_3) 是 **Haskell** 解释器的一种，Prelude> 是 GHC 的默认提示符，可以通过下面代码更换成你想要的，比如
{% highlight haskell %}
Prelude> :set prompt "ghci>"
ghci>
{% endhighlight %}

<h2>二、变量 </h2>
---
在 **Swift** 中声明一个 **变量** 像这样
{% highlight swift %}
var a = 5
var someVar: String = "something"
{% endhighlight %}
在 **Haskell** 中声明变量，在编辑器里输入以下内容，并将其保存为 **test.hs**
{% highlight haskell %}
a = 5
a = 8
{% endhighlight %}
将 **test.hs** 载入，像这样
{% highlight haskell %}
ghci>:l test.hs
{% endhighlight %}
不幸的是，GNC 告诉我们无法载入，并告诉一些错误信息以提示我们
{% highlight shell %}
[1 of 1] Compiling Main             ( test.hs, interpreted )

test.hs:2:1: error:
    Multiple declarations of ‘a’
    Declared at: test.hs:1:1
                 test.hs:2:1
Failed, modules loaded: none.
{% endhighlight %}
**:l** 是 **:load** 简写，如果之前已经载入过这一文件，经过一些编辑之后，需要重新载入可以使用 **:r** ，它是 **:reload** 的简写。言归正传，显然像这样是没法声明变量的。在 **Haskell** 中，声明了一个变量 **a** 的值为5，那它就是5，不能再是其他值。这不就是常量吗？的确，但是不能说 **Haskell** 就没有变量。在 **Haskell** 中怎么找到变量的身影，在 ghci> 下，输入 **:t head**
{% highlight haskell %}
ghci>:t head
head :: [a] -> a
{% endhighlight %}
**:t** 是 **:type** 的简写，语意是“查看类型”。**::** 与 **Swift** 中的 **:** 一样，表示这是什么类型。所以 **head** 的类型是参数为 **a** 类型的数组，返回类型为 **a** 的值。在这里的 **a** 可以理解为变量，确切说应该是类型占位。举个🌰
{% highlight haskell %}
ghci>head [1, 2, 3]
1
ghci>head ["hello", "my", "friend"]
"hello"
{% endhighlight %}
一目了然了吧！相信 **head** 能干啥也已经非常清楚了！

<h2>三、数组 </h2>
---
**Swift** 中的数组是这样
{% highlight swift %}
let someArray = [1, 2, 3]
var anotherArray: [String] = []
{% endhighlight %}
