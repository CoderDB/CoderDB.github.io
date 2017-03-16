---
layout: post
date: 2017-03-16
title: unowned 与 weak
feature-img: "img/blue.jpg"
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

### unowned
---

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

### unowned 与 weak 有什么区别呢？
---
