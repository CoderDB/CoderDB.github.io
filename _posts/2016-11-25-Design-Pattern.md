---
layout: post
date: 2016-11-25
title: 设计模式--模拟鸭子
feature-img: "img/green.png"
---



###开始做鸭子
鸭子游戏：游戏中有各种鸭子，游泳的，呱呱叫的。遵循OOP原则，我们对鸭子设一个超类`Duck`
{% highlight swift %}
class Duck {
  func swim() {
    print("swim")
  }
  func quack() {
    print("quack")
  }
}
{% endhighlight swift %}


### 设计原则

找出应用中可能需要变化之处，将它们独立出来

---

<h3>一、从模拟鸭子游戏开始</h3>
什么是模拟鸭子游戏？是指游戏中会出现各种鸭子，一边游泳戏水的，一边呱呱叫的。根据面向对象(OO)原则，设计了一个鸭子的超类（SuperClass），让各种鸭子继承此超类。

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_01.jpg" alt="designpattern_duck_01" width="3680" height="2450" />
<h3>二、现在要让鸭子能飞</h3>
领导们进过一番黑天昏地的讨论之后郑重的决定，为了让竞争对手再无还手之力，我们的鸭子要会飞。这时leader拍着胸脯说没问题，分分钟搞定。
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_02.jpg" alt="designpattern_duck_02" width="3680" height="2450" />
现在看起来就是这样：
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_03.jpg" alt="designpattern_duck_03" width="3680" height="2450" />

好了！一切都OK了！静待Demo day了! but 问题来了！
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_04.jpg" alt="designpattern_duck_04" width="3680" height="2450" />

现在看起来是这样，程序汪该怎么办呢？
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_05.jpg" alt="designpattern_duck_05" width="3680" height="2450" />

于是程序汪想到可以把橡皮鸭类中fly()方法覆盖掉，就好像覆盖quack()的做法一样······
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_06.jpg" alt="designpattern_duck_06" width="3680" height="2450" />
<h3>三、利用协议如何？</h3>
程序汪意识到继承不可取，并且他非常肯定地知道产品猪以后肯定是会随时改变的，每当改变一次有新的鸭子类出现时，他都可能要覆盖quack()和fly()······所以程序汪决定把fly()从超类中取出来，放进一个"Flyable"协议中，这样一来，只有会飞的鸭子才实现这个协议。同样的，可以设计一个“Quackable”协议，因为不是所有的鸭子都会叫。
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_07.jpg" alt="designpattern_duck_07" width="3680" height="2450" />
在Swift中协议可以有默认的实现，Flyable，Quackable已经可以很好的解决上面遇到的问题了（不会再有会飞的橡皮鸭子了）。但如果在会飞的鸭子中，飞行的动作有多种······so想了又想：我们知道Duck类的fly()和quack()会随着鸭子类的不同而改变，所以我们把“变化的”部分从Duck类中分离出来
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_08.jpg" alt="designpattern_duck_08" width="3680" height="2450" />
其实这里隐含着一条“极其不可思议”的设计原则
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_09.jpg" alt="designpattern_duck_09" width="3680" height="2450" />
<em><strong>把会变化的部分“封装”起来，好让其他部分不会受到影响</strong></em>

换句话说

<em><strong>把会变化的部分取出来，以便以后可以轻易的改动或扩充，而不影响不需要变化的部分</strong></em>

如果每次新的需求一来，都会使某方面的代码发生变化，那么可以确定，这部分的代码需要被抽出来。
<h3>四、设计鸭子的行为</h3>
我们想要能够“指定”鸭子的行为到鸭子的实例。比方说，生产一个绿头鸭并指定特定“类型”的飞行行为给它。

利用协议代表每个行为，FlyBehavior，QuackBehavior，而需要这种行为的鸭子类就实现这个协议。从现在开始，鸭子的行为将放在分开的类中，此类专门提供某行为接口的实现（而在Swift中我们几乎不需要这么做，因为协议可以有默认的实现）。这样，鸭子类就不需要知道行为的实现细节。
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_10.jpg" alt="designpattern_duck_10" width="3680" height="2450" />
在新设计中，实际的“实现”不会在鸭子子类中，而是特定的具体行为自己实现。这里又隐含了一条相当牛逼的设计原则：
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_11.jpg" alt="designpattern_duck_11" width="3680" height="2450" />

<em><strong>“针对接口编程”真正的意思是“针对超类型编程”</strong></em>

针对超类型编程，执行时会根据实际情况执行真正的行为。举个🌰：
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/designpattern/designpattern_duck_12.jpg" alt="designpattern_duck_12" width="3680" height="2450" />
