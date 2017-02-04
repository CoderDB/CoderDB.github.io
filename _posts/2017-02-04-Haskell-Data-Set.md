---
layout: post
date: 2017-02-04
title: Haskell -- Data.Set
feature-img: "img/pink.jpg"
---

集合
---

创建一个 **testDataSet.hs** 文件，将 Data.Set 引入

{% highlight haskell %}
import qualified Data.Set as Set
{% endhighlight %}

将文件加载到 ghci

{% highlight haskell %}
ghci>:l testDataSet.hs
[1 of 1] Compiling Main             ( testDataSet.hs, interpreted )
Ok, modules loaded: Main.
{% endhighlight %}

学习 Data.Set 中包含的一些函数。

> **fromList**

把一个 List 转为 Set 。**List -> Set**

{% highlight haskell %}
ghci>:t Set.fromList
Set.fromList :: Ord a => [a] -> Set.Set a

ghci>Set.fromList [1..10]
fromList [1,2,3,4,5,6,7,8,9,10]

ghci>Set.fromList ['a'..'z']
fromList "abcdefghijklmnopqrstuvwxyz"

ghci>Set.fromList "Haskell"
fromList "Haekls"
-- 与 Data.Map 中的 fromList 函数相同，元素唯一，也会排序

ghci>Set.fromList "I am Iron man"
fromList " Iamnor"
{% endhighlight %}

> **insert**

向 Set 中插入元素。

{% highlight haskell %}
ghci>:t Set.insert
Set.insert :: Ord a => a -> Set.Set a -> Set.Set a

ghci>Set.insert 1 $ Set.fromList [5..10]
fromList [1,5,6,7,8,9,10]

ghci>Set.insert 1 $ Set.fromList [1..5]
fromList [1,2,3,4,5]

ghci>Set.insert 1 $ Set.empty
fromList [1]
-- Set.empty 返回一个空 Set

ghci>Set.empty
fromList []

ghci>Set.insert 'a' $ Set.fromList ['f'..'m']
fromList "afghijklm"

ghci>Set.insert "man" $ Set.fromList ["I", "am", "Iron"]
fromList ["I","Iron","am","man"]
{% endhighlight %}

> **null**

判断一个 Set 是否为空。

{% highlight haskell %}
ghci>:t Set.null
Set.null :: Set.Set a -> Bool

ghci>Set.null $ Set.empty
True

ghci>Set.null $ Set.fromList []
True

ghci>Set.null $ Set.fromList [1..10]
False
{% endhighlight %}

> **size**

返回一个 Set 的大小。

{% highlight haskell %}
ghci>:t Set.size
Set.size :: Set.Set a -> Int

ghci>Set.size Set.empty
0

ghci>Set.size $ Set.fromList [1..10]
10
{% endhighlight %}

> **singleton**

返回只含有一个元素的 Set 。

{% highlight haskell %}
ghci>:t Set.singleton
Set.singleton :: a -> Set.Set a

ghci>Set.singleton 1
fromList [1]

ghci>Set.insert 2 $ Set.singleton 1
fromList [1,2]
{% endhighlight %}
