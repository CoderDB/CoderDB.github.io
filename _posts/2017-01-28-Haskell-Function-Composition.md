---
layout: post
date: 2017-01-28
title: Haskell 中的 Function Composition
feature-img: "img/orange.jpg"
---

$$(f \circ g)(x) = f(g(x))$$
---

数学中 $$(f \circ g)$$ 这样表示将 f g 两个函数复合，Haskell 中的函数组合与数学中的一样，只不过不用 $$ \circ $$ 而是用一个点。举个例子 🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰

{% highlight haskell %}
ghci> (length.tail) "haskell"
6
{% endhighlight %}

f.g 实际上就是匿名函数。比如 f.g 的实现事实上就是这样：

{% highlight haskell %}
f.g = \x -> f (g x)
{% endhighlight %}

**函数组合可以同时组合多个函数**。比如 $$f \circ g \circ z$$ 用 Haskell 实现就是 f (g (z x)) 举个例子

{% highlight haskell %}
ghci> (negate.sum.tail) [1, 2, 3]
-5
-- 先做 tail [1, 2, 3] => [2, 3]
-- 然后 sum [2, 3]     => 5
-- 最后 negate 5       => -5
{% endhighlight %}

**negate** 取一个数的相反数。

{% highlight haskell %}
ghci> :t negate
negate :: Num a => a -> a

ghci> negate 0
0

ghci> negate 5
-5

ghci> negate (-(-20))
-20
{% endhighlight %}

函数组合是右结合的，但是把 f (g (z x)) 实现成 (f.g.z) x 总感觉不是很明确，像是先把 f.g.z 合成一个新的函数再用 x 去呼叫一样。有一种方法或许好一点，那就是用 **$** 符号， f (g (z x)) 就可以写成 f $ g $ z x 。上述的例子就可以改写为：

{% highlight haskell %}
ghci> negate $ sum $ tail [1, 2, 3]
-5
{% endhighlight %}

**$** 是 *函数呼叫符*。它的优先级最低，空格呼叫的函数是左结合的，而 **$** 呼叫的函数是右结合的。比如 f x y z 是左结合即：((f x) y) z ，如果用 **$** 呼叫的话应该是这样：f (x (y z)) 因为它是右结合的。**$** 看上去像是起一对括号的作用。😹😹😹😹😹😹

**函数组合也能够应用于需要多个参数的函数**。之所以能行就是因为函数的 *不全呼叫*，事实上没有多个参数的函数😸😸😸😸😸

{% highlight haskell %}
ghci> take 5 . replicate 10 $ 8
[8,8,8,8,8]

ghci> take 5 $ replicate 10 $ 8
[8,8,8,8,8]

ghci> take 5 (replicate 10 8)
[8,8,8,8,8]
{% endhighlight %}
