---
layout: post
date: 2017-01-23
title: Haskell And Swift (函数)
feature-img: "img/pink.jpg"
---

函数其实和变量一样，很简单，就是编写一段代码绑到一个名字上，绑到变量上就叫变量，绑到函数上就叫函数。

不要一听函数就觉得这东西比较高级，牛逼，一听到高阶函数就已经腿软，什么匿名、函数指针、柯里化就更别提了！ 都一样的，没什么太大不同，只不过一个名字罢了！不要在还没了解之前就心里就已经在暗示这东西不好弄，这心情真的会让你觉的这东西还真不好弄😁😁😁 在这里说一下我的学习经验，首先不要一遇到新名词就翻天覆地的查个遍，最终真的是搞清楚了这个名词，结果两小时一篇文章只看了个开头，而没有把握到这篇文章对一个问题的全面的概括或论述，然而这时你很可能已经没有了将文章认真读完的心情。我认为这是典型的将问题复杂化了！(多年前的我就是这样🤓🤓🤓所以我认为这真的很重要)学习势必要不断接触到新的名词，这些新的名词就像宇宙中围绕某个星球的小星星，而一篇文章很可能就是一颗小星球，如果一遇到新名词就立刻去深入了解它，就像你想要通过一颗小星星的视角去窥探整个星球。围绕星球运转的星星不计其数，什么时候才能将所有的星星走个便？什么时候才能建立起针对某个星球的体系呢？🤔🤔🤔 学习要尽量让问题简单化，先记住这些名词，认真看完文章，或许你只花了四十分钟就了解了整颗星球的轮廓，了解了星球是怎么和星星沟通的，了解了它是怎么运转的等等。这时回头再去研究小星星，或许你不能完全清楚的知道怎么操作它，但很可能你已经知道它能做什么了。学习时心理作用也很重要，潜意识中脑子只会选择记住那些很重要的东西，有意识低告诉自己这个问题很重要或许能帮助你更快的记住它。扯的有点多了！回到函数上来，这里就不说啥是函数了！直接上函数😀😀😀😀😀😀😀



 !学习就像大海捞针
---

![学习就像宇宙爆炸](http://ogkg37m8j.bkt.clouddn.com/image/jpg/haskellandswift/function/star.jpg)

⚠️⚠️⚠️ 前面有个感叹号❕❕❕❕❕❕❕❕❕❕❕❕❕❕

函数
---

![function](http://ogkg37m8j.bkt.clouddn.com/image/jpg/haskellandswift/function/function.jpg)

这就是函数啦！它就干这点事儿······



Curried Functions
---
---

函数柯里化，或者柯里化函数说的就是看似它接受多个参数，实则只接受一个参数，返回一个函数，每个返回的函数都接受一参数，剩下的参数作为返回函数的参数。

举个例子🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰就像[之前文章](https://redtwowolf.github.io/2017/01/15/Haskell-And-Swift-Guard.html)中实现的 *max'* 它和 *max* 做一样的事情

{% highlight haskell %}
max' :: (Ord a) => a -> a -> a
max' x y
    | x > y = x
    | otherwise = y
{% endhighlight %}

当时我们和 *max* 函数比较并做了这样的测试：

{% highlight haskell %}
ghci>max' 10 8
10

ghci>max 10 8
10
{% endhighlight %}

现在我们这样来测试它。

{% highlight haskell %}
ghci>max' 10 8
10

ghci>(max' 10) 8
10
{% endhighlight %}

发现也是可以的。"*(max' 10) 8*" 是什么意思呢？是以 10 呼叫 *max'* 函数得到一个"结果"，然后又以 8 呼叫这个"结果"。我们明明定义的类型是 "max' :: (Ord a) => a -> a -> a" ，实际上这个类型是这样的 "max' :: (Ord a) => a -> (a -> a)" ，它接受一个参数，返回一个函数，返回的函数又接受一个参数，返回一个值。这不正是柯里化函数嘛！😬😬😬😬😬实际上 *Haskell* 中的函数都是柯里化函数。那么来将 *max'* 的类型改变一下就叫 *max''*。

{% highlight haskell %}
max'' :: (Ord a) => a -> (a -> a)
max'' x y
    | x > y = x
    | otherwise = y
{% endhighlight %}

再来测试一下看是不是如上所述。🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰

{% highlight haskell %}
ghci>(max'' 10) 8
10

ghci> max'' 10 8
10
{% endhighlight %}

那么 "*(max'' 10) 8*" 是怎么工作的呢？

{% highlight haskell %}
1. (max'' 10) 8
2. 先以 10 呼叫 max'' 并返回一个(a->a)函数
3. (a->a)函数传入 a 并返回 a ，8 -> 8
3. 再以 8 呼叫
{% endhighlight %}

这个例子还不够明显，再举一个例子🌰🌰🌰🌰🌰🌰🌰。在 **test.hs** 文件中声明一个名为 *mulThree* 的函数，他的作用是将三个数乘起来。

{% highlight haskell %}
-- mulThree
mulThree :: (Num a) => a -> a -> a -> a
mulThree x y z = x * y * z
{% endhighlight %}

加载到 ghci 中，测试一下。

{% highlight haskell %}
ghci> mulThree 1 2 3
6

ghci> mulThree 3 4 5
60
{% endhighlight %}

比如 mulThree 3 4 5 是这样工作的：

{% highlight haskell %}
1. mulThree 3 4 5
2. 首先以 3 呼叫 mulThree ，返回一个(a->(a->a))函数
3. 再以 4 呼叫
{% endhighlight %}






$$f(g(x))$$
---
---

高阶函数就是把一个函数作为另一个函数的参数。