---
layout: post
date: 2017-01-23
title: Haskell And Swift (函数)
feature-img: "img/pink.jpg"
---

函数其实和变量一样简单。变量是一个名词牵着一个字符串或其他什么，函数就是一个名词牵着一段代码块，甚至连这个名词都不需要。

题外话
---
---

大学的时候，教C语言的老师讲到函数指针一节时，说这东西对于你们来说太难了！就算讲了你们也不能理解而且这个不会作为考试内容，所以我们就不讲了！大家一篇欢呼。我当时就呵呵了！拿钱不干事儿 😡😡😡😡😡😡😡😡😡😡😡😡😡 不过你爱讲不讲，反正我又不学 😆😆😆😆😆😆😆😆😆😆😆😆

老师眼里像我这样儿的搁哪儿都是刺头，早都是狗改不了吃屎，土话说“还不如填沟的一锨土”。但是私下里我是下了死手的看大家都不懂，连老师都不讲的内容，等着有朝一日打他们的脸。 从这个时候起就有了一个心眼儿，不要一听自己连了解都没了解过的东西就说这太难了！更不要把别人说的太难直接变成自己的太难。

<h3>强行分享学习经验</h3>

在这里分享一下我的学习经验，首先不要一遇到新名词就翻天覆地的查个遍，最终真的是搞清楚了这个名词，结果两小时一篇文章只看了个开头，而没有把握到这篇文章对一个问题的全面的概括或论述，然而这时你很可能已经没有了将文章认真读完的心情。我认为这是典型的将问题复杂化了！(多年前的我就是这样🤓🤓🤓所以我认为这真的很重要) 那该怎么办呢？

学习势必要不断接触到新的名词，这些新的名词就像宇宙中围绕某个星球的小星星，而一篇文章很可能就是一颗小星球。如果一遇到新名词就立刻去深入了解它，就像你想要通过一颗小星星的视角去窥探整个星球。围绕星球运转的星星不计其数，什么时候才能将所有的星星走个便？什么时候才能建立起针对某个星球的体系呢？🤔🤔🤔 学习要尽量让问题简单化，先了解或记住这些名词，认真看完文章，或许你只花了四十分钟就了解了整颗星球的轮廓，了解了星球是怎么和星星沟通的，了解了它是怎么运转的等等。这时回头再去研究小星星，或许你不能完全清楚的知道怎么操作它，但很可能你已经知道它能做什么了。
![star](http://ogkg37m8j.bkt.clouddn.com/image/jpg/haskellandswift/function/star.jpg)


学习时心理作用也很重要。一听到高阶函数就觉得啥子鬼，什么匿名、函数指针、柯里化就别提了！ 要告诉自己都一样的，没什么太大不同，只不过一个名字罢了！不要在还没了解之前就心里就已经在暗示这东西不好弄，这心情真的会让你觉的这东西还真不好弄😁😁😁😁😁😁😁😁😁😁😁😁😁😁

扯的有点多了！回来吧···回来吧···回来···吧我的······


函数
---
---

![func](http://ogkg37m8j.bkt.clouddn.com/image/jpg/haskellandswift/function/function.jpg)

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
-- 将 test.hs 加载进来
ghci>:l test.hs
[1 of 1] Compiling Main             ( test.hs, interpreted )
Ok, modules loaded: Main.

ghci>max
max       max'      max''     maxBound  maximum   maximum'

ghci>(max'' 10) 8
10

ghci> max'' 10 8
10
{% endhighlight %}

那么 *(max'' 10) 8* 是怎么工作的呢？

{% highlight haskell %}
1. (max'' 10) 8

2. 先以 10 呼叫 max'' 并返回一个(a->a)函数

3. (a->a)函数将 8 做为参数传入

4. 最终返回比较结果
{% endhighlight %}

如果以 Swift 来的观点来看可能会更加清晰。

{% highlight swift %}
func myMax(_ a: Int) -> (Int) -> Int {
    return { (b: Int) -> Int  in  // 返回一个 (Int) -> Int 这样的函数
        return a > b ? a : b
    }
}
{% endhighlight %}

像这样来调用试一试。

{% highlight swift %}
myMax(10)(8)
// 10
{% endhighlight %}

![](http://ogkg37m8j.bkt.clouddn.com/image/jpg/haskellandswift/function/curriedfunction.jpg)

这个例子还不够明显，再举一个例子🌰🌰🌰🌰🌰🌰🌰 在 **test.hs** 文件中声明一个名为 *addThree* 的函数，他的作用是将三个数加起来。

{% highlight haskell %}
-- addThree
addThree :: (Num a) => a -> a -> a -> a
addThree x y z = x + y + z
{% endhighlight %}

加载到 ghci 中，测试一下。

{% highlight haskell %}
ghci>addThree 1 3 4
8

ghci>let addTwo = addThree 1 3
ghci>addTwo 4
8
{% endhighlight %}

比如 addThree 3 4 5 是这样工作的：

{% highlight haskell %}
1. addThree 3 4 5

2. 首先以 3 呼叫 addThree ，返回一个(a->(a->a))函数

3. 再以 4 呼叫 addThree ，返回一个 (a->a) 函数，此时回传的函数已经与 3 相加

4. 再以 5 呼叫 addThree ，返回三数相加结果
{% endhighlight %}

如果用 Swift 来实现的话，像这样：

{% highlight swift %}
func addThree(_ a: Int) -> (Int) -> (Int) -> Int {
    return {(b: Int) -> (Int) -> Int in
        return {(c: Int) -> Int in
            return a + b + c
        }
    }
}
{% endhighlight %}

还可以写的更简单些。

{% highlight swift %}
func addThree(_ a: Int) -> (Int) -> (Int) -> Int {
    return { b in
        return { c in
            return a + b + c
        }
    }
}
{% endhighlight %}

调用起来是这样：
{% highlight swift %}
addThree(3)(4)(5)
// 12

let addTwo = addThree(3)(4)
addTwo(5)
// 12
{% endhighlight %}


<h3>不全呼叫</h3>

你肯定发现了前面这样来调用 *addThree* 函数

{% highlight haskell %}
ghci>let addTwo = addThree 1 3
ghci>addTwo 4
8
{% endhighlight %}

这被称作 **不全呼叫** 的函数。所谓 *不全呼叫* 就是参数不全的呼叫函数。比如 *addTwo* 这个函数就是不全呼叫，它是把 *addThree 1 3* 的返回函数绑定到自己身上。

{% highlight haskell %}
ghci>:t addTwo
addTwo :: Num a => a -> a

ghci>:t addThree 1 3
addThree 1 3 :: Num a => a -> a
{% endhighlight %}

就像刚刚的 *addTwo* 一样，*不全呼叫* 还可以轻松地创建函数。比如将 *addThree 2* 绑定到 *addOne* 上又是一个不全呼叫产生的函数。



$$f(g(x))$$
---
---

高阶函数就是把一个函数作为另一个函数的参数。

还记得[之前](https://redtwowolf.github.io/2017/01/19/Haskell-And-Swift-Recursion.html)的那个 **zipWith** 函数嘛？记得它的型别嘛？

{% highlight haskell %}
ghci>:t zipWith
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
{% endhighlight %}

它接受三个参数，第一个参数是一个 a -> b -> c 型别的函数。刚刚的 *addOne* 是什么型别呢？

{% highlight haskell %}
ghci>:t addOne
addOne :: Num a => a -> a -> a
{% endhighlight %}

虽然 zipWith 要求的函参是 a -> b -> c 的，那么 a -> a -> a 的型别行不行呢？

{% highlight haskell %}
ghci>zipWith addOne [1, 2] [3, 4]
[6,8]
-- what? 😱😱😱 怎么是 [6, 8] 不应该是 [4, 6] 吗？ 😳😳😳😳😳😳
-- 别忘了 addOne = addThree 2

ghci>addOne 3 4
9
{% endhighlight %}

看！这就是将一个函数作为参数传给另一个函数，这就是高阶函数。再比如将前面的 max'' 函数传入 **zipWith** ，因为它的型别也符合 **zipWith** 函参的要求。

{% highlight haskell %}
ghci>:t max''
max'' :: Ord a => a -> a -> a

ghci>zipWith max'' [1, 2] [3, 4, 8, 9]
[3,4]
{% endhighlight %}


<h3>map</h3>

高阶函数怎么能少的了 **map** 。😎😎😎😎😎😎😎

**map** 是对一个 List 中的每个元素做操作后生成一个新的 List 返回。

{% highlight haskell %}
ghci>:t map
map :: (a -> b) -> [a] -> [b]

ghci>map (+1) [1, 2, 3]
[2,3,4]
-- 对一个 List 的每个元素加 1

ghci>map (replicate 3) [2, 3, 4]
[[2,2,2],[3,3,3],[4,4,4]]
-- 对 [2, 3, 4] 的每个元素做 replicate 3 x 操作，返回3个2，3个3，3个4
{% endhighlight %}


<h3>filter</h3>

**filter** 函数是从一个 List 中筛选出一组数据形成一个新的 List 。

{% highlight haskell %}
ghci>:t filter
filter :: (a -> Bool) -> [a] -> [a]

ghci>filter (>5) [1, 7, 9, 0, -10]
[7,9]
-- 大于5的所有元素

ghci>filter (`elem` ['A'..'Z']) "I am a good man"
"I"
-- 筛选出大写字母
{% endhighlight %}



Anonymous Function
---
---

**匿名函数** 就是没有名字的函数。

匿名很好理解，知道匿名信就知道匿名，所谓匿名就是不写名字嘛！😁😁😁😁😁😁 在 Haskell 中这样使用匿名函数，比如之前的 **map** 有一个对 List 中每个元素 +1 的操作，它可以这样写：

{% highlight haskell %}
ghci>map (\x -> x + 1) [1, 2, 3]
[2,3,4]
{% endhighlight %}

如你所见，以 \ 开始，后面是参数，-> 后面是函数体。再比如将两个 List 的元素乘起来

{% highlight haskell %}
ghci>zipWith (\x y -> x * y) [1, 2] [3, 4, 8, 9]
[3,4]
{% endhighlight %}

再比如对一个元素都是 Tuple 的 List 做加法。

{% highlight haskell %}
ghci>map (\(x, y) -> x + y) [(1, 2), (3, 4), (5, 6)]
[3,7,11]
{% endhighlight %}

> **foldl**

{% highlight haskell %}
ghci>:t foldl
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
{% endhighlight %}

*左折叠* 它从 List 的左端开始折叠，传入一个初始值，并用初始值逐个与 List 的元素呼叫第一个函数参数得到累加值。

{% highlight haskell %}
ghci>foldl (+) 5 [1, 2, 3, 4]
15
-- 它的执行过程是这样
-- 5 + 1 => 6
-- 6 + 2 => 8
-- 8 + 3 => 11
-- 11 + 4 => 15

ghci>foldl (+) 0 [1, 2]
3
{% endhighlight %}

> 用 **foldl** 重写 **sum** 函数

**sum** 是对 List 中的元素求和的函数，[之前的文章](http://redtwowolf.github.io/2017/01/14/Haskell-And-Swift-Pattern-Match.html)中也有实现自己的 *sum'* 函数，在这里用匿名函数和 **foldl** 来重写它。在 **test.hs** 文件中创建 *sum''* 函数像这样：

{% highlight haskell %}
-- sum''
sum'' :: (Num a) => [a] -> a
sum'' xs = foldl (\acc x -> acc + x) 0 xs
{% endhighlight %}

为 **foldl** 函数传入一个 *(\acc x -> acc + x)* 的累加函数，这其实和 *(+)* 一样的，所以上述也可以改写为下面这样：

{% highlight haskell %}
-- sum'''
sum''' :: (Num a) => [a] -> a
sum''' = foldl (+) 0
{% endhighlight %}
怎么是这样？🤔🤔🤔🤔🤔🤔 怎么连需要传入的 List 都没有了？别忘了上面刚刚说过的不全呼叫函数哦！*foldl (+) 0* 会回传一个 *[a] -> a* 的函数哦！😃😃😃😃😃😃😃😃😃 测试一下 🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰

{% highlight haskell %}
ghci>sum
sum     sum'    sum''   sum'''

ghci>let test = [1, 2, 3, 4, 5]

ghci>sum test
15

ghci>sum' test
15

ghci>sum'' test
15

ghci>sum''' test
15
{% endhighlight %}

> **foldr**

{% highlight haskell %}
ghci>:t foldr
foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
{% endhighlight %}

*右折叠* 与左折叠一样，只是从右边开始而已。

{% highlight haskell %}ghci>
ghci>foldr (+) 5 [1, 2, 3, 4]
15
-- 它的执行过程是这样
-- 4 + 5 => 9
-- 9 + 3 => 12
-- 12 + 2 => 14
-- 14 + 1 => 15
{% endhighlight %}

> **foldr** 实现 **map**

在 **test.hs** 中声明一个 *map'* 的函数，它与 **map** 是兄弟😂😂😂😂😂

{% highlight haskell %}
-- map'
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x:acc) [] xs
{% endhighlight %}

比如对一个 List 中的每个元素都加 5 的实现。

{% highlight haskell %}
ghci>map' (+5) [1, 2, 3]
[6,7,8]
{% endhighlight %}



> **foldl1**

{% highlight haskell %}
ghci>:t foldl1
foldl1 :: Foldable t => (a -> a -> a) -> t a -> a
{% endhighlight %}

与 **foldl** 也差不多，只是不需要提供一个初始值，它自动取 List 的 head 作为初始值，并从 List 的第二个元素开始折叠。

{% highlight haskell %}
-- 应该是 6
ghci>foldl1 (+) [1, 2, 3]
6

ghci>foldl1 (+) [2, 2, 3]
7
-- 应该是 13
ghci>foldl1 (+) [8, 2, 3]
13
{% endhighlight %}

> **foldr1**

与  **foldl1** 差不多，也不需要提供初始值，它取最后一个元素作为初始值，并从 List 的倒数二个元素开始折叠。

{% highlight haskell %}
ghci>foldr1 (+) [1, 2, 3, 4]
10
-- 它是怎么执行的？
-- 初始值是 4
-- 3 + 4 => 7
-- 2 + 7 => 9
-- 1 + 9 => 10

ghci>foldr1 (-) [1, 2, 3, 4]
-2
-- 😲😲😲😲😲 -2
-- 它又是咋搞的？
-- 初始值 4，然后从倒数第二开始折叠
-- 3 - 4 => -1
-- 2 - (-1) => 3
-- 1 - 3 => -2
-- 😸😸😸😸😸😸
{% endhighlight %}

这张图能让你看的更清楚
![](http://ogkg37m8j.bkt.clouddn.com/image/jpg/swiftrecursion/foldlr.jpg)



<h3>Swift 中的匿名函数</h3>

其实已经见过了！前面 *不全呼叫* 的例子中就有这样的 Swift 实现：

{% highlight swift %}
func addThree(_ a: Int) -> (Int) -> (Int) -> Int {
    return {(b: Int) -> (Int) -> Int in
        return {(c: Int) -> Int in
            return a + b + c
        }
    }
}
{% endhighlight %}

在 Swift 中的匿名函数就是这样，阔在 {} 内，先是参数声明，-> 之后是函数返回类型，in 之后是函数体。

{% highlight swift %}
{(b: Int) -> (Int) -> Int in
    // do something
}

// 这个样子是不是更舒服些
{ (parameters) -> returnType in
    statements
}
{% endhighlight %}

关于 Swift 中的匿名函数(闭包)相关的知识有很多，这里给出最基本也是最根本的形式，其他的枝枝叶叶还要你自己给它填上。
