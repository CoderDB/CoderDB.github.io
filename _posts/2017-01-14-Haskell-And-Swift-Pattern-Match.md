---
layout: post
date: 2017-01-14
title: Haskell And Swift (Pattern matching)
img: "haskell_swift_pattern_match.png"
---

<h2>模式匹配</h2>

就是定义好一些规则，如果满足（匹配）了其中某一条规则，那么就执行这个规则下的内容，如果不满足（也就是不匹配）这条规则，则跳至下一规则，依此类推，直到找到满足的规则，然后执行其内容，如果执行到最后一条规则还没有满足（匹配），那模式匹配就会失败。

举个例子🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰
{% highlight swift %}
啥时候才能不上班呐？

Monday: "今天才周一，你急个毛啊 🙄🙄🙄"// rule 1
Wednesday: "距离不上班还有三天呐 😱😱😱" // rule 2
Friday: "明天就不用上班啦 😂😂😂" // rule 3
... : "有不上班的那天吗？？？😒😒😒"// other runles
{% endhighlight %}
如果用 Haskell 来实现上面这个真实的笑话的话，大概是这样：
{% highlight haskell %}
notAtWork :: String -> String
notAtWork "Monday" = "Today is Monday, you ji ge mao a."
notAtWork "Wednesday" = "You don't have to go to work after three days."
notAtWork "Friday" = "You don't need to work tomorrow."
notAtWork x = "You do have to work everyday, you konw, shabi!"
{% endhighlight %}
首先在 **test.hs** 中声明一个名为 *notAtWork* 参数和返回值都是 String 的函数，这个函数匹配了 *Monday, Wednesday, Friday* 和一个通配的 *x* 。这个模式匹配不可能会失败因为 *x* 匹配了所有的情况。在 ghci 下用 **:l** 将 **test.hs** 加载进来。
{% highlight haskell %}
ghci>:l test.hs
[1 of 1] Compiling Main             ( test.hs, interpreted )
Ok, modules loaded: Main.
-- 加载成功

-- 用 "Monday" 测试
ghci>notAtWork "Monday"
"Today is Monday, you ji ge mao a."

ghci>notAtWork "Wednesday"
"You don't have to go to work after three days."

ghci>notAtWork "Friday"
"You don't need to work tomorrow."

-- 其他字符串被 x 匹配
ghci>notAtWork "haha"
"You do have to work everyday, you konw, shabi!"
{% endhighlight %}
以上这个故事中的 *x* 匹配了生活中的每一天，如果把它挪到最前，那么结果都会是 *"You do have to work everyday, you konw, shabi!"* ，因为它匹配了所有的字符串，后面的模式根本就没机会上台表演，所以 **模式匹配** 的顺序很重要。


<h2>再靠近一点看模式匹配</h2>
通过一些🌰🌰🌰🌰🌰🌰🌰🌰，能更清楚的看到模式匹配是怎么使用的。

><h3>1. fst, snd 可以获取 Tuple 中的元素，那么三元组呢？</h3>

在 **test.hs** 中创建以下三个函数，分别用于获取三元组的各项元素。

{% highlight haskell %}
first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z
{% endhighlight %}
这里的 **_** 表示我并不需要这个值，所以我也不需要用一个变量去存储它。这在 Swift 里也很常见。
{% highlight haskell %}
ghci>let test = ("Tom", "male", 25)
ghci>first test
"Tom"

ghci>second test
"male"

ghci>third test
25
{% endhighlight %}

><h3>2. 实现 head 函数</h3>

**head** 是返回一个 List 的头，还记得那个怪兽吗？在 **test.hs** 中添加一个名为 *head'* 的方法。

{% highlight haskell %}
head' :: [a] -> a
head' [] = error "Can't call head on empty list."
head' (x:_) = x

-- error 是一个函数，会直接导致程序crash，并以参数的形式对crash加以描述
-- x:_ 将一个 List 分为头和尾两部分，但是我们并不关心尾部，所以用 _ 替之。
{% endhighlight %}

使用 **:r** 命令将 **test.hs** 再次加载到 ghci ，来测试一下吧！

{% highlight haskell %}
-- head'
ghci>head' []
*** Exception: Can't call head' on empty list.

ghci>head' "Haskell"
'H'

-- head
ghci>head []
*** Exception: Prelude.head: empty list

ghci>head "Haskell"
'H'
-- 是不是和 head 函数一模一样了！
{% endhighlight %}

><h3>3. 实现 length 函数</h3>

length 函数是返回一个 List 的长度。在 **test.hs** 中声明一个名为 *length'* 的函数，像这样：
{% highlight haskell %}
length' :: (Integral b) => [a] -> b
length' [] = 0
length' (_:t) = 1 + length' t

-- length' 函数的参数为 List 返回值为 Integral 类型
-- _:t 将 List 分为头和尾两部分。 t 取自 tail ，你可以取你认为更清楚的命名。
{% endhighlight %}

有必要详细说明一下 *length'* 这个函数，因为这个函数使用到了递归。首先 *length'* 有两个规则（模式），第一个规则匹配空 List ，一个为空的 List 长度自然为 1。第二个规则将 List 分为头和尾两部分，一个 List 的长度就是头部的长度加上尾部的长度。我们不关心头部是什么所以用 _ 代替，它的长度为 1 ，尾部 t 的长度则是 *length' t* ，而 *length' t* 又开始模式匹配，将这个 t 又分为 (_:t) 头尾两部分，头部的长度当然还是 1，尾部的长度是 *length' t* ，不过这里的 t 已经是新的 t 了。就这样一直递归，直到触碰到边界条件则递归结束，而这里的边界条件正好是空 List 。画个图就一目了然了！ ![length'](http://ogkg37m8j.bkt.clouddn.com/image/haskell-and-swift/pattern-match/haskell_and_swift_pattern_match_length.jpg)

将 **test.hs** 文件 reload 进来测试一下。

{% highlight haskell %}
ghci>length
length   length'

-- length'
ghci>length' ""
0
ghci>length' "Haskell"
7

-- length
ghci>length ""
0
ghci>length "Haskell"
7
{% endhighlight %}
所以 *"Haskell"* 的长度就是怎么算的呢？

{% highlight haskell %}
-- "Haskell"
length' "Haskell" = 1 + length' "askell"
length' "askell" = 1 + length' "skell"
length' "skell" = 1 + length' "kell"
...
...
length' "l" = 1 + length' "" -- "" = []
length' [] = 0
{% endhighlight %}

><h3>3. 实现 sum 函数</h3>

{% highlight haskell %}
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (h:t) = h + sum' t -- h 取自 "head"
{% endhighlight %}
*sum'* 函数声明为参数和返回值都为数字类型（Num）。空数组元素的和为 0 。
{% highlight haskell %}
ghci>sum
sum   sum'

-- sum'
ghci>sum' []
0
ghci>sum' [1, 2, 3]
6

-- sum
ghci>sum []
0
ghci>sum [1, 2, 3]
6
{% endhighlight %}

><h3>4. 实现 product 函数</h3>

{% highlight haskell %}
product' :: (Num a) => [a] -> a
product' [] = 1
product' (h:t) = h * product' t
{% endhighlight %}
将 [] 的积定位 1 ，和系统函数一致。
{% highlight haskell %}
ghci>product
product   product'

-- product'
ghci>product' []
1
ghci>product' [1, 2, 4]
8

-- product
ghci>product []
1
ghci>product [1, 2, 4]
8
{% endhighlight %}

关于 Swift 中的模式匹配在之前的[一片文章](https://redtwowolf.github.io/2016/12/29/Optionals.html)中提到了很多，可以瞧一眼如果你想。
