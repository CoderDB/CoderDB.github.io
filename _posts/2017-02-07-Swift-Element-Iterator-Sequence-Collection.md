---
layout: post
date: 2017-02-07
title: Swift -- Element, Iterator, Sequence, Collection
feature-img: "img/blue.jpg"
---

是谁在背后默默支持你？
---

在开发中很多时间都是和数据结构打交道，比如从服务端请求一个用户的信息，那么使用这组返回的数据时经常会用到 **Array, Dictionary** 或者 **Set** ，虽然我们对这些封装好的数据结构使用起来已经如鱼得水，但是它们背后到底是怎样的呢？🤔🤔🤔

**一张图看透它们** 🤘🤘🤘🤘🤘🤘🤘🤘🤘🤘🤘

![](http://ogkg37m8j.bkt.clouddn.com/image/swift/element-iterator-sequence-collection/summery.jpg)

这张图说明了在背后默默支持它们的 *那些人* 。下面从底层向上一一认识这些不说话只办事的 *人* 。


Element
---
---

最基本的元素。**Int, Double, String** 都可以是 **Element** ，他不关心自己是谁或者是什么类型，就像不关心你是男人还是女人，反正都是人。像泛型一样或者说这个泛型叫 **Element** 这个名字。

Iterator
---
---

迭代器，它知道如何产生一个值。它遵从 **IteratorProtocol** 协议，而 **IteratorProtocol** 协议唯一的方法是 **next()** ，迭代序列时 **next** 方法返回序列中的一个值，当序列迭代完结时 **next** 返回 **nil** 。

{% highlight swift %}
public protocol IteratorProtocol {
    associatedtype Element
    public mutating func next() -> Self.Element?
}
{% endhighlight %}

这就是 **IteratorProtocol** 的定义，一个 **next()** 方法，一个关联类型 **Element** 。当 **IteratorProtocol** 协议被实现时，**Element** 会确定为实际的类型，像是类型占位，不过我更倾向于理解为类型变量。要实现 **IteratorProtocol** 协议还需实现 **associatedtype** 指定的 **Element** ，举个例子：

{% highlight swift %}
struct SomeStruct: IteratorProtocol {
    typealias Element = Int
    mutating func next() -> Int? {
        // ...
    }
}
{% endhighlight %}

像这个例子中 **Element** 就是 **Int** 。有必要说明一下 **associatedtype** 关键字，我更倾向于把它理解为类型变量的声明符号。怎么说？**associatedtype** 声明一个 **Element** 类型变量，当协议被实现时，给类型变量赋值，这样一来 **associatedtype** 就像 **var** 一样了！比如：

{% highlight swift %}
protocol SomeProtocol {
    associatedtype Element: IteratorProtocol // 这看起来就和声明变量一样一样的...
    // some functions ...
}
{% endhighlight %}

声明了类型变量 **Element** 且遵守 **IteratorProtocol** 协议。

有了 **Iterator** 就可以产生新的值。比如产生无限常数就像这样：

{% highlight swift %}
struct ConstantIterator: IteratorProtocol {
    typealias Element = Int
    mutating func next() -> Int? {
        return 1
    }
}

var cons = ConstantIterator()
while let c = cons.next() {
    print(c)
}
// 1
// 1
// ...
{% endhighlight %}

Sequence
---
---

序列，就是一堆相同类型的值的集合。

{% highlight swift %}
public protocol Sequence {
    associatedtype Iterator : IteratorProtocol
    public func makeIterator() -> Self.Iterator
    // ...
}
{% endhighlight %}

由此可见，序列是构建在迭代器之上的。要实现 **Sequence** 协议，只需要提供一个返回 **Iterator** 的 **makeIterator** 方法。

{% highlight swift %}
struct ConstantSequence: Sequence {
    func makeIterator() -> ConstantIterator {
        return ConstantIterator()
    }
}
{% endhighlight %}

在序列中迭代最常见的就是 for 循环了！

{% highlight swift %}
for ele in ConstantSequence() {
    print(ele)
}
// 1
// 1
// ...
{% endhighlight %}

Collection
---
---

集合，建立在序列之上，所以 **Collection** 具备 **Sequence** 的所有能力，不同的是 **Collection** 除了遍历获得元素外还可以通过下标索引到元素。要实现 **Collection** 协议需要很多准备很多方法，但是 **Collection** 本身有很多默认的实现，在这个基础上实现 **Collection** 协议就轻松多了！

{% highlight swift %}
// 创建一个队列协议，实现该协议时需要指定类型，以及入队、出队方法
protocol QueueType {
    associatedtype Element

    mutating func enqueue(newElement: Element)
    mutating func dequeue() -> Element?
}

// 实现 QueueType 协议时指定了一个泛型的类型
struct Queue<Element>: QueueType {
    var left: [Element]
    var right: [Element]

    init() {
        left = []
        right = []
    }

    // 实现 QueueType 协议
    mutating func enqueue(newElement element: Element) {
        right.append(element)
    }

    mutating func dequeue() -> Element? {
        guard !(left.isEmpty && right.isEmpty) else { return nil }
        if left.isEmpty {
            left = right.reversed()
            right.removeAll(keepingCapacity: true)
        }
        return left.removeLast()
    }
}
{% endhighlight %}

实现 **Collection** 协议

{% highlight swift %}
extension Queue: Collection {

    // 实现 Collection 协议
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count }

    // 返回指定索引处之后的索引值
    public func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }
    // 返回指定下标处的元素
    public subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position), "Index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        } else {
            return right[position - left.count]
        }
    }
}
{% endhighlight %}

现在看看是不是可以工作呢？

{% highlight swift %}
var queue = Queue<Int>()
for x in 1..<5 {
    queue.enqueue(newElement: x)
}
print(queue)
// Queue<Int>(left: [], right: [1, 2, 3, 4])

queue.startIndex
// 0

queue.endIndex
// 4

queue[2]
// 3

let queue1 = queue.map { $0 + 1 }
print(queue1)
// [2, 3, 4, 5]
{% endhighlight %}
