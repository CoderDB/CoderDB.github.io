---
layout: post
date: 2017-01-12
title: Haskell And Swift (Typeclass)
img: "green.jpg"
---

**Typeclass** 可以理解为 **Swift** 中的 **Protocol** 。

---

在 ghci 下，察看 == 函数的类型
{% highlight haskell %}
ghci>:t (==)
(==) :: Eq a => a -> a -> Bool
{% endhighlight %}
**=>** 是类型约束，表示类型变量 a 属于 Eq 类。这里的 **Eq** 就是 **类型类（Typeclass）** 。

<h3>为什么说可以理解为 Swift 中的 Protocol ，看看下面这个例子就明白了！</h3>
---

之前在写一篇[设计模式](http://localhost:4000/2016/11/25/Design-Pattern.html)相关的文章时，里面有一个关于"会飞的鸭子"的例子。有绿头鸭、红头鸭、橡皮鸭等等各种鸭子，但是有的鸭子会飞，有的不会飞。如果类的设计是所有鸭子继承一个鸭子基类，当有新的鸭子类（比如木头刻的鸭子，既不会飞也不会叫）产生时，子类就需要覆盖众多父类中的方法，为了解决这一问题，程序汪们想出了这样的方法：
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_07.jpg" alt="designpattern_duck_07"/>
**MallardDuck** 与 **RedHeadDuck** 既会叫又会飞，所以它们遵守 **Flyable** 和 **Quickable** 协议，而 **RubberDuck** 只会叫不会飞，所以它遵守 **Quickable** 协议。这里的 **Flyable** 和 **Quickable** 就相当于 **Eq** 。

> <h3>几个基本的 Typeclass</h3>

* Eq: 包含可判断相等性的类型 （==, /=）
{% highlight haskell %}
ghci>10 == 20
False

ghci>10 /= 20
True

ghci>10.0 == 10
True

ghci>"Heskell" == ['H', 'e', 's', 'k', 'e', 'l', 'l']
True

ghci>(5, 3) == (5, 3)
True
{% endhighlight %}

* Ord: 包含可比较大小的类型 (>, <, >=, <=, compare)
{% highlight haskell %}
ghci>'a' > 'b'
False

ghci>'a' <= 'b'
True

ghci>10 >= 5
True

-- 以中缀函数调用
ghci>'a' `compare` 'b'
LT

ghci>'b' `compare` 'a'
GT

ghci>'b' `compare` 'b'
EQ

--
ghci>compare 'a' 'b'
LT
{% endhighlight %}
如上所述，**compare** 函数只返回 **GT, LT, EQ** 三种类型。

* Num: 表示数字的 Typeclass ，实数
* Integral: 整数（Int、Integer）
* Floating: 小数（Float、Double）
几个相关函数：
{% highlight haskell %}
-- Enum -> Int
ghci>:t fromEnum
fromEnum :: Enum a => a -> Int

ghci>fromEnum 'a'
97

-- Integer -> Num
ghci>:t fromInteger
fromInteger :: Num a => Integer -> a

-- (Int或Integer) -> Num
ghci>:t fromIntegral
fromIntegral :: (Num b, Integral a) => a -> b

-- 🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰
ghci>let nums = [1..5]

-- 返回 Int 类型
ghci>:t length
length :: Foldable t => t a -> Int

-- 3 是 Num 类型的
ghci>:t 3
3 :: Num t => t

-- Int + Num
ghci>length nums + 3
8

-- 与浮点类型相加
ghci>length nums + 15.9

<interactive>:508:15: error:
    • No instance for (Fractional Int) arising from the literal ‘15.9’
    • In the second argument of ‘(+)’, namely ‘15.9’
      In the expression: length nums + 15.9
      In an equation for ‘it’: it = length nums + 15.9

-- 这个时候就可以这样做了！
ghci>fromIntegral (length nums) + 15.9
20.9
{% endhighlight %}

* Show: 包含可以用字符串表示的类型
{% highlight haskell %}
ghci>:t show
show :: Show a => a -> String

ghci>show 1
"1"

ghci>show "Haskell"
"\"Haskell\""

ghci>show True
"True"

ghci>show (5, 4)
"(5,4)"
{% endhighlight %}

* Read: 与 Show 相反
{% highlight haskell %}
ghci>:t read
read :: Read a => String -> a

ghci>read "1" :: Int
1

ghci>read "\"Haskell\"" :: [Char]
"Haskell"

ghci>read "['H', 'e', 's', 'k', 'e', 'l', 'l']" :: [Char]
"Heskell"

ghci>read "'a'" :: Char
'a'

ghci>read "True" :: Bool
True

ghci>read "True" ==  False
False

ghci>read "True" >=  False
True

ghci>read "True" <= False
False

ghci>read "True" :: Int
*** Exception: Prelude.read: no parse

-- 像这样的可以理解为类型推断，或者隐式类型转换
ghci>read "10" + 20
30
{% endhighlight %}
你需要告诉 **read** 你需要转为什么类型，它才会知道该怎么做，如果你告诉 **read** 将 “1” 转为 “[Char]” ，那它是办不到的。就像 **Swift** 中强制类型转换一样。
{% highlight haskell %}
ghci>read "1" :: [Char]
"*** Exception: Prelude.read: no parse

ghci>read "1" :: Char
*** Exception: Prelude.read: no parse
{% endhighlight %}

* Enum: 包含可枚举类型的Typeclass

可枚举的意思就是连续的，像 1， 2， 3... 这样，我知道前一个就能知道后一个。
{% highlight haskell %}
-- 后继子
ghci>:t succ
succ :: Enum a => a -> a

-- 前继子
ghci>:t pred
pred :: Enum a => a -> a

ghci>succ 'f'
'g'

ghci>pred 'f'
'e'

ghci>pred EQ
LT

ghci>succ EQ
GT

ghci>succ 10
11

ghci>pred 10
9
{% endhighlight %}

* Bounded: 包含的成员都有上限和下限
{% highlight haskell %}
ghci>maxBound :: Int
9223372036854775807

ghci>minBound :: Int
-9223372036854775808

ghci>maxBound :: Char
'\1114111'

ghci>maxBound :: Bool
True

ghci>maxBound :: Integer

<interactive>:337:1: error:
    • No instance for (Bounded Integer)
        arising from a use of ‘maxBound’
    • In the expression: maxBound :: Integer
      In an equation for ‘it’: it = maxBound :: Integer
-- 所以说 Integer 是无限的， Int是有限的
{% endhighlight %}

> <h3>Types and Typeclasses</h3>

<table>
<tr>
  <th >Types</th>
  <th colspan="2">Typeclasses</th>
</tr>
<tr>
  <th rowspan="7">Char、Bool、Int、Integer、Double、Float、List、Tuple</th>
</tr>
<tr>
  <th>Eq</th>
  <td>相等性比较</td>
</tr>
<tr>
  <th>Ord</th>
  <td>比较大小</td>
</tr>
<tr>
  <th>Num</th>
  <td>数字性</td>
</tr>
<tr>
  <th>Show</th>
  <td>任意类型转为字符串</td>
</tr>
<tr>
  <th>Enum</th>
  <td>可枚举</td>
</tr>
<tr>
  <th>Bounded</th>
  <td>干啥都要有个度的😁😁😁</td>
</tr>
</table>
