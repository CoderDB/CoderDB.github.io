---
layout: post
date: 2017-02-01
title: Haskell -- Data.Char
feature-img: "img/mintgreen.jpg"
---

包含一组处理字符的函数。

> **isControl**

是否为 *控制字符* 。控制字符就是对应某种功能，起到一定的控制作用的字符，像 ASCII 第 127 位对应 Delete ，再比如上下左右键等。

{% highlight haskell %}
ghci>:t isControl
isControl :: Char -> Bool

ghci>isControl 'a'
False

ghci>isControl ' '
False

ghci>isControl '&'
False
{% endhighlight %}

> **isAlpha**

判断字符是否为字母。

{% highlight haskell %}
ghci>:t isAlpha
isAlpha :: Char -> Bool

ghci>isAlpha 'a'
True

ghci>isAlpha ' '
False

ghci>isAlpha '$'
False
{% endhighlight %}

> **isAlphaNum**

判断一个字符是否为数字或字母。

{% highlight haskell %}
ghci>isAlphaNum 'a'
True

ghci>isAlphaNum '1'
True

ghci>isAlphaNum ' '
False

ghci>isAlphaNum '&'
False

ghci>isAlphaNum ','
False
{% endhighlight %}

> **isAscii**

是否为前128为 ASCII 值。

{% highlight haskell %}
ghci>isAscii 'a'
True

ghci>isAscii '1'
True

ghci>isAscii ' '
True

ghci>isAscii '&'
True
{% endhighlight %}

![](http://ogkg37m8j.bkt.clouddn.com/image/jpg/haskell/data_char/ascii_1.jpg)

> **isAsciiLower**

是否为小写的 ASCII

{% highlight haskell %}
ghci>isAsciiLower 'A'
False

ghci>isAsciiLower ' '
False

ghci>isAsciiLower '1'
False

ghci>isAsciiLower '&'
False
{% endhighlight %}

> **isAsciiUpper**

是否为大写的 ASCII

{% highlight haskell %}
ghci>isAsciiUpper 'A'
True

ghci>isAsciiUpper 'a'
False

ghci>isAsciiUpper '1'
False

ghci>isAsciiUpper '&'
False

ghci>isAsciiUpper ' '
False
{% endhighlight %}

> **isDigit**

是否为数字。

{% highlight haskell %}
ghci>isDigit '4'
True

ghci>isDigit 'a'
False

ghci>isDigit ' '
False

ghci>isDigit '&'
False
{% endhighlight %}

> **isHexDigit**

是否为十六进制数。

{% highlight haskell %}
ghci>isHexDigit 'F'
True

ghci>isHexDigit 'a'
True

ghci>isHexDigit '0'
True

ghci>isHexDigit '+'
False

ghci>isHexDigit ' '
False
{% endhighlight %}
