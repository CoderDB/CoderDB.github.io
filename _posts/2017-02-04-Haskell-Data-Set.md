---
layout: post
date: 2017-02-04
title: Haskell -- Data.Set
img: "pink.jpg"
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

> **notMember**

判断一个元素是否属于 Set 。

{% highlight haskell %}
ghci>:t Set.notMember
Set.notMember :: Ord a => a -> Set.Set a -> Bool

ghci>Set.notMember 1 $ Set.fromList [1..10]
False

ghci>Set.notMember 1 $ Set.fromList [10..20]
True
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

> **deleteAt**

删除指定下标处的元素。

{% highlight haskell %}
ghci>:t Set.deleteAt
Set.deleteAt :: Int -> Set.Set a -> Set.Set a

ghci>let set = Set.fromList [10..30]

ghci>set
fromList [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

ghci>Set.deleteAt 0 set
fromList [11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

ghci>Set.deleteAt (Set.size set - 1) set
fromList [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]
{% endhighlight %}

> **deleteMax**

删除 Set 中最大的元素，返回剩下的 Set 。

{% highlight haskell %}
ghci>:t Set.deleteMax
Set.deleteMax :: Set.Set a -> Set.Set a

ghci>Set.deleteMax set
fromList [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]

ghci>Set.deleteMax $ Set.fromList [1..5]
fromList [1,2,3,4]
{% endhighlight %}

> **deleteMin**

删除 Set 中最小的元素，返回剩下的 Set 。

{% highlight haskell %}
ghci>:t Set.deleteMin
Set.deleteMin :: Set.Set a -> Set.Set a

ghci>Set.deleteMin set
fromList [11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

ghci>Set.deleteMin $ Set.fromList [1..5]
fromList [2,3,4,5]
{% endhighlight %}



> **deleteFindMax**

找出 Set 中最大的元素并从原 Set 删除，返回一个元组，包含被删除的最大元素与剩余元素的 Set 。

{% highlight haskell %}
ghci>:t Set.deleteFindMax
Set.deleteFindMax :: Set.Set a -> (a, Set.Set a)

ghci>Set.deleteFindMax set
(30,fromList [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29])

ghci>Set.deleteFindMax $ Set.fromList [1..5]
(5,fromList [1,2,3,4])

ghci>Set.deleteFindMax $ Set.insert 10 $ Set.insert 20 $ Set.singleton 5
(20,fromList [5,10])
{% endhighlight %}

> **deleteFindMin**

找出 Set 中最小的元素并从原 Set 删除，返回一个元组，包含被删除的最小元素与剩余元素的 Set 。

{% highlight haskell %}
ghci>:t Set.deleteFindMin
Set.deleteFindMin :: Set.Set a -> (a, Set.Set a)

ghci>Set.deleteFindMin set
(10,fromList [11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30])

ghci>Set.deleteFindMin $ Set.fromList [1..5]
(1,fromList [2,3,4,5])
{% endhighlight %}

> **elemAt**

返回 Set 中给定下标处的元素。

{% highlight haskell %}
ghci>:t Set.elemAt
Set.elemAt :: Int -> Set.Set a -> a

ghci>Set.elemAt 0 set
10

ghci>Set.elemAt 5 $ Set.fromList "Haskell"
's'

ghci>Set.elemAt 0 $ Set.insert "Haskell" $ Set.singleton "Hello"
"Haskell"
{% endhighlight %}

> **elems**

返回 Set 所有元素。 **Set -> List**

{% highlight haskell %}
ghci>:t Set.elems
Set.elems :: Set.Set a -> [a]

ghci>Set.elems set
[10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

ghci>Set.elems $ Set.fromList "Haskell"
"Haekls"

ghci>Set.elems $ Set.insert "Haskell" $ Set.singleton "Hello"
["Haskell","Hello"]
{% endhighlight %}

> **split**

把 Set 在给定元素处劈成两截，返回装着这两截的元组。

{% highlight haskell %}
ghci>:t Set.split
Set.split :: Ord a => a -> Set.Set a -> (Set.Set a, Set.Set a)

ghci>Set.split 20 set
(fromList [10,11,12,13,14,15,16,17,18,19],fromList [21,22,23,24,25,26,27,28,29,30])

ghci>Set.split 15 $ fst $ Set.split 20 set
(fromList [10,11,12,13,14],fromList [16,17,18,19])

ghci>Set.elems $ snd $ Set.split 15 $ fst $ Set.split 20 set
[16,17,18,19]
{% endhighlight %}

> **splitMember**

把 Set 在给定元素处劈成三截，并把该元素替换为一个 **Bool** 值，返回一个三元组。像是把 **split, member** 合起来一样。

{% highlight haskell %}
Set.splitMember
  :: Ord a => a -> Set.Set a -> (Set.Set a, Bool, Set.Set a)

ghci>Set.splitMember 20 set
(fromList [10,11,12,13,14,15,16,17,18,19],True,fromList [21,22,23,24,25,26,27,28,29,30])
-- 在 20 处劈开，替换为 Bool

ghci>Set.splitMember 0 set
(fromList [],False,fromList [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30])

ghci>Set.splitMember 2 $ Set.insert 5 $ Set.singleton 2
(fromList [],True,fromList [5])

ghci>Set.splitMember 'a' $ Set.insert 'b' $ Set.insert 'c' $ Set.singleton 'd'
(fromList "",False,fromList "bcd")
{% endhighlight %}

> **lookupGE**

在 Set 中查找 *大于或等于* 给定值的元素，返回一个 **Maybe** 值。 GE = greater or equal

{% highlight haskell %}
ghci>:t Set.lookupGE
Set.lookupGE :: Ord a => a -> Set.Set a -> Maybe a

ghci>set
fromList [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

ghci>Set.lookupGE 20 set
Just 20

ghci>Set.lookupGE 0 set
Just 10

ghci>Set.lookupGE 31 set
Nothing
{% endhighlight %}

> **lookupGT**

在 Set 中查找 *大于* 给定值的元素，返回一个 **Maybe** 值。 GT = greater than

{% highlight haskell %}
ghci>:t Set.lookupGT
Set.lookupGT :: Ord a => a -> Set.Set a -> Maybe a

ghci>Set.lookupGT 20 set
Just 21

ghci>Set.lookupGT 0 set
Just 10

ghci>Set.lookupGT 30 set
Nothing

ghci>Set.lookupGT 'f' $ Set.fromList "Haskell"
Just 'k'

ghci>Set.lookupGT 'z' $ Set.fromList "Haskell"
Nothing
{% endhighlight %}

> **lookupLE**

在 Set 中查询 *小于等于* 给定值的元素，返回一个 **Maybe** 值。 LE = less or equal

{% highlight haskell %}
ghci>:t Set.lookupLE
Set.lookupLE :: Ord a => a -> Set.Set a -> Maybe a

ghci>Set.lookupLE 20 set
Just 20

ghci>Set.lookupLE 0 set
Nothing

ghci>Set.lookupLE 10 set
Just 10

ghci>Set.lookupLE 31 set
Just 30
{% endhighlight %}

> **lookupLT**

在 Set 中查询 *小于* 给定值的元素，返回一个 **Maybe** 值。 LT = less than

{% highlight haskell %}
ghci>:t Set.lookupLT
Set.lookupLT :: Ord a => a -> Set.Set a -> Maybe a

ghci>Set.lookupLT 20 set
Just 19

ghci>Set.lookupLT 0 set
Nothing

ghci>Set.lookupLT 10 set
Nothing

ghci>Set.lookupLT 30 set
Just 29

ghci>Set.lookupLT 'f' $ Set.fromList "Haskell"
Just 'e'

ghci>Set.lookupLT 'a' $ Set.fromList "Haskell"
Just 'H'
{% endhighlight %}

> **lookupIndex**

在 Set 中查询给定元素的下标，返回一个 **Maybe** 值。

{% highlight haskell %}
ghci>:t Set.lookupIndex
Set.lookupIndex :: Ord a => a -> Set.Set a -> Maybe Int

ghci>Set.lookupIndex 20 set
Just 10

ghci>Set.lookupIndex 0 set
Nothing

ghci>Set.lookupIndex 30 set
Just 20

ghci>Set.lookupIndex 'e' $ Set.fromList "Haskell"
Just 2

ghci>Set.lookupIndex 'l' $ Set.fromList "Haskell"
Just 4

ghci>Set.lookupIndex 's' $ Set.fromList "Haskell"
Just 5
{% endhighlight %}

> **maxView**

找出 Set 中最大值并从 Set 中取出与剩下的元素组成元组返回。

{% highlight haskell %}
ghci>:t Set.maxView
Set.maxView :: Set.Set a -> Maybe (a, Set.Set a)

ghci>Set.maxView set
Just (30,fromList [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29])

ghci>Set.maxView $ Set.fromList "Haskell"
Just ('s',fromList "Haekl")

ghci>Set.maxView Set.empty
Nothing
{% endhighlight %}

> **minView**

找出 Set 中最小值并从 Set 中取出与剩下的元素组成元组返回。

{% highlight haskell %}
ghci>:t Set.minView
Set.minView :: Set.Set a -> Maybe (a, Set.Set a)

ghci>Set.minView set
Just (10,fromList [11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30])

ghci>Set.minView $ Set.fromList "Haskell"
Just ('H',fromList "aekls")

ghci>Set.minView Set.empty
Nothing
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

> **isSubsetOf**

判断 Set1 是不是 Set2 的子集。

{% highlight haskell %}
ghci>:t Set.isSubsetOf
Set.isSubsetOf :: Ord a => Set.Set a -> Set.Set a -> Bool

ghci>Set.isSubsetOf set1 set2
False
-- set1 = fromList [1,2,3,4,5,6,7,8,9,10]
-- set2 = fromList [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

ghci>let set3 = Set.fromList [5..15]

ghci>Set.isSubsetOf set3 set2
True

ghci>set2 `Set.isSubsetOf` set3
False
-- 以中缀函数调用

ghci>Set.isSubsetOf Set.empty set1
True

ghci>Set.isSubsetOf Set.empty Set.empty
True
-- 空集是任意集合的子集
{% endhighlight %}

> **isProperSubsetOf**

判断 Set1 是不是 Set2 的真子集。

{% highlight haskell %}
ghci>:t Set.isProperSubsetOf
Set.isProperSubsetOf :: Ord a => Set.Set a -> Set.Set a -> Bool

ghci>Set.isProperSubsetOf set3 set2
True

ghci>Set.isProperSubsetOf set3 set3
False
-- 真子集：A 包含于 B 且 A 不等于 B ，或者说 B 集合的元素一定比 A 集合元素多

ghci>Set.empty `Set.isProperSubsetOf` Set.empty
False

ghci>Set.isProperSubsetOf Set.empty set1
True
{% endhighlight %}
