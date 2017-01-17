---
layout: post
date: 2017-01-16
title: Haskell And Swift (where, let, case)
feature-img: "img/mintgreen.jpg"
---

where
---

**where** 关键词是用来为某一表达式添加一个或多个条件，且条件的形式多样，比如可以是比较性语句，也可以是函数等。

*BMI* （Body Mass Index）身体质量指数，亦称克托莱指数，是目前国际上常用的衡量人体胖瘦程度以及是否健康的一个标准。*BMI* 值超标，意味着你必须减肥了。它是这样计算的：

$$ BMI \ = \ weight\ (kg)\  \div \ height\ ^2\ (m) $$

*BMI* 的衡量指标是这样的：

分类 | BMI|
|-----|----|
偏瘦 | <= 18.4|
正常 | 18.5 ~ 23.9|
过重 | 24.0 ~ 27.9|
肥胖 | >= 28.0|

用 Haskell 来实现它。在 **test.hs** 文件中编写创建一个名为 *bmi* 的函数，它接受两个浮点型参数，返回一个 *String* 来描述你的身体质量。

{% highlight haskell %}
bmi :: (RealFloat a) => a -> a -> String
bmi weight height
    | weight / height ^ 2 <= 18.4 = "偏瘦"
    | weight / height ^ 2 <= 23.9 = "正常"
    | weight / height ^ 2 <= 27.9 = "过重"
    | otherwise = "肥胖"
{% endhighlight %}

小明身高 175cm，体重 60kg。看看他的身体质量。

{% highlight haskell %}
ghci>bmi 60 1.75
"正常"
{% endhighlight %}

*bmi* 函数利用 **guard** 实现，比起 **if-else** 已经相当简便了！不过还是多次输入了 *weight / height ^ 2* 并重复计算多次，现在我们重构它，让它更简单、更高效。

{% highlight haskell %}
bmi' :: (RealFloat a) => a -> a -> String
bmi' weight height
    | bmi <= 18.4 = "偏瘦"
    | bmi <= 23.9 = "正常"
    | bmi <= 27.9 = "过重"
    | otherwise = "肥胖"
    where bmi = weight / height ^ 2
{% endhighlight %}

**where** 给 *bmi'* 函数一个条件。这个例子里的条件则是一个函数。

{% highlight haskell %}
ghci>bmi
bmi   bmi'

ghci>bmi' 60 1.75
"正常"
{% endhighlight %}

> **Swift** 中的 **where**

之前举过一个18岁看电影的例子，我们对它稍做一些修改。

{% highlight swift %}
func watchMovieWithWhere(age: Int) -> String {

    switch age {
    case 1...10 where age >= 5:
        return "You should play niba with your friends."
    case 11...18:
        return "You should try to date girls."
    case 19...22:
        return "Watch Movie! Watch Movie! Watch Movie!"
    case 23...25:
        return "See Feng Insert Zhen."
    case 26...30:
        return "You should try to be a gay."
    case _ where age >= 31:
        return "You should try to be a gay."
    default:
        return "please re-enter."
    }
}
{% endhighlight %}

在小于10岁的孩子中用 **where** 附加了一个条件，只有5到10岁的孩子才能玩泥巴😂😂😂😂😂😂

{% highlight swift %}
let sixYears = watchMovieWithWhere(age: 6)
print(sixYears)
// You should play niba with your friends.

let twoYears = watchMovieWithWhere(age: 2)
print(twoYears)
// please re-enter.
{% endhighlight %}

**where** 和 **for-in** 一起使用。

{% highlight swift %}
for case let i in 1..<10 where i % 2 == 0{
    print(i)
}
// 2
// 4
// 6
// 8
{% endhighlight %}

总之一句话，**where** 就是添加一个条件。





let
---

case
---
