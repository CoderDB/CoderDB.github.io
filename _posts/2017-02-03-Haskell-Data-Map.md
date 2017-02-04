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

ghci>Map.elems $ Map.fromList [("Tom", 98), ("Lucy", 89), ("Jerry", 20)]
[20,89,98]

ghci>Map.elems $ Map.insert 1 "first" $ Map.singleton 2 "second"
["first","second"]
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
