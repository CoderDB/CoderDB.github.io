---
layout: post
date: 2016-12-29
title: Optionals
feature-img: "img/pink.jpg"

---

<h2>一、 什么是Optionals?</h2>
---
简单说 **Optionals** 就是具有 **有值** 或 **没有值** 这样两种可能性的值。实际上**Optional**就是表达了这种意思的类型，确切地说**Optional**是这样一个枚举：
{% highlight swift %}
enum Optional<Wrapped> {
  case none
  case some(wrapped)
}
{% endhighlight %}
当变量 **有值** 时你可以通过解包获得值，负责就是 **nil**。初始化一个可选值非常简单：
{% highlight swift %}
var op: String?
{% endhighlight %}

<h2>二、 如何更好地获取Optionals的值</h2>
---
不管怎么样声明变量总之它就是拿来用的，那么要用一个变量就不可避免的要和它的值打交道了！如何更好地获取一个可选变量的值了？

> <h3>1. 强制解包（Forced Unwrapping)</h3>

{% highlight swift %}
var op: String?
op = "Hello"
print(op!)
// Hello
{% endhighlight %}
使用 **!** 对可选值强制解包以获取其值的操作非常简单，但是因为没有检查所以容易造成程序的crash。除非明确知道 **op** 一定是有值的负责另寻他法。

> <h3>2. 可选绑定（Optional Binding)</h3>

{% highlight swift %}
var op: String? = "Hello"
if let opt = op {
  print(opt)
}
// Hello
{% endhighlight %}

使用 **if let** 将可选类型变量的值安全的解包，如果可选类型变量的值为 **nil**， **if let** 后面的内容包不会执行。同一个 **if** 语句中可以绑定多个值：
{% highlight swift %}
var array = ["Swift", "Objective-C", "C", "Java"]
if let idx = array.index(of: "Swift"), idx == array.startIndex {
    print("The first element in array is Swift")
}
// "The first element in array is Swift"
{% endhighlight %}
非常有用，而且后面的绑定值是依赖于前面成功解包的值。等同于：
{% highlight swift %}
if let idx = array.index(of: "Swift") {
    if idx == array.startIndex {
        print("The first element in array is Swift")
    }
}
// "The first element in array is Swift"
{% endhighlight %}
这在获取调用多次且返回可选值的函数时非常好用，举个🌰：
{% highlight swift %}
let source = "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"
if let url = URL(string: source),
    let data = try? Data(contentsOf: url),
    let image = UIImage(data: data) {
    print("Get image successed")
}
// Get image successed
{% endhighlight %}
可以在同一个 **if** 语句中将可选值绑定、布尔语句混合在一起使用：
{% highlight swift %}
if let firstNumber = Int("4"),
    let secondNumber = Int("42"),
    firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// "4 < 42 < 100"
{% endhighlight %}
等同于
{% highlight swift %}
if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// "4 < 42 < 100"
{% endhighlight %}
如果任何一个可选值绑定的结果是 **nil** 或者布尔语句是 **false** 的话，则整个 **if** 语句都是 **false** 。

> <h3>3. 可选链（Optional Chaining）</h3>

可选链的意思就是当可选值有值时，方法肯定会调用，如果没有值则表示方法可能不会调用
{% highlight swift %}
class Person {
    var address: Address?
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingNumber != nil && street != nil {
            return street! + " No.\(buildingNumber!)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}
let sh = Person()
let address = Address()
address.buildingName = "开瓶器"
address.buildingNumber = "100"
address.street = "China Shanghai Pudong Avenue Century"
sh.address = address

if let beginsWithThe = sh.address?.buildingIdentifier()?.hasPrefix("China") {
    if beginsWithThe {
        print("SH's building identifier begins with \"China\".")
    } else {
        print("SH's building identifier does not begin with \"China\".")
    }
}
// SH's building identifier begins with "China".
{% endhighlight %}
调用可选链得到一个返回值时，这个返回值本身也会是可选值
{% highlight swift %}
print(sh.address!.buildingName)
// Optional("开瓶器")
{% endhighlight %}


> <h3>4. 其他</h3>

**while** 语句是先判断的循环结构
{% highlight swift %}
while condition {
    statements
}
{% endhighlight %}
当条件不满足了，则循环终止，否则一直循环。**while let** 也差不多，当条件为 **nil** 时，循环终止。
{% highlight swift %}
var languages = ["Swift", "Objective-C", "C", "Java"]
while let lang = languages.popLast() {
    print(lang)
}
// Java
// C
// Objective-C
// Swift
{% endhighlight %}
**while let** 和 **if let** 一样，也可以和布尔语句混合使用
{% highlight swift %}
var languages = ["Swift", "Objective-C", "C", "Java"]
while let lang = languages.popLast(), !lang.isEmpty {
    print(lang)
}
// Java
// C
// Objective-C
// Swift
{% endhighlight %}
再举个🌰 **OC** 中用 **NSEnumerator** 对数组遍历是很常见的方法
{% highlight swift %}
NSArray *array = @[@"Swift", @"Objective-C", @"C", @"Java"];
NSEnumerator *enumerator = [array objectEnumerator];
id element;
while (element = [enumerator nextObject]) {
	NSLog(@"element: %@", element);
}
// element: Swift
// element: Objective-C
// element: C
// element: Java
{% endhighlight %}
在 **Swift** 中可以用迭代器
{% highlight swift %}
var iterator = languages.makeIterator()
while let i = iterator.next() {
    print("element: \(i)")
}
// element: Swift
// element: Objective-C
// element: C
// element: Java
{% endhighlight %}
从上面几个🌰有没有发现 **while let** 和 **for...in** 很像？
{% highlight swift %}
for element in languages {
    print("element: \(element)")
}
// element: Swift
// element: Objective-C
// element: C
// element: Java
{% endhighlight %}
除了 **let** 还可以用 **var** 搭配 **if, while, for** 。

**case let** 有很多组合使用的方法，**if case let， switch case let， for case let， guard case let** 等，在这里举个🌰：
{% highlight swift %}
var languages = ["Swift", "Objective-C", "C", nil]
{% endhighlight %}
现在数组中有一个 **nil**，如果只对 **非nil** 的值做 **for** 循环，就像这样
{% highlight swift %}
for case let lan? in languages {
    // lan? 类型现在是 String，而不是String?
    print(lan)
}
// Swift
// Objective-C
// C
{% endhighlight %}
奇怪吗？为什么是 **lan?** , 其实 **lan?** 是 **.some(lan)** 的简写,所以上面的循环还可以这样写
{% highlight swift %}
for case let .some(lan) in languages {
    print(lan)
}
// Swift
// Objective-C
// C
{% endhighlight %}
如果只对值是 **nil** 的做循环
{% highlight swift %}
var languages = ["Swift", "Objective-C", nil, nil]
{% endhighlight %}
现在数组中有两个值是nil
{% highlight swift %}
for case nil in languages {
    print("has nil")
}
// has nil
// has nil
{% endhighlight %}
与 **.some(lan)** 对应的有 **.none** ，所以
{% highlight swift %}
for case .none in languages {
    print("has nil")
}
// has nil
// has nil
{% endhighlight %}
<h2>三、 最后</h2>
---
[关于模式匹配的更多内容1](https://oleb.net/blog/2015/09/more-pattern-matching-examples/)

[关于模式匹配的更多内容2](http://swift.gg/2016/06/06/pattern-matching-4/)

[关于Optional Chaining的更多内容](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/OptionalChaining.html#//apple_ref/doc/uid/TP40014097-CH21-ID245)

[关于Optionals的更过内容](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309)

[文中举例Playground](https://github.com/redtwowolf/redtwowolf.github.io/blob/master/_code/Optionals.playground/Contents.swift)
