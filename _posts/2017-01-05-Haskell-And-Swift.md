---
layout: post
date: 2017-01-05
title: Haskell And Swift
feature-img: "img/orange.jpg"
---

<h2>一、为什么是 Haskell ?</h2>
---
一句话，只因 **Haskell** 有趣。

第一次看到 **Haskell** 这个字眼是在看[《函数式Swift》](https://objccn.io/products/functional-swift/)这本书中(是一本不错的书)，里面曾多次提到 **Haskell** 并与 **Swift** 做以比较，所以就起了了解 **Haskell** 的心思，一本书才读了不多，发现 **Haskell** 非常有趣，尤其是对数学的支持，简直无情，堪称完美。想像一下像做数学题一样编程是什么样子？

$$ f(x) = \int \frac{2x^2+4x+6}{x-2} $$

于是就以这篇文章记录这个学习的过程，所以就 **Haskell** 为主，**Swift** 为辅做个对比。如果你发现错误或不妥[请点击](https://github.com/redtwowolf/redtwowolf.github.io/issues)或者[联系我](mailto:dongbinghouy@gmail.com)，非常感谢🙏

<h2>二、常量 </h2>
在 **Swift** 中声明一个 **常量** 像这样
{% highlight swift %}
let a = 5
let some: String = "something"
{% endhighlight %}
在 **Haskell** 中声明 **常量**
{% highlight haskell %}
Prelude> let a = 5
Prelude> let some = "something"
{% endhighlight %}
[GHC](https://www.haskell.org/ghc/download_ghc_7_0_3) 是 **Haskell** 解释器的一种，Prelude> 是 GHC 的默认提示符，可以通过下面代码更换成你想要的，比如
{% highlight haskell %}
Prelude> :set prompt "ghci>"
ghci>
{% endhighlight %}

<h2>二、变量 </h2>
---
在 **Swift** 中声明一个 **变量** 像这样
{% highlight swift %}
var a = 5
var someVar: String = "something"
{% endhighlight %}
在 **Haskell** 中声明变量，在编辑器里输入以下内容，并将其保存为 **test.hs**
{% highlight haskell %}
a = 5
a = 8
{% endhighlight %}
将 **test.hs** 载入，像这样
{% highlight haskell %}
ghci>:l test.hs
{% endhighlight %}
不幸的是，GNC 告诉我们无法载入，并告诉一些错误信息以提示我们
{% highlight shell %}
[1 of 1] Compiling Main             ( test.hs, interpreted )

test.hs:2:1: error:
    Multiple declarations of ‘a’
    Declared at: test.hs:1:1
                 test.hs:2:1
Failed, modules loaded: none.
{% endhighlight %}
**:l** 是 **:load** 简写，如果之前已经载入过这一文件，经过一些编辑之后，需要重新载入可以使用 **:r** ，它是 **:reload** 的简写。言归正传，显然像这样是没法声明变量的。在 **Haskell** 中，声明了一个变量 **a** 的值为5，那它就是5，不能再是其他值。这不就是常量吗？的确，但是不能说 **Haskell** 就没有变量。在 **Haskell** 中怎么找到变量的身影，在 ghci> 下，输入 **:t head**
{% highlight haskell %}
ghci>:t head
head :: [a] -> a
{% endhighlight %}
**:t** 是 **:type** 的简写，语意是“查看类型”。**::** 与 **Swift** 中的 **:** 一样，表示这是什么类型。所以 **head** 的类型是参数为 **a** 类型的数组，返回类型为 **a** 的值。在这里的 **a** 可以看作变量，确切说应该是类型占位，再凑近一点看其实应该和泛型很像。举个🌰
{% highlight haskell %}
ghci>head [1, 2, 3]
1
ghci>head ["hello", "my", "friend"]
"hello"
{% endhighlight %}
一目了然了吧！相信 **head** 能干啥也已经非常清楚了！

<h2>三、List </h2>
---
这次我们从 **Haskell** 先开始。**List** 是啥呢？让我们举些🌰🌰🌰相信你很快就会明白它是什么了！
{% highlight haskell %}
// 1
ghci>let numbers = [1, 5, 8, 20]
ghci>numbers
[1,5,8,20]

// 2
ghci>let letters = ['a', 'b', 'c']
ghci>letters
"abc"

// 3
ghci>let strs = ["a", "b", "c"]
ghci>strs
["a","b","c"]
{% endhighlight %}
如你所见，一个 **List** 由方括号括起，其中的元素用逗号分开。有没有发现上述🌰中的 **letters** 有点奇怪，为什么 **letters** 输出是一个字符串？让我们来看看 **letters** 是什么类型，或许就明白了!
{% highlight haskell %}
ghci>:t letters
letters :: [Char]

// 不妨顺道试试它们
ghci>:t "abc"
"abc" :: [Char]

ghci>:t 'a'
'a' :: Char
{% endhighlight %}
哦！原来如此，**letters** 与 **“abs”** 是同一类型，都是 **[Char]** 类型，也就是说字符串就是 **[Char]** 类型的 **List** 。那么 **strs** 是👇这样的就不难理解了！
{% highlight haskell %}
ghci>:t strs
strs :: [[Char]]

// 因为"a" = [a], 所以 ["a", "b", "c"] = [[a], [b], [c]]
{% endhighlight %}
熟悉了 **List** 是什么之后，👇来练习一下 **List** 的一些常用操作

> <h3> 1. ++ </h3>

{% highlight haskell %}
ghci>"hello" ++ " " ++ "world" ++ " " ++ "!"
"hello world !"

ghci>[1, 2, 3, 4] ++ [10, 9, 8, 7, 5]
[1,2,3,4,10,9,8,7,5]

ghci>['h', 'a', 's'] ++ ['k', 'e', 'l', 'l']
"haskell"

ghci>letters ++ "d"
"abcd"

// 当然了，你不能将它们 ++ 起来
ghci>letters ++ strs

<interactive>:236:12: error:
    • Couldn't match type ‘[Char]’ with ‘Char’
      Expected type: [Char]
        Actual type: [[Char]]
    • In the second argument of ‘(++)’, namely ‘strs’
      In the expression: letters ++ strs
      In an equation for ‘it’: it = letters ++ strs
ghci>
{% endhighlight %}
所以了，**++ 运算子就是将两个 List 连起来**。**Swift** 中并没有 **++** 这样的运算子运用在 **Array** 结构上，但是可以有其他方法来对应 **Haskell** 中的 **++** 操作，来看一下吧！
在 **Swift** 中 **let letters = ['a', 'b', 'c']** 是不被允许的，为了和 **Haskell** 的🌰更像一点，我们这样声明
{% highlight swift %}
var letters = ["a", "b", "c"]
print(letters)
// ["a", "b", "c"]

var strs = [["a"], ["b"], ["c"]]
print(strs)
// [["a"], ["b"], ["c"]]
{% endhighlight %}
👇是 **Swift** 怎么实现像 **++** 一样的操作：
{% highlight swift %}
let helloWorld = "hello" + " " + "world" + " " + "!"
print(helloWorld)
// hello world !

let numbers = [1, 2, 3, 4] + [10, 9, 8, 7, 5]
print(numbers)
// [1, 2, 3, 4, 10, 9, 8, 7, 5]

let haskell = ["h", "a", "s"] + ["k", "e", "l", "l"]
print(haskell)
// ["h", "a", "s", "k", "e", "l", "l"]

并不能像 Haskell 中一样，因为 Haskell 中字符串和 [Char] 类型的 List 是一样的，“haskell” 只是 ['h', 'a', 's', 'k', 'e', 'l', 'l'] 的语法糖。
而 Swift 中，字符串和数组是两个概念，所以你也不能将一个数组和字符串 + 起来（letters ++ "d"），但是你可以这样👇

letters.append("d")
print(letters)
// ["a", "b", "c", "d"]

let abcd = "abc".appending("d")
print(abcd)
// abcd
{% endhighlight %}
当然 **Swift** 中也有一些操作是 **Haskell** 达不到的，比如👇
{% highlight swift %}
let anyArray: [Any] = [1, "2", 20, "haha"]
print(anyArray)
// [1, "2", 20, "haha"]

Haskell 的 List 中只能存放同一类型的元素。
{% endhighlight %}
**Swift** 的数组元素可以是不同类型的，而这在 **Haskell** 中不被允许的，如果你试图将不同类型的元素包含在一个 **List** 中，像这样
{% highlight haskell %}
ghci>[1, '2', 20, 'h']

<interactive>:290:2: error:
    • No instance for (Num Char) arising from the literal ‘1’
    • In the expression: 1
      In the expression: [1, '2', 20, 'h']
      In an equation for ‘it’: it = [1, '2', 20, ....]
ghci>
{% endhighlight %}
**ghci** 就会告诉我们这样一个错误。

> <h3> 2. : </h3>

**: 表示在 List 的头部插入元素**。🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰
{% highlight haskell %}
ghci>'h':"askell"
"haskell"

ghci>'d':letters
"dabc"

ghci>'5':['1', '2', '3']
"5123"

ghci>5:[1, 2, 3]
[5,1,2,3]

ghci>1:2:[3, 4]
[1,2,3,4]
// 将 2 插入到 [3, 4] 的头部形成 [2, 3, 4] ，再将 1 插入 [2, 3, 4] 的头部形成 [1, 2, 3, 4]

ghci>100:[]
[100]
// 将 100 插入到一个空的 List
{% endhighlight %}
很简单吧！实际上 **[1, 2, 3]** 就是 **1:2:3:[]** 的语法糖。那么 **Swift** 中怎么实现呢？
{% highlight swift %}
var anotherHaskell = "askell"
anotherHaskell.insert("h", at: anotherHaskell.startIndex)
print(anotherHaskell)
// haskell

anotherHaskell.insert(contentsOf: ["h", "i", " "], at: anotherHaskell.startIndex)
print(anotherHaskell)
// hi haskell

var anotherNumbers = [1, 2, 3]
anotherNumbers.insert(5, at: anotherNumbers.startIndex)
print(anotherNumbers)
// [5, 1, 2, 3]

anotherNumbers.insert(contentsOf: [5, 10], at: anotherNumbers.startIndex)
print(anotherNumbers)
// [5, 10, 5, 1, 2, 3]
{% endhighlight %}
当然你也可以重载运算符，或者自定义运算符学的更像一点👇
{% highlight swift %}
infix operator ♣︎
extension Int {
    static func ♣︎(left: Int, right: [Int]) -> [Int]  {
        return [left] + right
    }
}
let testNums = 5 ♣︎ [1, 2, 3]
print(testNums)
// [5, 1, 2, 3]
// 当然你可以把 ♣︎ 做的更灵活，就跟 ghci>:t head 中的 a 差不多，你肯定知道我在说什么的🤡
{% endhighlight %}

> <h3> 3. !! </h3>
