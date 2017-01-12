---
layout: post
date: 2017-01-12
title: Haskell And Swift (Typeclass)
feature-img: "img/green.jpg"
---

**Typeclass** 可以理解为 **Swift** 中的 **Protocol** 。

---

在 ghci 下，察看 == 函数的类型
{% highlight haskell %}
ghci>:t (==)
(==) :: Eq a => a -> a -> Bool
{% endhighlight %}
**=>** 是类型约束，表示类型变量 a 属于 Eq 类。这里的 **Eq** 就是 **类型类（Typeclass）** 。

<h3>为什么说可以理解为 Swift 中的 Protocol ，看看下面这个例子就明白了！</h3>
---

之前在写一篇[设计模式](http://localhost:4000/2016/11/25/Design-Pattern.html)相关的文章时，里面有一个关于"会飞的鸭子"的例子。有绿头鸭、红头鸭、橡皮鸭等等各种鸭子，但是有的鸭子会飞，有的不会飞。如果类的设计是所有鸭子继承一个鸭子基类，当有新的鸭子类（比如木头刻的鸭子，既不会飞也不会叫）产生时，子类就需要覆盖众多父类中的方法，为了解决这一问题，程序汪们想出了这样的方法：
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_07.jpg" alt="designpattern_duck_07"/>
**MallardDuck** 与 **RedHeadDuck** 既会叫又会飞，所以它们遵守 **Flyable** 和 **Quickable** 协议，而 **RubberDuck** 只会叫不会飞，所以它遵守 **Quickable** 协议。这里的 **Flyable** 和 **Quickable** 就相当于 **Eq** 。

<h3>Types and Typeclasses</h3>

<!-- **Char、Bool、Int、Integer、Double、Float、List、Tuple** 这些都是 **Type** 。 -->

Types | Typeclasses|
------|---------|
------|---|-----|
Char、Bool、Int、Integer、Double、Float、List、Tuple | Eq: 相等性比较<br> Ord: 比较大小 <br> Num: 数字性 <br> ... |
