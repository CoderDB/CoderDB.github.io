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
