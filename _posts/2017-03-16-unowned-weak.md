---
layout: post
date: 2017-03-16
title: unowned 与 weak
img: "blue.jpg"
---

如何更好的避免循环引用？

### 什么是循环引用？
---

简单说就是A牵着B，B也牵着A，谁也没法自动释放，举个例子：

{% highlight swift %}
class Person {
    let teddy: Dog
    init() {
        teddy = Dog()
        teddy.master = self
    }
    deinit {
        print("person deinit")
    }
}

class Dog {
    var master: Person?
    deinit {
        print("dog deinit")
    }
}

var xiaoming: Person? = Person()
xiaoming = nil
// nothing...
{% endhighlight %}

初始化某人时，设置了一条狗给他，并且这条狗的主人就是他，这就导致 A拥有B， B也拥有A，造成循环引用，所以即使你手动将 *xiaoming* 置为 **nil** 但是 *Dog* 类里面的 *master* 对象仍然牵引着 *xiaoming* 这个对象，而 *xiaoming* 的 *teddy* 属性又牵引着 *Dog*，所以无论如何他们永远不会释放了！除非杀死进程。
![](http://ogkg37m8j.bkt.clouddn.com/image/swift/unowned-weak/unowned_vs_weak_01.jpg)

### 避免循环引用
---

> ## weak

上面举的例子中由于两个对象之间互相强引用，造成循环引用导致内存无法释放，那么如何避免呢？

{% highlight swift %}
class Dog {
    weak var master: Person?
    deinit {
        print("dog deinit")
    }
}
{% endhighlight %}

不要让他们互相强引用，自然就解决了这一问题。

{% highlight swift %}
var xiaoming: Person? = Person()
xiaoming = nil

// person deinit
// dog deinit
{% endhighlight %}

当将 *xiaoming* 置为 **nil** 时，*xiaoming* 所指向的 *Person* 对象仅被 *master* 弱引用，所以 *xiaoming* 所指向的 *Person* 对象释放，*Person* 类 **deinit** 方法被调用。当 *xiaoming* 所指向的 *Person* 对象被释放，*teddy* 所指向的 *Dog* 类对象因为没有被任何对象强引用，引用计数归零，所以 *Dog* 类对象 **deinit** 方法调用。
![](http://ogkg37m8j.bkt.clouddn.com/image/swift/unowned-weak/unowned_vc_weak_02.jpg)

> ## unowned

**weak** 我们已经很熟悉了，因为写 OC 时时时刻刻都在用它，而 **unowned** 是 Swift 中的关键字，将上述例子中 **weak** 改为 **unowned** 会是什么结果呢？

{% highlight swift %}
class Person {
    var teddy: Dog?
    deinit {
        print("person deinit")
    }
}

class Dog {
    unowned let master: Person
    init(master: Person) {
        self.master = master
    }
    deinit {
        print("dog deinit")
    }
}

var xiaoming: Person? = Person()
xiaoming!.teddy = Dog(master: xiaoming!)

xiaoming = nil

// person deinit
// dog deinit
{% endhighlight %}

对上述例子稍作了一点修改，不难看出 **deinit** 方法被调用的原理与上面使用 **weak** 是一样的，两条强引用中其中一条标记为 **unowned** ，这样打破了循环引用，所以当 *xiaoming* 被置为 **nil** 时，所有变量得以释放。

### unowned 与 weak
---

在开发中一般使用弱引用的地方有两处，一是当持有一个 *delegate* 属性变量时，二是在使用闭包时。那么什么时候用 **unowned**，什么时候用 **weak** 呢？

* **unowned**: 首先表达了一种非拥有关系（nonowning relationship， unretained）其次当它标记的对象被销毁时，属性值不会自动清空。
* **weak**: 同样表达非拥有关系，但不同的时当目标对象被销毁时，属性值会自动清空。

![](http://ogkg37m8j.bkt.clouddn.com/image/swift/unowned-weak/unowned_vs_weak_03.jpg)


当确定变量被访问时不会被释放则用 **unowned** 如果有被释放的可能就用 **weak**。在闭包中使用 **unowned** 或 **weak** 需要放在方括号中，可以同时使用多种标记。

{% highlight swift %}
lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}
{% endhighlight %}

还有一点当使用 **weak** 时我们一般会做个判断，因为 **weak** 标记的变量一定是 **Optional** 值。

{% highlight swift %}
lazy var someClosure: (Int, String) -> String = {
    [weak self] in
    if let strongSelf = self {
      // ...
    }
}
{% endhighlight %}


> **An unowned reference is expected to always have a value. As a result, ARC never sets an unowned reference’s value to nil, which means that unowned references are defined using nonoptional types.**


> **Use an unowned reference only when you are sure that the reference always refers to an instance that has not been deallocated.
If you try to access the value of an unowned reference after that instance has been deallocated, you’ll get a runtime error.**

> **Define a capture in a closure as an unowned reference when the closure and the instance it captures will always refer to each other, and will always be deallocated at the same time.
Conversely, define a capture as a weak reference when the captured reference may become nil at some point in the future. Weak references are always of an optional type, and automatically become nil when the instance they reference is deallocated. This enables you to check for their existence within the closure’s body.**

[sample code](https://github.com/redtwowolf/redtwowolf.github.io/tree/master/_code/Swift/)

[官方文档](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html)
