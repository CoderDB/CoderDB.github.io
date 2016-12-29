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
var anotherOp: String! //这两者声明的都是可选类型值，区别是前者是显示，后者是隐示
{% endhighlight %}

<h2>二、 更好地获取Optionals的值</h2>
---

<h3>1. 强制解包（Forced Unwrapping)</h3>
{% highlight swift %}
var op: String? = "Hello"
print(op!)
// Hello
{% endhighlight %}
使用 **!** 对可选值强制解包以获取其值的操作非常简单，但是因为没有检查所以容易造成程序的crash。除非明确知道 **op** 一定是有值的。

<h3>2. 可选绑定（Optional Binding)</h3>
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
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
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


<h2>三、 While Let</h2>
---
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
