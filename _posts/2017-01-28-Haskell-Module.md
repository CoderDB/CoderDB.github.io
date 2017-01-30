---
layout: post
date: 2017-01-28
title: Haskell 中的 Module
feature-img: "img/pink.jpg"
---

*模组* 就是一大袋花样众多的零食，拆了就吃。

Module
---
---

Haskell 的标准库就是一组 *模组*，每个模组都包含一些功能相近或相似的函数或型别。比如之前所有文章中的测试例子都是基于 *Prelude* 模组。

装载模组
---
---

Haskell 中装载模组用关键字 **import**，就像 Objective-C 中定义了一个 **People** 类,在需要用到它的某个实现文件中以 *#import "People.h"* 引入一样，而 **People** 可以看作是一个模组。比如在 Haskell 中装载 *Data.List* ，新建一个文件命名为 **testModule.hs**，在文件的开始处装载模组，像这样键入 *import Data.List*

{% highlight haskell %}
ghci> :t nub
<interactive>:1:1: error: Variable not in scope: nub

ghci> :l testModule.hs
[1 of 1] Compiling Main             ( testModule.hs, interpreted )
Ok, modules loaded: Main.

ghci> :t nu
nub    nubBy  null
-- 装载了 Data.List 模组之后，nub 是该模组中的一个函数
ghci> :t nub
nub :: Eq a => [a] -> [a]
{% endhighlight %}

**nub** 函数是筛掉一个 List 中所有重复的元素。

{% highlight haskell %}
ghci>nub [1, 2, 4, 3, 2, 1]
[1,2,4,3]

ghci>nub [1, 2, 3, 3, 2, 1]
[1,2,3]

ghci>nub [1, 2, 3, 3, 2, 1, 1, 2, 3]
[1,2,3]
{% endhighlight %}

**在 ghci 中装载模组** 用 **:m**。**:m** 就是 **:module** 简写。

{% highlight haskell %}
ghci>:t nub
<interactive>:1:1: error: Variable not in scope: nub

ghci>:m
:main    :module

ghci>:m Data.List

ghci>:t nu
nub    nubBy  null
{% endhighlight %}

**:m** 可以一次装载多个模组。

{% highlight haskell %}
ghci>:m Data.List Data.Map Data.Map.Lazy
{% endhighlight %}

**:m** 也可以装载指定的函数。

{% highlight haskell %}
ghci>:m Data.List(nub,sort)
syntax:  :module [+/-] [*]M1 ... [*]Mn
-- 只装载 nub、sort 函数

ghci>:t sort
sort :: Ord a => [a] -> [a]

ghci>sort [1, 5, 4]
[1,4,5]
{% endhighlight %}

**:m** 包含去除指定函数的模组。

{% highlight haskell %}
ghci> :m Data.List hiding (sort)
syntax:  :module [+/-] [*]M1 ... [*]Mn

ghci> :t sort
<interactive>:1:1: error:
    • Variable not in scope: sort
{% endhighlight %}

**qualified**

在装载模组时为了避免命名冲突，可以使用 **qualified** 关键字。比如：

{% highlight haskell %}
import qualified Data.Map
{% endhighlight %}

为某个模组起个别名

{% highlight haskell %}
import qualified Data.Map as M


ghci>:l testModule.hs
[1 of 1] Compiling Main             ( testModule.hs, interpreted )
Ok, modules loaded: Main.

ghci>M.fi
M.filter           M.filterWithKey    M.findIndex        M.findMax          M.findMin          M.findWithDefault
{% endhighlight %}

Data.List
---
---

一个关于 List 操作的模组，比如 **map, filter** 都是属于它的。

> **intersperse**

将指定的值洒在 List 元素中间。

{% highlight haskell %}
ghci>:t intersperse
intersperse :: a -> [a] -> [a]

ghci>intersperse 0 [1, 2, 3]
[1,0,2,0,3]

ghci>intersperse '_' "Haskell"
"H_a_s_k_e_l_l"

ghci>intersperse [0] [[1], [1, 1], [2], [3, 3, 3]]
[[1],[0],[1,1],[0],[2],[0],[3,3,3]]
{% endhighlight %}

> **insert**

将一个指定的值插在 List 中它该插的位置 👀👀👀👀👀

{% highlight haskell %}
ghci>:t insert
insert :: Ord a => a -> [a] -> [a]

ghci>insert 1 [2, 2, 2]
[1,2,2,2]

ghci>insert 3 [2, 2, 2]
[2,2,2,3]

ghci>insert 5 [1, 3, 5, 7, 9]
[1,3,5,5,7,9]

ghci>insert 'm' "haskell"
"hamskell"

ghci>insert 'x' "haskell"
"haskellx"

ghci>insert "x" ["h", "a", "s", "k", "e", "l", "l"]
["h","a","s","k","e","l","l","x"]

ghci>insert "xyz" ["h", "a", "s", "k", "e", "l", "l"]
["h","a","s","k","e","l","l","xyz"]

ghci>insert '_' "Haskell"
"H_askell"
{% endhighlight %}

> **intercalate**

将一个 [...] 插入到另一个 [[], [...], []] 并展平成[...]后返回。

{% highlight haskell %}
ghci>:t intercalate
intercalate :: [a] -> [[a]] -> [a]

ghci>intercalate [1] [[0], [0], [0]]
[0,1,0,1,0]

ghci>intercalate " " ["Hello", "I", "am", "Icon", "man"]
"Hello I am Icon man"

ghci>intercalate [[0],[1]] [[[5]], [[6]]]
[[5],[0],[1],[6]]
{% endhighlight %}

> **transpose**

相当于矩阵做行列互换操作。

$$\left[ \begin{matrix} 1 & 2 & 3 \\ 4 & 5 & 6 \\ 7 & 8 & 9 \end{matrix} \right] \tag{1}$$

{% highlight haskell %}
ghci>:t transpose
transpose :: [[a]] -> [[a]]

ghci>transpose [[1,2,3], [4,5,6]]
[[1,4],[2,5],[3,6]]

ghci>transpose [[1,2,3], [4,5,6], [7,8,9]]
[[1,4,7],[2,5,8],[3,6,9]]

ghci>transpose ["I", "am", "Icon", "man"]
["IaIm","mca","on","n"]
{% endhighlight %}

> **foldl'**

**foldl'** 与 [**foldl**](https://redtwowolf.github.io/2017/01/27/Fold-Scan.html) 功能是一致的，只不过后者是惰性的。

{% highlight haskell %}
ghci>foldl' (+) 0 [1, 2, 3, 4, 5]
15

ghci>foldl' (-) 10 [1, 2, 3, 4, 5]
-5
{% endhighlight %}

> **foldl1'**

**foldl1'** 与 [**foldl1**](https://redtwowolf.github.io/2017/01/27/Fold-Scan.html) 功能是一致的，只不过后者是惰性的。

{% highlight haskell %}
ghci>foldl1' (+) [1, 2, 3, 4, 5]
15

ghci>foldl1' (-) [1, 2, 3, 4, 5]
-13
{% endhighlight %}

> **concat**

将一组 List 展平成一个 List 。

{% highlight haskell %}
ghci>:t concat
concat :: Foldable t => t [a] -> [a]

ghci>concat ["I", "am", "Iron", "man"]
"IamIronman"

ghci>concat [[1, 2], [3, 4], [5, 6, 7]]
[1,2,3,4,5,6,7]

ghci>concat [[[1, 2], [5]], [[0, 0],[3, 4]], [[5, 6, 7]]]
[[1,2],[5],[0,0],[3,4],[5,6,7]]
{% endhighlight %}

> **concatMap**

**concatMap** = **concat** + **map**

{% highlight haskell %}
ghci>concatMap (replicate 4) [1,2,3]
[1,1,1,1,2,2,2,2,3,3,3,3]
{% endhighlight %}

> **and**

List 中元素都为 **True** 则 **and** 返回 **True** 。

{% highlight haskell %}
ghci>:t and
and :: Foldable t => t Bool -> Bool

ghci>and [True, True, True]
True

ghci>and [True, True, False]
{% endhighlight %}

> **or**

List 中有一个 **True** 就为 **True** 。

{% highlight haskell %}
ghci>:t or
or :: Foldable t => t Bool -> Bool

ghci>or [True, True, True]
True

ghci>or [True, False, False]
True

ghci>or [False, False, False]
False
{% endhighlight %}

> **any**

**any** 当 List 中有一个元素满足给定的条件就返回 **True** 。

{% highlight haskell %}
ghci>:t any
any :: Foldable t => (a -> Bool) -> t a -> Bool

ghci>any (>5) [1..10]
True

ghci>any (>5) [1..5]
False

ghci>any (==5) [1..5]
True
{% endhighlight %}

> **all**

当 List 中所有元素都满足给定条件则返回 **True** 。

{% highlight haskell %}
ghci>all (>5) [10..20]
True

ghci>all (>5) [1..20]
False

ghci>all (==5) $ take 5 $ repeat 5
True
{% endhighlight %}

> **iterate**

返回一个给定值呼叫给定函数的无限 List 。

{% highlight haskell %}
ghci>:t iterate
iterate :: (a -> a) -> a -> [a]

ghci>take 10 (iterate (*10) 1)
[1,10,100,1000,10000,100000,1000000,10000000,100000000,1000000000]

ghci>take 10 (iterate (+10) 1)
[1,11,21,31,41,51,61,71,81,91]

-- 2 的 10 次方
ghci>take 10 $ iterate (*2) 2
[2,4,8,16,32,64,128,256,512,1024]
{% endhighlight %}

> **splitAt**

将一个 List 从给定的某个位置处分开，并返回一个元组。

{% highlight haskell %}
ghci>:t splitAt
splitAt :: Int -> [a] -> ([a], [a])

ghci>splitAt 3 "Haskell"
("Has","kell")

ghci>splitAt 10 "Haskell"
("Haskell","")
{% endhighlight %}

> **takeWhile**

取一个 List 中符合给定条件的元素，遇到不符合的则停止。

{% highlight haskell %}
ghci>:t takeWhile
takeWhile :: (a -> Bool) -> [a] -> [a]

ghci>takeWhile (>5) [1..10]
[]

ghci>takeWhile (>5) [10..20]
[10,11,12,13,14,15,16,17,18,19,20]
{% endhighlight %}

> **dropWhile**

扔掉符合条件的元素，返回余下的元素，换句话说，就是一旦遇到不符合条件的元素立即停止并返回。

{% highlight haskell %}
ghci>dropWhile (>3) [1..10]
[1,2,3,4,5,6,7,8,9,10]
-- 第一个与元素 1 不大于 3，停止比较并返回

ghci>dropWhile (>0) [1..10]
[]
-- 砍掉所有符合条件的元素

ghci>dropWhile (=='a') "abcde"
"bcde"

ghci>dropWhile (=='a') "abade"
"bade"

ghci>dropWhile (=='a') "ababa"
"baba"
{% endhighlight %}


> **span**

将一个 List 在首次👉不符合👈条件的地方断开，前后两部分以元组的形式返回。

{% highlight haskell %}
ghci>span (/=' ') "Man Women"
("Man"," Women")
-- 'M', 'a', 'n' 三个元素和 ' ' 比较都返回 True，直到第四个元素返回 False
-- 所以 List 在这里断开

ghci>span (>5) [5..10]
([],[5,6,7,8,9,10])

ghci>span (==5) [5..10]
([5],[6,7,8,9,10])
{% endhighlight %}

> **break**

将一个 List 在首次👉符合👈条件的地方断开，前后两部分以元组的形式返回。

{% highlight haskell %}
ghci>break (/=' ') "Man Women"
("","Man Women")

ghci>break (>5) [5..10]
([5],[6,7,8,9,10])

ghci>break (==5) [5..10]
([],[5,6,7,8,9,10])
-- 首次遇到符合条件的元素 5 并在这里断开，而 5 则归于返回元组的 snd 中。
{% endhighlight %}

> **sort**

对一个 List 做升序后返回。

{% highlight haskell %}
ghci>:t sort
sort :: Ord a => [a] -> [a]

ghci>sort [-10, 9, 100, 7, -7]
[-10,-7,7,9,100]

ghci>sort [10, 9..1]
[1,2,3,4,5,6,7,8,9,10]
{% endhighlight %}

> **group**

对 List 分类，相邻元素如果相等则归为一类。

{% highlight haskell %}
ghci>group [1, 1, 1, 2, 2, 3, 2, 2, 4, 4, 5, 5]
[[1,1,1],[2,2],[3],[2,2],[4,4],[5,5]]

ghci>group [1..10]
[[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]]

ghci>group "haskell"
["h","a","s","k","e","ll"]
{% endhighlight %}


> **tails**

返回一个 List 的 **tail** ，然后返回 **tail** 的 **tail** 。

{% highlight haskell %}
ghci>:t tails
tails :: [a] -> [[a]]

ghci>tails [1, 2, 3]
[[1,2,3],[2,3],[3],[]]

ghci>tails "Haskell"
["Haskell","askell","skell","kell","ell","ll","l",""]
{% endhighlight %}

> **inits**

返回一个 List 的 **init** ，然后返回 **init** 的 **init** 。

{% highlight haskell %}
ghci>inits [1, 2, 3]
[[],[1],[1,2],[1,2,3]]

ghci>inits "Haskell"
["","H","Ha","Has","Hask","Haske","Haskel","Haskell"]
{% endhighlight %}

> **isInfixOf**

如果一个 ListA 是 ListB 的子 List 则返回 **True** 。

{% highlight haskell %}
ghci>:t isInfixOf
isInfixOf :: Eq a => [a] -> [a] -> Bool

ghci>isInfixOf "man" "I am Irom man"
True

ghci>"ask" `isInfixOf` "Waht's the Haskell"
True
{% endhighlight %}

> **isPrefixOf**

是否以某个 List 开头，如果是返回 **True** 。

{% highlight haskell %}
ghci>isPrefixOf "I" "I am Irom man"
True

ghci>"what" `isPrefixOf` "I am Irom man"
False

ghci>isPrefixOf "What" "What's Haskell"
True
{% endhighlight %}

> **isSuffixOf**

是否以某个 List 结尾，如果是返回 **True** 。

{% highlight haskell %}
ghci>isSuffixOf "I" "I am Icon man"
False

ghci>isSuffixOf "man" "I am Icon man"
True
{% endhighlight %}

> **partition**

以给定条件分割一个 List 并返回一个长成这样的 ([符合], [不符合]) 元组。

{% highlight haskell %}
ghci>:t partition
partition :: (a -> Bool) -> [a] -> ([a], [a])

ghci>partition (>5) [1..10]
([6,7,8,9,10],[1,2,3,4,5])
{% endhighlight %}

> **find**

找到返回符合给定条件的首个元素。

{% highlight haskell %}
ghci>:t find
find :: Foldable t => (a -> Bool) -> t a -> Maybe a

ghci>find (>5) [1..10]
Just 6

ghci>find (=="Iron") ["I", "am", "Iron", "man"]
Just "Iron"

ghci>find (>10) [1..10]
Nothing
{% endhighlight %}

**Maybe** 是一种类型，这种类型的值只能为 **Nothing** 或 **Just** 。

{% highlight haskell %}
ghci>let iron = find (=="Iron") ["I", "am", "Iron", "man"]
ghci>iron
Just "Iron"

ghci>:t iron
iron :: Maybe [Char]

ghci>:t Nothing
Nothing :: Maybe a
{% endhighlight %}

> **findIndex**

找到符合条件的首个元素的索引。

{% highlight haskell %}
ghci>findIndex (==4) [1..10]
Just 3

ghci>findIndex (=="Iron") ["I", "am", "Iron", "man"]
Just 2

ghci>findIndex (=='l') "Haskell"
Just 5

ghci>findIndex (<0) [1..10]
Nothing
{% endhighlight %}

> **findIndices**

返回符合条元素的所有索引。

{% highlight haskell %}
ghci>findIndices (`elem` ['A'..'Z']) "I am Iron man"
[0,5]

ghci>findIndices (=='l') "Haskell"
[5,6]

ghci>findIndices (=='z') "Haskell"
[]
{% endhighlight %}


>**elemIndex**

返回元素在 List 的索引。

{% highlight haskell %}
ghci>:t elemIndex
elemIndex :: Eq a => a -> [a] -> Maybe Int

ghci>elemIndex 5 [1..10]
Just 4

ghci>elemIndex 'k' "Haskell"
Just 3

ghci>' ' `elemIndex` "Haskell"
Nothing
{% endhighlight %}

> **elemIndices**

返回元素在 List 的索引组成的 List。

{% highlight haskell %}
ghci>:t elemIndices
elemIndices :: Eq a => a -> [a] -> [Int]

ghci>elemIndices 5 [1..10]
[4]

ghci>elemIndices 'k' "Haskell"
[3]

ghci>elemIndices 'l' "Haskell"
[5,6]
{% endhighlight %}
