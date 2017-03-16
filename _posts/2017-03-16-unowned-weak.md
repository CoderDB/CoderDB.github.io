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
