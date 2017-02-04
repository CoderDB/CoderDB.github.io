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

> **member**

判断一个元素是否属于 Set 。

{% highlight haskell %}
ghci>:t Set.member
Set.member :: Ord a => a -> Set.Set a -> Bool

ghci>Set.member 1 $ Set.fromList [1..10]
True

ghci>Set.member 1 $ Set.fromList [10..20]
False
{% endhighlight %}

> **delete**

删除 Set 中的某一元素。

{% highlight haskell %}
ghci>:t Set.delete
Set.delete :: Ord a => a -> Set.Set a -> Set.Set a

ghci>Set.delete 1 $ Set.empty
fromList []

ghci>Set.delete 1 $ Set.fromList [1..10]
fromList [2,3,4,5,6,7,8,9,10]

ghci>Set.delete 1 $ Set.fromList [5..10]
fromList [5,6,7,8,9,10]
{% endhighlight %}

> **map**

与 Data.Map 中的 **map** 函数类似。

{% highlight haskell %}
ghci>:t Set.map
Set.map :: Ord b => (a -> b) -> Set.Set a -> Set.Set b

ghci>Set.map (+1) $ Set.fromList [1..10]
fromList [2,3,4,5,6,7,8,9,10,11]

ghci>Set.map toUpper $ Set.fromList ['a'..'z']
fromList "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
{% endhighlight %}

> **filter**

与 Data.Map 中的 **filter** 函数类似。

{% highlight haskell %}
ghci>:t Set.filter
Set.filter :: (a -> Bool) -> Set.Set a -> Set.Set a

ghci>Set.filter (>6) $ Set.fromList [1..10]
fromList [7,8,9,10]

ghci>Set.filter isUpper $ Set.fromList ['A'..'z']
fromList "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
{% endhighlight %}

> **intersection**

求两个 Set 的交集。

{% highlight haskell %}
ghci>:t Set.intersection
Set.intersection :: Ord a => Set.Set a -> Set.Set a -> Set.Set a

ghci>Set.intersection Set.empty Set.empty  
fromList []

ghci>let set1 = Set.fromList [1..10]
ghci>let set2 = Set.fromList [5..20]
ghci>Set.intersection set1 set2
fromList [5,6,7,8,9,10]
{% endhighlight %}

> **union**

求两个 Set 的并集。

{% highlight haskell %}
ghci>:t Set.union
Set.union :: Ord a => Set.Set a -> Set.Set a -> Set.Set a

ghci>Set.union set1 set2
fromList [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
{% endhighlight %}

> **difference**

求两个 Set 的差集。

{% highlight haskell %}
ghci>:t Set.difference
Set.difference :: Ord a => Set.Set a -> Set.Set a -> Set.Set a

ghci>set1
fromList [1,2,3,4,5,6,7,8,9,10]
ghci>set2
fromList [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

ghci>Set.difference set1 set2
fromList [1,2,3,4]
-- 在 set1 不在 set2 的元素

ghci>Set.difference set2 set1
fromList [11,12,13,14,15,16,17,18,19,20]
-- 在 set2 不在 set1 的元素

ghci>Set.difference set2 set2
fromList []
{% endhighlight %}
