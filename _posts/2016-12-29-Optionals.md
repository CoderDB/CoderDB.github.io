---
layout: post
date: 2016-12-23
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
当变量 **有值** 时你可以通过解包获得值，负责就是 **nil**。
