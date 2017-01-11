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
-- 1
ghci>let numbers = [1, 5, 8, 20]
ghci>numbers
[1,5,8,20]

-- 2
ghci>let letters = ['a', 'b', 'c']
ghci>letters
"abc"

-- 3
ghci>let strs = ["a", "b", "c"]
ghci>strs
["a","b","c"]
{% endhighlight %}
如你所见，一个 **List** 由方括号括起，其中的元素用逗号分开。有没有发现上述🌰中的 **letters** 有点奇怪，为什么 **letters** 输出是一个字符串？让我们来看看 **letters** 是什么类型，或许就明白了!
{% highlight haskell %}
ghci>:t letters
letters :: [Char]

-- 不妨顺道试试它们
ghci>:t "abc"
"abc" :: [Char]

ghci>:t 'a'
'a' :: Char
{% endhighlight %}
哦！原来如此，**letters** 与 **“abs”** 是同一类型，都是 **[Char]** 类型，也就是说字符串就是 **[Char]** 类型的 **List** 。那么 **strs** 是👇这样的就不难理解了！
{% highlight haskell %}
ghci>:t strs
strs :: [[Char]]

-- 因为"a" = [a], 所以 ["a", "b", "c"] = [[a], [b], [c]]
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

-- 当然了，你不能将它们 ++ 起来
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
-- 将 2 插入到 [3, 4] 的头部形成 [2, 3, 4] ，再将 1 插入 [2, 3, 4] 的头部形成 [1, 2, 3, 4]

ghci>100:[]
[100]
-- 将 100 插入到一个空的 List
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

**!! 就是按照索引取出 List 中的元素**。
{% highlight haskell %}
ghci>letters !! 2 -- 🔊 哎...对面的👨🏿‍💻👩‍💻👨🏻‍💻👩🏾‍💻之前声明的 numbers 是 [1, 5, 8, 20] ，letters 是 ['a', 'b', 'c']
'c'

ghci>numbers !! 3
20

ghci>numbers !! 100
*** Exception: Prelude.!!: index too large
-- 超出了 List 的范围就会报错

ghci>"Haskell" !! 5
'l'
{% endhighlight %}
同样 **Swift** 中是这样的👇
{% highlight swift %}
// 获取一个字符串索引处的元素
let haskellStr = "Haskell"
let firstIdx = haskellStr.startIndex
print(haskellStr[firstIdx])
// H

let fifthIdx = haskellStr.index(firstIdx, offsetBy: 5)
print(haskellStr[fifthIdx])
// l
// 获取数组索引处的元素就不说了！
{% endhighlight %}

> <h3> 4. [[]] </h3>

**List** 嵌套。
{% highlight haskell %}
ghci>let nestedNums = [[1, 2], [4, 5, 6], [10, 20, 30]]
ghci>nestedNums
[[1,2],[4,5,6],[10,20,30]]

ghci>nestedNums ++ [[100, 200, 300]]
[[1,2],[4,5,6],[10,20,30],[100,200,300]]

ghci>[10] : nestedNums
[[10],[1,2],[4,5,6],[10,20,30]]

ghci>[45, 56] : nestedNums
[[45,56],[1,2],[4,5,6],[10,20,30]]

ghci>nestedNums !! 2
[10,20,30]
{% endhighlight %}

> <h3> 5. List怪兽 </h3>

几个常用函数 | 描述
-------------|-------------
head | 返回一个 List 的头部
tail | 返回除了 head 剩下的部分
last | 返回 List 最后一个元素
init | 返回 除去 last 剩下的部分

所以说 **List** 是不是这样一只怪兽啊！

![](http://ogkg37m8j.bkt.clouddn.com/image/haskellandswift/list_monster.png)

这里还有几个 | 描述
-------------|-------------
length | 返回 List 的长度
null | List 为空则返回 True
reverse | 反转 List 👉 👈
maximum | 返回 List 中最大的那个元素
minimum | 返回 List 中最小的那个元素
sum | 返回 List 中所有元素的和
product | 返回 List 中所有元素的积
take n | 返回 List 中前 n 个元素
drop n | 删除 List 中前 n 个元素，返回剩下的部分
elem x | 判断 x 元素是否在 List 内，是返回 True

下面就让我们来试一试吧！
{% highlight haskell %}
🔊🔊🔊 letters 是 ['a', 'b', 'c'] ，numbers 是 [1, 5, 8, 20]

ghci>head letters
'a'

ghci>tail letters
"bc"

ghci>last letters
'c'

ghci>init letters
"ab"

ghci>length letters
3

ghci>null letters
False

ghci>reverse letters
"cba"

ghci>maximum letters
'c'

ghci>minimum letters
'a'

ghci>sum letters

<interactive>:597:1: error:
    • No instance for (Num Char) arising from a use of ‘sum’
    • In the expression: sum letters
      In an equation for ‘it’: it = sum letters

-- 对一个不可求和的 List 做 sum 就会报这样的错误

ghci>sum numbers
34

ghci>product numbers
800

ghci>take 2 letters
"ab"

ghci>take 10 letters
"abc"
-- 当你 take 的元素个数超过了 List 的 length 只能得到原 List

ghci>take 0 letters
""
-- 当你 take 0 个元素就会得到一个空的 List

ghci>drop 1 letters
"bc"

ghci>drop 20 letters
""
-- 当你 drop 的元素个数超过了 List 的 length 就会得到一个空的 List

ghci>elem 'a' letters
True
ghci>'a' `elem` letters
True
-- 这两者是等价的，后者是以中缀函数的方式调用
{% endhighlight %}
哇！终于试完了！NO NO NO！还有 **Swift** 🙀 😒😒😒
<!-- 这里开始Swift -->
{% highlight swift %}
let haskell = "Haskell"
print(haskell)
// Haskell

//head
let head = haskell[haskell.startIndex]
print(head)
// H

//tail
let secondIdx = haskell.index(after: haskell.startIndex)
let range = Range(uncheckedBounds: (lower: secondIdx, upper: haskell.endIndex))
let tail = haskell.substring(with: range)
print(tail)
//当然你还可以使用其他方法

//last
let last = haskell.characters.last
print(last)
//Optional("l")

//init
let `init` = haskell.substring(with: range)
print(`init`)
// askell

//length
let length = haskell.characters.count
//let length = haskell.lengthOfBytes(using: String.Encoding.utf8)
print(length)
// 7

//null
let null = haskell.isEmpty
print(null)
// false

//reverse
let reverseCharacterView = haskell.characters.reversed()
let reverse = String(reverseCharacterView)
print(reverse)
// lleksaH

//maximum
let maximum = haskell.characters.max()
print(maximum)
// Optional("s")

//mimimum
let minimum = haskell.characters.min()
print(minimum)
// Optional("H")

//take n
let take5 = haskell.substring(to: haskell.index(haskell.startIndex, offsetBy: 5))
// let anotherTake5 = haskell.characters.dropLast(haskell.characters.count - 5)
// String(anotherTake5) // Haske
print(take5)
// Haske

// drop n
let drop3CharacterView = haskell.characters.dropFirst(3)
let drop3 = String(drop3CharacterView)
print(drop3)
// kell

//elem x
let elem = haskell.contains("a")
print(elem)
// true
{% endhighlight %}
接下来以 **Swift** 中的 **Array** 来实现 **sum、product**。
{% highlight swift %}
let numbers = [1, 5, 8, 20]
//sum
let sum = numbers.reduce(0, +)
print(sum)
// 34

//product
let product = numbers.reduce(1, *)
print(product)
// 800
{% endhighlight %} 终于完了😓😓😓😓😓😓😓😓😓😓😓😓你有病啊一个一个敲，谁不会似的😒😒😒😒😒😒😒😒😒😒😒**********************

<h2>四、Range </h2>
---

**Range** 就是一个区间。
{% highlight haskell %}
ghci>[1..10]
[1,2,3,4,5,6,7,8,9,10]

ghci>[1, 2..10]
[1,2,3,4,5,6,7,8,9,10]

ghci>['a'..'z']
"abcdefghijklmnopqrstuvwxyz"

ghci>['a', 'c'..'z']
"acegikmoqsuwy"
{% endhighlight %}
这就是 **Range** 了！它还可以指定步长，比如🌰🌰🌰🌰🌰🌰
{% highlight haskell %}
ghci>[1, 3..10]
[1,3,5,7,9]

ghci>[2, 4..10]
[2,4,6,8,10]
{% endhighlight %}
但是你不能像这样 **[10..1]** 取得 **[10,9,8,7,6,5,4,3,2,1]**
{% highlight haskell %}
ghci>[10..1]
[]
-- 看到了吧！给你一个空 List，但是你可以用步长
ghci>[10, 9..1]
[10,9,8,7,6,5,4,3,2,1]
{% endhighlight %}
你还可以这样，取10个最小的6的倍数🤔🤔🤔6，12，18···  
{% highlight haskell %}
ghci>let example = [6, 12..10*6]
ghci>example
[6,12,18,24,30,36,42,48,54,60]
ghci>length example
10
{% endhighlight %}

取前10个3的幂，怎么解？🤔🤔🤔 3，9，27···
{% highlight haskell %}
ghci>let example2 = [3, 9..10 * 3 * 3]
ghci>example2
[3,9,15,21,27,33,39,45,51,57,63,69,75,81,87]
ghci>length example2
15
{% endhighlight %}
Oops!不是取10个吗？怎么有15个？而且也不是幂啊！这是因为仅凭前几项 List 的后项是不能确定的。就像数列的前3项为1, 2, 4 那么第四项是什么？


利用 **Range** 构造 **List** 的一些函数 | 描述
------|------
cycle list | 生成无限重复 list 的 list
repeat n | 生成无限个 n 的 list
replicate n x | 生成 n 个 x 的 list

* cycle list
{% highlight haskell %}
ghci> cycle [1, 2, 3]
-- 😄😄😄有没有眼花😹😹😹😹😹

ghci>take 10 (cycle [1, 2, 3])
[1,2,3,1,2,3,1,2,3,1]
{% endhighlight %}

* repeat n
{% highlight haskell %}
ghci>take 8 (repeat 7)
[7,7,7,7,7,7,7,7]

ghci>take 5 (repeat [1, 2, 3])
[[1,2,3],[1,2,3],[1,2,3],[1,2,3],[1,2,3]]

ghci>take 5 (repeat [[1], [3]])
[[[1],[3]],[[1],[3]],[[1],[3]],[[1],[3]],[[1],[3]]]
{% endhighlight %}

* replicate n x
{% highlight haskell %}
ghci>replicate 8 7
[7,7,7,7,7,7,7,7]

ghci>replicate 5 [1, 2, 3]
[[1,2,3],[1,2,3],[1,2,3],[1,2,3],[1,2,3]]

ghci>replicate 5 [[1], [3]]
[[[1],[3]],[[1],[3]],[[1],[3]],[[1],[3]],[[1],[3]]]
{% endhighlight %}
当然了，我们是要和 **Swift** 做比较的嘛！🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰
{% highlight swift %}
let example = String(repeating: "5", count: 10)
print(example)
// 5555555555

let example2 = String(repeating: "5, 6, 7 ", count: 3)
print(example2)
// 5, 6, 7 5, 6, 7 5, 6, 7

let example3 = String(repeating: "[1, 2, 3], ", count: 5)
print(example3)
// [1, 2, 3], [1, 2, 3], [1, 2, 3], [1, 2, 3], [1, 2, 3],
{% endhighlight %}

循环初始化数组🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰
{% highlight swift %}
let exam = Array(repeatElement(5, count: 8))
print(exam)
// [5, 5, 5, 5, 5, 5, 5, 5]

let exam2 = Array(repeatElement("abc", count: 3))
print(exam2)
// ["abc", "abc", "abc"]

let exam3 = Array(repeating: [10], count: 5)
print(exam3)
// [[10], [10], [10], [10], [10]]

let exam4 = Array(repeating: [exam, exam2, exam3], count: 1)
print(exam4)
// [[[5, 5, 5, 5, 5, 5, 5, 5], ["abc", "abc", "abc"], [[10], [10], [10], [10], [10]]]]

let exam5 = [Int](repeatElement(5, count: 3))
print(exam5)
// [5, 5, 5]

let exam6 = Array(1..<10)  // [Int](1..<10)
print(exam6)
// [1, 2, 3, 4, 5, 6, 7, 8, 9]
{% endhighlight %}

<h2>五、List Comprehension </h2>
---

真正感觉 **Haskell** 的魅力就从这里开始了！

数学中有集合的概念，比如实数集（R）、整数集（Z）、有理数集（Q）等等，这些词提起来满满的都是青春啊！肯定不会陌生啦！通过一些规则可以从既有的集合产生一个新的集合。能被5整除的正整数集合在数学里还记得怎么表示吗？

$$ A = \{ \  5 * x | x \in N_+ \ \} $$

在 **Haskell** 下，我们怎么做到这一点呢？
{% highlight Haskell %}
ghci>[5, 10..]
[5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250,255,260,265,270
{% endhighlight %}
我们可以通过之前所学的 List 的一些操作得到能被5整除的这样一个无限的 List，的确达到这个目的了。如果我们再加一个能被5整除的10个最小正整数这样一个要求，依然可以通过之前所学的来完成。
{% highlight Haskell %}
ghci>take 10 [5, 10..]
[5,10,15,20,25,30,35,40,45,50]
{% endhighlight %}
虽然你完成了！但是不够 Perfect ， Because we have **List Comperhension** NOW! 📣 So

{% highlight Haskell %}
ghci>let a = [x | x <- [1..50], x `mod` 5 == 0]
ghci>a
[5,10,15,20,25,30,35,40,45,50]
{% endhighlight %}
我们只需要告诉我的要求，而不在是通过某些约束或运算得到我想要的数。在 **Haskell** 中，简直跟数学一模一样，真的是太赞了！！再来体会一把.....  🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰  取前100个偶数中大于25的集合是怎样的？

$$ B = \{\ 2 * x | x \in [1,100], 2 * x \geq 25\ \}$$

{% highlight Haskell %}
ghci>let a = [2 * x | x <- [1..100], 2 * x > 25]
ghci>a
[26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126,128,130,132,134,136,138,140,142,144,146,148,150,152,154,156,158,160,162,164,166,168,170,172,174,176,178,180,182,184,186,188,190,192,194,196,198,200]
ghci>
{% endhighlight %}
简直完美，完全不是命令式语言的思维。再比如🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰35到100之间除以6余数为3的集合怎么取？
{% highlight Haskell %}
ghci>let c = [x | x <- [35..100], x `mod` 6 == 3]
ghci>c
[39,45,51,57,63,69,75,81,87,93,99]
{% endhighlight %}
🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰去除一个 List 中的奇数。
{% highlight Haskell %}
ghci>let a = [2, 8, 6, 7, 9]
ghci>a
[2,8,6,7,9]
ghci>let b = [x | x <- a, even x]
ghci>b
[2,8,6]
{% endhighlight %}

* **even**  判断一个数是不是偶数，是返回 **True** ，不是返回 **False**
* **odd**   判断一个数是不是奇数

{% highlight Haskell %}
ghci>:t even
even :: Integral a => a -> Bool
ghci>even 8
True
ghci>even 7
False
-- odd
ghci>odd 7
True
{% endhighlight %}
🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰去除 [[List]] 中的奇数。
{% highlight Haskell %}
ghci>:c
ghci>let aa = [[1..10], [1..5]]
ghci>aa
[[1,2,3,4,5,6,7,8,9,10],[1,2,3,4,5]]

ghci>let b = [[x | x <- a, even x] | a <- aa]
ghci>b
[[2,4,6,8,10],[2,4]]
{% endhighlight %}
🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰去除 [[[List]]] 中的偶数。
{% highlight Haskell %}
ghci>let aaa = [[[1, 2, 3], [1, 4, 5]], [[4, 6], [2,4..20]]]
ghci>aaa
[[[1,2,3],[1,4,5]],[[4,6],[2,4,6,8,10,12,14,16,18,20]]]

ghci>let b = [[[x | x <- a, odd x] | a <- aa] | aa <- aaa]
ghci>b
[[[1,3],[1,5]],[[],[]]]
-- 🤔🤔🤔️如果写个函数会是怎样的？？？
{% endhighlight %}
🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰去除字符串中的大写字母该怎么办？还记得 **test.hs** 吗？在它里面编写一个名为 **removeUppercase** 的函数，像这样
{% highlight Haskell %}
removeUppercase s = [x | x <- s, x `elem` ['a'..'z']]
{% endhighlight %}
然后将 **test.hs** 加载进来，测试看看是否正确。
{% highlight Haskell %}
-- 加载命令还记得吗？
ghci>:l test.hs
[1 of 1] Compiling Main             ( test.hs, interpreted )
Ok, modules loaded: Main.

-- 看看类型
ghci>:t removeUppercase
removeUppercase :: [Char] -> [Char]

-- 声明一个字串
ghci>let haskell = "Haskell"
ghci>haskell
"Haskell"

-- 测试喽！！！
ghci>removeUppercase haskell
"askell"
{% endhighlight %}

<h2>六、Tuple </h2>
---

**Tuple** 就是把多个值合成一个复合值。通过一些简单的🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰来认识它。
{% highlight haskell %}
-- 这就是一个最简单的 Tuple
ghci>(5, 10)
(5,10)

-- Tuple 中可以有不同的类型
ghci>let hasABS = ("ABS", True)
ghci>hasABS
("ABS",True)

-- 可以有多个元素
ghci>let tom = ("Tom", "Cat", 25)
ghci>tom
("Tom","Cat",25)

-- Tuple 中存有 List
ghci>(("Jerry", 123), (["Apple"], ['O', 'r', 'a', 'n', 'g', 'e']), tom)
(("Jerry",123),(["Apple"],"Orange"),("Tom","Cat",25))
{% endhighlight %}
**Tuple** 像 **List** 一样可以比大小。

* Tuple
{% highlight haskell %}
ghci>(1, 2) > (3, 5)
False

ghci>(1, 1, 3) > (1, 1, 2)
True

-- 有没有发现点什么？
ghci>(1, 1, 3) == ((1), (1), (3))
True

ghci>:t (1)
(1) :: Num t => t

ghci>:t 1
1 :: Num t => t
-- 单个元素的 Tuple 是没意义的😄😄😄
{% endhighlight %}
* List
{% highlight haskell %}
ghci>[1, 2] > [3, 5]
False

ghci>[1, 1, 3] > [1, 1, 2]
True

ghci>[1, 1, 3] /= [1, 1, 2]
True
{% endhighlight %}
都是逐个元素比较。但是不能比较不同的个数的 Tuple ，而 List 是可以的。
{% highlight haskell %}
-- Tuple
ghci>(1, 1, 3) > (1, 1, 2, 4)

<interactive>:236:13: error:
    • Couldn't match expected type ‘(Integer, Integer, Integer)’
                  with actual type ‘(Integer, Integer, Integer, Integer)’
    • In the second argument of ‘(>)’, namely ‘(1, 1, 2, 4)’
      In the expression: (1, 1, 3) > (1, 1, 2, 4)
      In an equation for ‘it’: it = (1, 1, 3) > (1, 1, 2, 4)
ghci>

-- List
ghci>[1, 1, 3] > [1, 1, 2, 4]
True
{% endhighlight %}
关于 **Tuple** 有几个常用函数。

* fst: 返回 Tuple 的首项
* snd: 返回 Tuple 的后项
* zip: 生成一组配对的 List

{% highlight haskell %}
ghci>let xiaoMing = ("xiaoMing", 20)

ghci>fst xiaoMing
"xiaoMing"

ghci>snd xiaoMing
20
{% endhighlight %}

**fst、snd** 只能作用与二元组，不能用在三元或四元组······之上。
{% highlight haskell %}
ghci>tom
("Tom","Cat",25)

ghci>fst tom

<interactive>:261:5: error:
    • Couldn't match expected type ‘(a, b0)’
                  with actual type ‘([Char], [Char], Integer)’
    • In the first argument of ‘fst’, namely ‘tom’
      In the expression: fst tom
      In an equation for ‘it’: it = fst tom
    • Relevant bindings include it :: a (bound at <interactive>:261:1)
ghci>
{% endhighlight %}
**zip** 取两个 List，然后交叉配对后返回一个含有 Tuple 的新的 List。
{% highlight haskell %}
ghci>zip [1, 2, 3, 4, 5] ["one", "two", "three", "four", "five"]
[(1,"one"),(2,"two"),(3,"three"),(4,"four"),(5,"five")]

-- 对于不同长度的 List ，zip 按较短原则匹配。（不知道有没有较短原则这么叫的？？？🤔🤔🤔）
ghci>zip [1..5] ["apple"]
[(1,"apple")]

ghci>zip [1..] ['a'..'z']
[(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e'),(6,'f'),(7,'g'),(8,'h'),(9,'i'),(10,'j'),(11,'k'),(12,'l'),(13,'m'),(14,'n'),(15,'o'),(16,'p'),(17,'q'),(18,'r'),(19,'s'),(20,'t'),(21,'u'),(22,'v'),(23,'w'),(24,'x'),(25,'y'),(26,'z')]
{% endhighlight %}
那么怎么好好使用 Tuple 呢？举个🌰🌰怎么取得三边长都小于等于10的直角三角形，且 a 边小于 b 边， b 边小于 c 边。
{% highlight haskell %}
let rightTriangles = [(a, b, c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2]
ghci>rightTriangles
[(3,4,5),(6,8,10)]
{% endhighlight %}
> Cool! 简直完美👏👏🏻👏🏼👏🏼👏🏽👏🏽👏🏾👏🏿 然而我们还需要和 Swift 比较一下。
---

在 **Swift** 中 **Tuple** 是什么样呢？
{% highlight swift %}
// 这就是一个 Tuple
let tuple1 = (5, 8)
print(tuple1)
// (5, 8)

let hasABS = ("ABS", true)
print(hasABS)
// ("ABS", true)

let tom = ("Tom", "Cat", 25)
print(tom)
// ("Tom", "Cat", 25)

let tuple4 = (("Jerry", 123), (["Apple"], "Origin"), tom)
print(tuple4)
// (("Jerry", 123), (["Apple"], "Origin"), ("Tom", "Cat", 25))
{% endhighlight %}
与 Haskell 的 Tuple 差别不多吧！不过 Swift 中的 Tuple 功能更强大。比如以下标或者命名获取 Tuple 中的元素而不局限与个数，比 **fst、snd** 方便多了！
{% highlight swift %}
let tuple4 = (("Jerry", 123), (["Apple"], "Origin"), tom)
print(tuple4.2.1)
// Cat

let tuple5 = (name: "Tom", gender: 1, age: 25)
print(tuple5.gender)
print(tuple5.0)
// 1
// Tom
{% endhighlight %}
在 Swift 中 **Tuple** 也是可以比较的。🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰
{% highlight swift %}
let tuple6: (Int, Int, Int) = (1, 2, 8)
let tuple7 = (1, 2, 5)
print(tuple6 > tuple7)
// true
{% endhighlight %}
Swift中的 **Array** 也是可以比较的。🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰
{% highlight swift %}
let result = [1, 2, 8] > [1, 2, 5]
print(result)
// true
// 不同长度的一样可以比较 [1, 2, 8] > [1, 2, 5, 8, 100] 返回 true

// 但是你不能这样比
let test1 = [1, 2, 8]
let test2 = [1, 2, 5]
test1 > test2
// Binary operator '>' cannot be applied to two '[Int]' operands

{% endhighlight %}
But Swift 提供了很强大的方法让你达到你的目的。
{% highlight swift %}
let isEqual = test1.elementsEqual(test2)
print(isEqual)
// false
// elementsEqual 判断两个数组中的每一个元素是否都相等
{% endhighlight %}
还有更强大的🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰
{% highlight swift %}
let test3 = [10, 20, 30]
let test4 = [1, 2, 3]
let test3GreaterThanTest4 = test3.elementsEqual(test4, by: >)
print(test3GreaterThanTest4)
// true
// test3 的每个元素都大于 test4 才会返回 true

let test3GreaterThanTest4TenTimes = test3.elementsEqual(test4) { (a, b) -> Bool in
    return a > b * 10
}
print(test3GreaterThanTest4TenTimes)
// false
{% endhighlight %}
插播了一点 Swift 中 Array 的细节。我们这会儿在研究 Tuple 了，赶紧回来了。那么来看看 **Swift** 中有没有像 **zip** 这样的函数呢？**zip** 是啥？就是将两个 List 交叉配对行成 Tuple ，这些交叉配对好的 Tuple 组成一个新的 List 返回，这就是 zip 。忘了？？🤓🤓🤓🤓🤓🤓🤓没有😂😂😂🤣🤣🤣🤣🤣你看👆👆👆👆👆哪儿？🔭🔭🔭🔭🔭🔭就是那儿🖕🖕🖕🖕🖕🖕🖕还真有🙀🙀🙀🙀🙀🙀🙀🙀🙀🙀
{% highlight swift %}
let numbers = [1, 2, 3, 4, 5]
let words = ["one", "two", "three", "four", "five"]
let zipResult = zip(numbers, words)
print(Array(zipResult))
// [(1, "one"), (2, "two"), (3, "three"), (4, "four"), (5, "five")]

let zip2 = zip(words, 100...Int.max)
print(Array(zip2))
// [("one", 100), ("two", 101), ("three", 102), ("four", 103), ("five", 104)]
{% endhighlight %}

<h2>七、结尾</h2>
---

到这里总算对 **Haskell** 有了一个不错的认识，更是一个非常有趣的开始。勇往直前......✊✊🏻✊🏼✊🏽✊🏾✊🏿✊✊🏻✊🏼✊🏽✊🏾✊🏿

[更多关于Swift的细节以及code、playground](https://github.com/redtwowolf/redtwowolf.github.io/tree/master/_code/HaskellAndSwift/HaskellAndSwift.playground)

[test.hs](https://github.com/redtwowolf/redtwowolf.github.io/tree/master/_code/HaskellAndSwift/test.hs)
