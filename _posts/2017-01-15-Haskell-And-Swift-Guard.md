---
layout: post
date: 2017-01-15
title: Haskell And Swift (Guard)
feature-img: "img/purple.jpg"
---

Guard
---
判断一个值是否为真，如果为真则执行其对应的函数体，否则跳至下一个 **guard** 。跟模式匹配、if、switch语句都很类似。

guard 有自己的形式
---
**guard** 用 **|** 来表示。

通过一个不满18岁看电影的例子来认识 **guard** 。在 **test.hs** 中声明一个名为 *watchMovie* 的函数，它需要一个整型的参数来作为年龄，返回一个这个年龄该干的事儿。🤡🤡🤡🤡🤡🤡🤡🤡
{% highlight haskell %}
watchMovie :: (Integral a) => a -> String
watchMovie age
    | age <= 10 = "You should play niba with your friends."
    | age <= 18 = "You should try to date girls."
    | age <= 22 = "Watch Movie! Watch Movie! Watch Movie!"
    | age <= 25 = "See Feng Insert Zhen."
    | age <= 30 = "You should try to be a gay."
    | otherwise = "You should try to be a gandie."
{% endhighlight %}

将 **test.hs** 加载到 ghci ，看看你适合干啥。🤠🤠🤠🤠🤠🤠

{% highlight haskell %}
ghci>watchMovie 5
"You should play niba with your friends."

ghci>watchMovie 18
"You should try to date girls."

ghci>watchMovie 20
"Watch Movie! Watch Movie! Watch Movie!"

ghci>watchMovie 24
"See Feng Insert Zhen."

ghci>watchMovie 28
"You should try to be a gay."

ghci>watchMovie 35
"You should try to be a gandie."
{% endhighlight %}

><h3>max'</h3>

用 **guard** 来实现 **max** 函数。
{% highlight haskell %}
max' :: (Ord a) => a -> a -> a
max' x y
    | x > y = x
    | otherwise = y
{% endhighlight %}

在 **test.hs** 中声明一个名为 *max'* 的函数，它需要两个可比较类型的参数，并返回一个同类型的值。

{% highlight haskell %}
ghci>max
max       max'      maxBound  maximum

ghci>max' 10 8
10

ghci>max 10 8
10
{% endhighlight %}

><h3>compare'</h3>

用 **guard** 来实现 **compare** 函数。
{% highlight haskell %}
compare' :: (Ord a) => a -> a -> Ordering
compare' x y
    | x > y     = GT
    | x == y    = EQ
    | otherwise = LT
{% endhighlight %}

再次加载 **test.hs** 之后，测试一下。

{% highlight haskell %}
ghci>compare
compare   compare'

-- compare'
ghci>compare' 10 8
GT
ghci>compare' 0 0
EQ
ghci>compare' 50 100
LT
ghci>10 `compare'` 8
GT

-- compare
ghci>compare 10 8
GT
ghci>compare 0 0
EQ
ghci>10 `compare` 8
GT
{% endhighlight %}
