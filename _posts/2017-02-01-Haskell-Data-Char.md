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

> **isOctDigit**

是否为八进制数。

{% highlight haskell %}
ghci>isOctDigit '1'
True

ghci>isOctDigit '8'
False

ghci>isOctDigit '7'
True

ghci>isOctDigit 'A'
False

ghci>isOctDigit 'a'
False
{% endhighlight %}

> **isLetter**

是否为字母。

{% highlight haskell %}
ghci>isLetter 'a'
True

ghci>isLetter 'A'
True

ghci>isLetter '&'
False

ghci>isLetter '1'
False

ghci>isLetter ' '
False
{% endhighlight %}

> **isNumber**

是否为数字。

{% highlight haskell %}
ghci>isNumber '0'
True

ghci>isNumber '9'
True

ghci>isNumber 'a'
False

ghci>isNumber ' '
False

ghci>isNumber '&'
False
{% endhighlight %}

> **isSymbol**

是否为货币符号。

{% highlight haskell %}
ghci>isSymbol '$'
True

ghci>isSymbol '¥'
True

ghci>isSymbol '&'
False
{% endhighlight %}

> **isPunctuation**

是否为标点符号。

{% highlight haskell %}
ghci>isPunctuation ','
True

ghci>isPunctuation '.'
True

ghci>isPunctuation '。'
True

ghci>isPunctuation '1'
False
{% endhighlight %}

> **isLower**

是否为小写字母。

{% highlight haskell %}
ghci>isLower 'a'
True

ghci>isLower 'A'
False

ghci>isLower '1'
False
{% endhighlight %}

> **isUpper**

{% highlight haskell %}
ghci>isUpper 'A'
True

ghci>isUpper 'a'
False

ghci>isUpper '1'
False
{% endhighlight %}

> **isSpace**

是否为空格。

{% highlight haskell %}
ghci>isSpace ' '
True
{% endhighlight %}

> **isPrint**

判断字符是否可打印。

{% highlight haskell %}
ghci>isSpace 'A'
False
ghci>isPrint '1'
True
ghci>isPrint '^'
True
{% endhighlight %}

> **generalCategory**

返回一个字符可能的分类。

{% highlight haskell %}
ghci>:t generalCategory
generalCategory :: Char -> GeneralCategory

ghci>generalCategory ' '
Space

ghci>generalCategory 'A'
UppercaseLetter

ghci>generalCategory 'a'
LowercaseLetter

ghci>generalCategory '&'
OtherPunctuation

ghci>generalCategory '+'
MathSymbol

ghci>generalCategory '/'
OtherPunctuation

ghci>generalCategory '?'
OtherPunctuation
{% endhighlight %}

> **toUpper**

将一个字符转为大写。

{% highlight haskell %}
ghci>:t toUpper
toUpper :: Char -> Char

ghci>toUpper 'a'
'A'

ghci>toUpper 'A'
'A'

ghci>toUpper '1'
'1'
{% endhighlight %}

> **toLower**

讲一个字符转为小写。

{% highlight haskell %}
ghci>toLower 'a'
'a'
ghci>
ghci>toLower 'A'
'a'
ghci>
ghci>toLower '1'
'1'
ghci>toLower '&'
'&'
{% endhighlight %}

> **digitToInt**

将 0~9, 'a'~'f', 'A'~'F' 范围的字符转为 Int 值。

{% highlight haskell %}
ghci>:t digitToInt
digitToInt :: Char -> Int

ghci>digitToInt 'a'
10

ghci>digitToInt 'A'
10

ghci>digitToInt 'f'
15

ghci>digitToInt 'F'
15

ghci>digitToInt 'G'
*** Exception: Char.digitToInt: not a digit 'G'

ghci>digitToInt 'g'
*** Exception: Char.digitToInt: not a digit 'g'

ghci>digitToInt '0'
0

ghci>digitToInt '1'
1

ghci>digitToInt '9'
9
{% endhighlight %}

> **intToDigit**

与 **digitToInt** 相反。

{% highlight haskell %}
ghci>intToDigit 0
'0'

ghci>intToDigit 1
'1'

ghci>intToDigit 10
'a'

ghci>intToDigit 15
'f'
{% endhighlight %}

> **ord**

将字符按照 ASCII 表转换为对应的数字。

{% highlight haskell %}
ghci>ord 'a'
97

ghci>ord 'A'
65

ghci>ord '&'
38

ghci>ord '0'
48
{% endhighlight %}

> **chr**

与 **ord** 函数功能相反。

{% highlight haskell %}
ghci>chr 48
'0'

ghci>chr 97
'a'

ghci>chr 65
'A'

ghci>chr 38
'&'

ghci>chr 127
'\DEL'

ghci>chr 0
'\NUL'

ghci>chr 1000
'\1000'
{% endhighlight %}

实现一个简单的加密解密函数
---
---

在 **testModule.hs** 文件中声明一个 *encode* 与 *dedecode* 函数，像这样：

{% highlight Haskell %}
-- encode
encode :: Int -> String -> String
encode shift msg =
    let ords = map ord msg
        shifted = map (+shift) ords
    in map chr shifted
-- 给 map 传入 ord 函数，把 msg 转成对应的数字的 List
-- 把转化后的 List 通过 map 对所有元素做 （+shift）操作
-- 把最后做了（+shift）操作的数字 List 转成对应字符 List


-- decode    
decode :: Int -> String -> String
decode shift msg = encode (negate shift) msg
{% endhighlight %}

将 **testModule.hs** 加载到 ghci 测试一下：

{% highlight Haskell %}
ghci>:l testModule.hs
[1 of 1] Compiling Main             ( testModule.hs, interpreted )
Ok, modules loaded: Main.

ghci>:t encode
encode :: Int -> String -> String

ghci>encode 5 "a"
"f"

ghci>decode 5 "f"
"a"

ghci>ord 'a'
97
ghci>chr (97+5)
'f'

ghci>encode 5 "abcdef"
"fghijk"

ghci>decode 5 "fghijk"
"abcdef"
{% endhighlight %}
