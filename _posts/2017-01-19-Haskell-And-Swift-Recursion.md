---
layout: post
date: 2017-01-16
title: Haskell And Swift （递归）
feature-img: "img/darkgray.jpg"
---

![recursion](http://ogkg37m8j.bkt.clouddn.com/image/haskell-and-swift/recursion/recursion.jpg)


<h2>递归</h2>
---
函数调用自己就是 **递归** 。

之前[一篇文章](https://redtwowolf.github.io/2017/01/14/Haskell-And-Swift-Pattern-Match.html)中有一个实现 **length** 的函数，是这样的实现的：

{% highlight haskell %}
length' :: (Integral b) => [a] -> b
length' [] = 0
length' (_:t) = 1 + length' t
{% endhighlight %}

*length'* 函数先定义一个匹配空 *List* 的模式，再定义第二个模式用以调用自身。比如 *abc* 这样一个字符串计算 length 的过程是这样。

{% highlight haskell %}
1. length' "abc"

2. 匹配第二个模式(_:t)，即 (_:"bc")，此时长度可表示为 1 + length' "bc"，以 "bc" 调用 length' 本身

3. "bc" 依旧匹配第二个模式，即(_:"c")，此时长度可表示为 1 + (1 + length' "c")，以 "c" 调用 length' 本身

4. "c" 仍然匹配第二个模式，即(_:[])，此时长度可表示为 1 + (1 + (1 + length ""))，以 "" 调用 length' 本身_

5. "" 匹配了第一个模式 []，length' 函数定义了空 "List" 的长度为 0，此时长度可表示为 1 + (1 + (1 + 0))

6. 得出长度 3
{% endhighlight %}

之前为此专门画了一张图，这张图能帮助更清楚的认识 **递归** 。
![length'](http://ogkg37m8j.bkt.clouddn.com/image/haskell-and-swift/pattern-match/haskell_and_swift_pattern_match_length.jpg)

> Fibonacci

斐波那契数列就是这样的一列数：
{% highlight haskell %}
 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233，377，610，987，1597，......
{% endhighlight %}

又称做黄金分割数列，因为它的通项公式是这样的：

$$ a_n = 1 / \sqrt 5 \left[\left(\frac{1 + \sqrt 5 } 2\right)^n - \left(\frac{1 - \sqrt 5} 2\right)^n \right] a_1 = 1, a_2 = 1, a_n = a_{n-1} + a_{n-2} \ (n \geq 3, n \in N^*) $$
