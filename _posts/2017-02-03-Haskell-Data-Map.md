---
layout: post
date: 2017-02-03
title: Haskell -- Data.Map
feature-img: "img/bluepurple.jpg"
---

[key, value]

关联列表（字典）
---
---

创建一个 **testDataMap.hs** 文件，在文件中引入 Data.Map 模组，

{% highlight haskell %}
import qualified Data.Map as Map
{% endhighlight %}

将文件加载到 ghci

{% highlight haskell %}
ghci>:l testDataMap.hs
[1 of 1] Compiling Main             ( testDataMap.hs, interpreted )
Ok, modules loaded: Main.
{% endhighlight %}

学习 Data.Map 模组中包含的一些函数。

> **fromList**

取一个关联列表，返回一个去掉重复键并排序后的关联列表。 **List -> Map**

{% highlight haskell %}
ghci>:t Map.fromList
Map.fromList :: Ord k => [(k, a)] -> Map.Map k a
-- 键必须是可排序的

ghci>Map.fromList[("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
fromList [("Danny","01853"),("Mary","0005"),("Tom","0001")]
-- 以键排序

ghci>Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853"), ("Tom", "00345")]
fromList [("Danny","01853"),("Mary","0005"),("Tom","00345")]
-- 去掉重复键，或者说键必须唯一，或者说同一键的值被覆盖

ghci>Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853"), ("Tom", "00345"), ("Tom", "98742")]
fromList [("Danny","01853"),("Mary","0005"),("Tom","98742")]

ghci>Map.fromList [(2, "0001"), (80, "0005"), (3, "01853")]
fromList [(2,"0001"),(3,"01853"),(80,"0005")]

ghci>Map.fromList [(2, "0001"), (80, "0005"), (3, "01853"), (3, "")]
fromList [(2,"0001"),(3,""),(80,"0005")]
{% endhighlight %}

> **insert**

给一个 Map 插入键值对并返回新的 Map

{% highlight haskell %}
ghci>:t Map.insert
Map.insert :: Ord k => k -> a -> Map k a -> Map k a
-- 取一个键，一个值， 一个 map
-- 返回一个 map

ghci>Map.insert "Tom" "0001" Map.empty
fromList [("Tom","0001")]
-- 把 key = "Tom" , value = "0001" 插入到空 map 中
-- Map.empty 返回一个空的 map

-- Map.empty
ghci>Map.empty
fromList []

ghci>let userInfo = Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
ghci>userInfo
fromList [("Danny","01853"),("Mary","0005"),("Tom","0001")]

ghci>Map.insert "Jerry" "0809" userInfo
fromList [("Danny","01853"),("Jerry","0809"),("Mary","0005"),("Tom","0001")]

ghci>Map.insert 1 10 $ Map.insert 2 20 $ Map.empty
fromList [(1,10),(2,20)]

ghci>Map.insert 1 10 . Map.insert 2 20 . Map.insert 3 30 $  Map.empty
fromList [(1,10),(2,20),(3,30)]
-- 忘了点代表什么了吗？
-- 点是函数组合，别忘了！它和命令式语言中的点语法不一样哦🤓🤓🤓
-- (f . g) x = f (g x)
{% endhighlight %}

> **null**

检查一个 Map 是否为空。

{% highlight haskell %}
ghci>:t Map.null
Map.null :: Map k a -> Bool

ghci>Map.null $ Map.fromList [("Tom", "0001")]
False

ghci>Map.null Map.empty
True

ghci>Map.null $ Map.fromList []
True
{% endhighlight %}

> **size**

返回一个 Map 的大小。

{% highlight haskell %}
ghci>:t size
size :: Map k a -> Int

ghci>Map.size Map.empty
0

ghci>Map.size $ Map.fromList [("Tom", "0001")]
1

ghci>Map.size $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853"), ("Tom", "00345")]
3
{% endhighlight %}

> **singleton**

返回只含有一个键值对的 Map 。

{% highlight haskell %}
ghci>:t Map.singleton
Map.singleton :: k -> a -> Map.Map k a

ghci>Map.singleton "Tom" "0001"
fromList [("Tom","0001")]

ghci>Map.insert "Lucy" "0306" $ Map.singleton "Tom" "0001"
fromList [("Lucy","0306"),("Tom","0001")]
{% endhighlight %}

> **delete**

删除 Map 中指定 key 处的元素。

{% highlight haskell %}
ghci>:t Map.delete
Map.delete :: Ord k => k -> Map.Map k a -> Map.Map k a

ghci>Map.delete 1 $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'c')]
fromList [(2,'b'),(3,'c')]

ghci>Map.delete 5 $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'c')]
fromList [(1,'a'),(2,'b'),(3,'c')]

ghci>Map.delete "Tom" $ Map.insert "Tom" 98 $ Map.singleton "Jerry" 100
fromList [("Jerry",100)]
{% endhighlight %}

> **deleteAt**

删除 Map 中指定下标处的元素。

{% highlight haskell %}
ghci>:t Map.deleteAt
Map.deleteAt :: Int -> Map.Map k a -> Map.Map k a

ghci>Map.deleteAt 1 $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'c')]
fromList [(1,'a'),(3,'c')]

ghci>Map.deleteAt 5 $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'c')]
fromList *** Exception: Map.deleteAt: index out of range

ghci>Map.deleteAt 1 $ Map.insert "Tom" 98 $ Map.singleton "Jerry" 100
fromList [("Jerry",100)]
{% endhighlight %}

> **deleteMax**

删除 Map 中 key 最大的元素。

{% highlight haskell %}
ghci>:t Map.deleteMax
Map.deleteMax :: Map.Map k a -> Map.Map k a

ghci>Map.deleteMax $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'c')]
fromList [(1,'a'),(2,'b')]

ghci>Map.deleteMax $ Map.fromList [(1, 'a'), (20, 'b'), (3, 'c')]
fromList [(1,'a'),(3,'c')]

ghci>Map.deleteMax $ Map.fromList [("aaa", "aaa"), ("aab", "aab"), ("aac", "aac")]
fromList [("aaa","aaa"),("aab","aab")]

ghci>Map.deleteMax $ Map.fromList [("aaa", "aaa"), ("z", "aab"), ("aac", "aac")]
fromList [("aaa","aaa"),("aac","aac")]
{% endhighlight %}

> **deleteMin**

删除 Map 中 key 最小的元素。

{% highlight haskell %}
ghci>:t Map.deleteMin
Map.deleteMin :: Map.Map k a -> Map.Map k a

ghci>Map.deleteMin  $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'c')]
fromList [(2,'b'),(3,'c')]

ghci>Map.deleteMin  $ Map.fromList [(1, 'a'), (-2, 'b'), (3, 'c')]
fromList [(1,'a'),(3,'c')]

ghci>Map.deleteMin $ Map.fromList [("aaa", "aaa"), ("aab", "aab"), ("aac", "aac")]
fromList [("aab","aab"),("aac","aac")]

ghci>Map.deleteMin $ Map.fromList [("A", "aaa"), ("aab", "aab"), ("aac", "aac")]
fromList [("aab","aab"),("aac","aac")]
{% endhighlight %}

> **deleteFindMax**

找出 Map 中最大的 key 对应的元素并从原 Map 中删除，返回最大 key 元素与剩下的 Map 组成的元组。

{% highlight haskell %}
ghci>:t Map.deleteFindMax
Map.deleteFindMax :: Map.Map k a -> ((k, a), Map.Map k a)

ghci>Map.deleteFindMax $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'c')]
((3,'c'),fromList [(1,'a'),(2,'b')])

ghci>Map.deleteFindMax $ Map.fromList [("aaa", "aaa"), ("aab", "aab"), ("aac", "aac")]
(("aac","aac"),fromList [("aaa","aaa"),("aab","aab")])
{% endhighlight %}


> **deleteFindMin**

找出 Map 中最小的 key 对应的元素并从原 Map 中删除，返回最大 key 元素与剩下的 Map 组成的元组。

{% highlight haskell %}
ghci>:t Map.deleteFindMin
Map.deleteFindMin :: Map.Map k a -> ((k, a), Map.Map k a)

ghci>Map.deleteFindMin $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'c')]
((1,'a'),fromList [(2,'b'),(3,'c')])

ghci>Map.deleteFindMin $ Map.fromList [("aaa", "aaa"), ("aab", "aab"), ("aac", "aac")]
(("aaa","aaa"),fromList [("aab","aab"),("aac","aac")])
{% endhighlight %}

> **findIndex**

找出 Map 中给定 key 处元素的下标。

{% highlight haskell %}
ghci>:t Map.findIndex
Map.findIndex :: Ord k => k -> Map.Map k a -> Int

ghci>Map.findIndex "Tom" $ Map.fromList [("Tom", "Beijing"), ("Jerry", "Shanghai"), ("Dom", "Shenzhen")]
2

let test = Map.fromList [("Tom", "Beijing"), ("Jerry", "Shanghai"), ("Dom", "Shenzhen")]
ghci>Map.deleteAt (Map.findIndex "Tom" test) test
fromList [("Dom","Shenzhen"),("Jerry","Shanghai")]
{% endhighlight %}

> **findMax**

找出 Map 中最大 key 处的元素。

{% highlight haskell %}
ghci>:t Map.findMax
Map.findMax :: Map.Map k a -> (k, a)

ghci>Map.findMax test
("Tom","Beijing")

ghci>Map.findMax $ Map.fromList [(1, 2), (10, 20), (100, 200)]
(100,200)

ghci>Map.findMax $ Map.empty
*** Exception: Map.findMax: empty map has no maximal element
{% endhighlight %}

> **findMin**

找出 Map 中最小 key 处的元素。

{% highlight haskell %}
ghci>:t Map.findMin
Map.findMin :: Map.Map k a -> (k, a)

ghci>Map.findMin test
("Dom","Shenzhen")

ghci>Map.findMin $ Map.fromList [(1, 2), (10, 20), (100, 200)]
(1,2)

ghci>Map.findMin $ Map.fromList []
*** Exception: Map.findMin: empty map has no minimal element
{% endhighlight %}

> **findWithDefault**

返回 Map 中给定 key 处的元素，如果找不到这个 key 就返回一个给定的默认值。

{% highlight haskell %}
ghci>:t Map.findWithDefault
Map.findWithDefault :: Ord k => a -> k -> Map.Map k a -> a

ghci>Map.findWithDefault 100 1 $ Map.fromList [(1, 10), (2, 20), (3, 30)]
10

ghci>Map.findWithDefault 100 0 $ Map.fromList [(1, 10), (2, 20), (3, 30)]
100
-- 没有找到 key 为 0 的元素，所以返回默认值
{% endhighlight %}

> **lookup**

通过一个给定的 key 在 Map 中查找并返回一个 Maybe 值。

{% highlight haskell %}
ghci>:t Map.lookup
Map.lookup :: Ord k => k -> Map.Map k a -> Maybe a

ghci>Map.lookup "Tom" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Just "0001"

ghci>Map.lookup "Lucy" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Nothing

ghci>Map.lookup 1 $ Map.singleton 1 "first"
Just "first"
{% endhighlight %}

> **lookupGE**

在 Map 中查找 *大于等于* 给定 key 的元素，返回一个 Maybe 值。 GE = greater or equal

{% highlight haskell %}
ghci>:t Map.lookupGE
Map.lookupGE :: Ord k => k -> Map.Map k v -> Maybe (k, v)

ghci>let map = Map.fromList [('a', 20), ('b', 30), ('c', 40)]

ghci>Map.lookupGE 'a' map
Just ('a',20)

ghci>Map.lookupGE 'd' map
Nothing

ghci>Map.lookupGE 10 $ Map.fromList [(1, 2), (2, 3), (5, 6), (11, 12)]
Just (11,12)

ghci>Map.lookupGE "T" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Just ("Tom","0001")
{% endhighlight %}

> **lookupGT**

在 Map 中查找 *大于* 给定 key 的元素，返回一个 Maybe 值。 GE = greater than

{% highlight haskell %}
ghci>:t Map.lookupGT
Map.lookupGT :: Ord k => k -> Map.Map k v -> Maybe (k, v)

ghci>map
fromList [('a',20),('b',30),('c',40)]

ghci>Map.lookupGT 'a' map
Just ('b',30)

ghci>Map.lookupGT 'd' map
Nothing

ghci>Map.lookupGT 10 $ Map.fromList [(1, 2), (2, 3), (5, 6), (11, 12)]
Just (11,12)

ghci>Map.lookupGT "T" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Just ("Tom","0001")

ghci>Map.lookupGT "Tom" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Nothing
{% endhighlight %}

> **lookupLE**

在 Map 中查找 *小于等于* 给定 key 的元素，返回一个 Maybe 值。 GE = less or erual

{% highlight haskell %}
ghci>:t Map.lookupLE
Map.lookupLE :: Ord k => k -> Map.Map k v -> Maybe (k, v)

ghci>map
fromList [('a',20),('b',30),('c',40)]

ghci>Map.lookupLE 'a' map
Just ('a',20)

ghci>Map.lookupLE 'd' map
Just ('c',40)

ghci>Map.lookupLE 10 $ Map.fromList [(1, 2), (2, 3), (5, 6), (11, 12)]
Just (5,6)

ghci>Map.lookupLE "T" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Just ("Mary","0005")

ghci>Map.lookupLE "A" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Nothing
{% endhighlight %}

> **lookupLT**

在 Map 中查找 *小于* 给定 key 的元素，返回一个 Maybe 值。 GE = less than

{% highlight haskell %}
ghci>:t Map.lookupLT
Map.lookupLT :: Ord k => k -> Map.Map k v -> Maybe (k, v)

ghci>map
fromList [('a',20),('b',30),('c',40)]

ghci>Map.lookupLT 'a' map
Nothing

ghci>Map.lookupLT 'd' map
Just ('c',40)

ghci>Map.lookupLT 10 $ Map.fromList [(1, 2), (2, 3), (5, 6), (11, 12)]
Just (5,6)

ghci>Map.lookupLT "Tom" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Just ("Mary","0005")

ghci>Map.lookupLT "A" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Nothing
{% endhighlight %}

> **lookupIndex**

在 Map 中查找给定 key 元素的下标。

{% highlight haskell %}
ghci>:t Map.lookupIndex
Map.lookupIndex :: Ord k => k -> Map.Map k a -> Maybe Int

ghci>map
fromList [('a',20),('b',30),('c',40)]

ghci>Map.lookupIndex 'a' map
Just 0

ghci>Map.lookupIndex 'd' map
Nothing

ghci>Map.lookupIndex "Tom" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
Just 2
{% endhighlight %}

> **member**

判断一个给定的键是否在一个 Map 中，相应的返回一个 Bool 值。

{% highlight haskell %}
ghci>:t Map.member
Map.member :: Ord k => k -> Map.Map k a -> Bool

ghci>Map.member "Lucy" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
False

ghci>Map.member "Tom" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
True
{% endhighlight %}

> **notMember**

同上 😂😂😂😂😂😂

{% highlight haskell %}
ghci>:t Map.notMember
Map.notMember :: Ord k => k -> Map.Map k a -> Bool

ghci>Map.notMember "Lucy" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
True

ghci>Map.notMember "Tom" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
False
{% endhighlight %}

> **map**

与 *Data.List* 中的 **map** 函数一样，不同的是 *Data.Map* 中的 **map** 作用在 Map 上。

{% highlight haskell %}
ghci>:t Map.map
Map.map :: (a -> b) -> Map.Map k a -> Map.Map k b

ghci>Map.map (+1) $ Map.fromList [("Tom", 98), ("Lucy", 89), ("Jerry", 20)]
fromList [("Jerry",21),("Lucy",90),("Tom",99)]

ghci>Map.map (++": Hello!") $ Map.fromList [(1, "Tom"), (2, "Lucy")]
fromList [(1,"Tom: Hello!"),(2,"Lucy: Hello!")]
{% endhighlight %}

> **filter**

不解释了 😎😎😎😎😎😎😎😎 同你想的一样。

{% highlight haskell %}
ghci>:t Map.filter
Map.filter :: (a -> Bool) -> Map.Map k a -> Map.Map k a

ghci>Map.filter (>60) $ Map.fromList [("Tom", 98), ("Lucy", 89), ("Jerry", 20)]
fromList [("Lucy",89),("Tom",98)]

-- 在 testDataMap.hs 中引入 Data.Char
ghci>Map.filter Char.isUpper $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'C')]
fromList [(3,'C')]
{% endhighlight %}

> **toList**

与 **fromList** 函数作用相反。

* Map.fromList:   List -> Map
* Map.toList:   Map -> List

{% highlight haskell %}
ghci>:t Map.toList
Map.toList :: Map.Map k a -> [(k, a)]

ghci>Map.toList $ Map.fromList [(1, 2), (3, 4)]
[(1,2),(3,4)]
{% endhighlight %}

> **keys**

返回一个 Map 中的所有 key 组成的 List 。

{% highlight haskell %}
ghci>:t Map.keys
Map.keys :: Map.Map k a -> [k]

ghci>Map.keys $ Map.fromList [("Tom", 98), ("Lucy", 89), ("Jerry", 20)]
["Jerry","Lucy","Tom"]

ghci>Map.keys $ Map.fromList [("Tom", 98), ("Lucy", 89), ("", 20)]
["","Lucy","Tom"]
{% endhighlight %}

> **elems**

返回一个 Map 中所有 value 组成的 List 。

{% highlight haskell %}
ghci>:t Map.elems
Map.elems :: Map.Map k a -> [a]

ghci>Map.elems 2 $ Map.fromList [("Tom", 98), ("Lucy", 89), ("Jerry", 20)]
[20,89,98]

ghci>Map.elems $ Map.insert 1 "first" $ Map.singleton 2 "second"
["first","second"]
{% endhighlight %}

> **elemAt**

返回一个 Map 中指定下标处的值。

{% highlight haskell %}
ghci>:t Map.elemAt
Map.elemAt :: Int -> Map.Map k a -> (k, a)

ghci>map
fromList [('a',20),('b',30),('c',40)]

ghci>Map.elemAt 0 map
('a',20)

ghci>Map.elemAt 10 map
*** Exception: Map.elemAt: index out of range

ghci>Map.elemAt 1 $ Map.insert 1 "first" $ Map.singleton 2 "second"
(2,"second")

ghci>Map.elemAt 2 $ Map.fromList [("Tom", 98), ("Lucy", 89), ("Jerry", 20)]
("Tom",98)
{% endhighlight %}

> **adjust**

对 Map 中指定 key 处的 value 做函数操作。

{% highlight haskell %}
ghci>:t Map.adjust
Map.adjust :: Ord k => (a -> a) -> k -> Map.Map k a -> Map.Map k a

ghci>Map.adjust (+1) 1 $ Map.fromList [(1, 2), (2, 3)]
fromList [(1,3),(2,3)]
-- 对 key 为 1 的值做 +1 操作

ghci>Map.adjust toUpper 2 $ Map.fromList [(1, 'a'), (2, 'b'), (3, 'c')]
fromList [(1,'a'),(2,'B'),(3,'c')]
{% endhighlight %}

> **fromListWith**

返回一个 *关联列表* 中重复键被函数作用后生成的 Map 。

{% highlight haskell %}
ghci>:t Map.fromListWith
Map.fromListWith
  :: Ord k => (a -> a -> a) -> [(k, a)] -> Map.Map k a

ghci>Map.fromListWith (+) [(1, 3), (2, 4), (1, 5)]
fromList [(1,8),(2,4)]

ghci>Map.fromListWith (+) [(1, 3), (2, 4), (3, 5)]
fromList [(1,3),(2,4),(3,5)]
-- 没有重复键时与 Map.fromList 相同

ghci>Map.fromListWith (\str1 str2 -> str1 ++ " " ++ str2) [(1, "Hello"), (2, "World"), (1, "Haskell")]
fromList [(1,"Haskell Hello"),(2,"World")]

ghci>Map.fromListWith max [("16-Round1", 90), ("17-Round1", 98), ("17-Round1", 88)]
fromList [("16-Round1",90),("17-Round1",98)]
{% endhighlight %}

> **insertWith**

插入键值对到 Map 中并返回对 Map 中重复键函数作用后的 Map 。


{% highlight haskell %}
ghci>:t Map.insertWith
Map.insertWith
  :: Ord k => (a -> a -> a) -> k -> a -> Map.Map k a -> Map.Map k a

ghci>Map.insertWith (+) 1 2 $ Map.singleton 1 3
fromList [(1,5)]

ghci>Map.insertWith (+) 1 2 $ Map.singleton 2 3
fromList [(1,2),(2,3)]
-- 没有重复键时与 Map.insert 一样

ghci>Map.insertWith (\str1 str2 -> str1 ++ "/" ++ str2) "Tom" "2017" $ Map.fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
fromList [("Danny","01853"),("Mary","0005"),("Tom","2017/0001")]
{% endhighlight %}





<h3>自己实现 fromList </h3>
---

在 **testDataMap.hs** 文件中，通过 **empty, insert, foldr** 函数编写自己的 *fromList'* 。

{% highlight haskell %}
-- fromList'
fromList' :: (Ord k) => [(k, v)] -> Map.Map k v
fromList' = foldr (\(k, v) acc -> Map.insert k v acc) Map.empty
-- 不断向一个空的 map 中插入键值对
-- 给 foldr 传入一个匿名函数和空 map
-- 匿名函数向一个容器中插入键值对
-- 容器初始值为空 map
{% endhighlight %}

再次加载 **testDataMap.hs** 文件，来试试它是否像 **fromList** 一样。

{% highlight haskell %}
ghci>:t fromList
fromList         fromList'        fromListWith     fromListWithKey

ghci>:t fromList'
fromList' :: Ord k => [(k, v)] -> Map k v

ghci>fromList' [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
fromList [("Danny","01853"),("Mary","0005"),("Tom","0001")]

ghci>fromList' [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853"), ("Tom", "00345")]
fromList [("Danny","01853"),("Mary","0005"),("Tom","0001")]

ghci>fromList' [(2, "0001"), (80, "0005"), (3, "01853")]
fromList [(2,"0001"),(3,"01853"),(80,"0005")]

ghci>fromList' [(2, "0001"), (80, "0005"), (3, "01853"), (3, "")]
fromList [(2,"0001"),(3,"01853"),(80,"0005")]
{% endhighlight %}
