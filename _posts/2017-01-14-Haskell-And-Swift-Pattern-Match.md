---
layout: post
date: 2017-01-14
title: Haskell And Swift (Pattern matching)
feature-img: "img/blue.jpg"
---

<h2>模式匹配</h2>
---

就是定义好一些规则，如果满足（匹配）了其中某一条规则，那么就执行这个规则下的内容。看起来像这样：
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
首先在 **test.hs** 中声明一个名为 **notAtWork** 参数和返回值都是 String 的函数，这个函数匹配了 *Monday, Wednesday, Friday* 和一个通配的 *x* 。在 ghci 下用 **:l** 将 **test.hs** 加载进来。
{% highlight haskell %}
ghci>:l test.hs
[1 of 1] Compiling Main             ( test.hs, interpreted )
Ok, modules loaded: Main.
-- 加载成功

-- 用 "Monday" 测试
ghci>notAtWork "Monday"
"Today is Monday, you ji ge mao a."

ghci>notAtWork "Wendesday"
"You do have to work everyday, you konw, shabi!"

ghci>notAtWork "Friday"
"You don't need to work tomorrow."

-- 其他字符串被 x 匹配
ghci>notAtWork "haha"
"You do have to work everyday, you konw, shabi!"
{% endhighlight %}
