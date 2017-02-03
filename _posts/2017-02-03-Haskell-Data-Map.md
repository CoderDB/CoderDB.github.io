---
layout: post
date: 2017-02-03
title: Haskell -- Data.Map
feature-img: "img/bluepurple.jpg"
---

[key, value]

关联列表（字典）。创建一个 **testDataMap.hs** 文件，在文件中引入 Data.Map 模组，

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

取一个关联列表，返回一个去掉重复键并排序后的关联列表。

{% highlight haskell %}
ghci>:t fromList
fromList :: Ord k => [(k, a)] -> Map k a
-- 键必须是可排序的

ghci>fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
fromList [("Danny","01853"),("Mary","0005"),("Tom","0001")]
-- 以键排序

ghci>fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853"), ("Tom", "00345")]
fromList [("Danny","01853"),("Mary","0005"),("Tom","00345")]
-- 去掉重复键，或者说键必须唯一，或者说同一键的值被覆盖

ghci>fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853"), ("Tom", "00345"), ("Tom", "98742")]
fromList [("Danny","01853"),("Mary","0005"),("Tom","98742")]

ghci>fromList [(2, "0001"), (80, "0005"), (3, "01853")]
fromList [(2,"0001"),(3,"01853"),(80,"0005")]

ghci>fromList [(2, "0001"), (80, "0005"), (3, "01853"), (3, "")]
fromList [(2,"0001"),(3,""),(80,"0005")]
{% endhighlight %}

> **insert**

给一个 map 插入键值对并返回新的 map

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

ghci>let userInfo = fromList [("Tom", "0001"), ("Mary", "0005"), ("Danny", "01853")]
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
