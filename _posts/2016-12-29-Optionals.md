---
layout: post
date: 2016-12-29
title: Optionals
feature-img: "img/pink.jpg"

---

<h3>一、 什么是Optionals?</h3>
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

<h3>二、 更好地获取Optionals的值</h3>
---
1. 强制解包（Forced Unwrapping)
{% highlight swift %}
var op: String? = "Hello"
print(op!) // "Hello"
{% endhighlight %}
使用 **!** 对可选值强制解包以获取其值的操作非常简单，但是因为没有检查所以容易造成程序的crash。除非明确知道 **op** 一定是有值的。

2. 可选绑定（Optional Binding）
{% highlight swift %}
var op: String? = "Hello"
if let opt = op {
  print(opt) // "Hello"
}
{% endhighlight %}
使用 **if let** 将可选类型变量的值安全的解包，如果可选类型变量的值为 **nil**， **if let** 后面的内容包不会执行。同一个 **if** 语句中可以绑定多个值：
{% highlight swift %}
var array = ["Swift", "Objective-C", "C", "Java"]
if let idx = array.index(of: "Swift"), idx == array.startIndex {
    print("The first element in array is Swift")
}
{% endhighlight %}
非常有用，而且后面的绑定值是依赖于前面成功解包的值。等同于：
{% highlight swift %}
if let idx = array.index(of: "Swift") {
    if idx == array.startIndex {
        print("The first element in array is Swift")
    }
}
{% endhighlight %}
这在获取调用多次且返回可选值的函数时非常好用，举个🌰：
{% highlight swift %}
let source = "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"
if let url = URL(string: source),
    let data = try? Data(contentsOf: url),
    let image = UIImage(data: data) {
    print("Get image successed") //Get image successed
}
{% endhighlight %}
