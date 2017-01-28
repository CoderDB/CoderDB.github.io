---
layout: post
date: 2017-01-28
title: Haskell 中的 Function Composition
feature-img: "img/orange.jpg"
---

$$(f \circ g)(x) = f(g(x))$$
---

数学中 $$(f \circ g)$$ 这样表示将 f g 两个函数复合，Haskell 中的函数组合与数学中的一样，只不过不用 $$ \circ $$ 而是用一个点。举个例子 🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰🌰

{% highlight haskell %}
Prelude> (length.tail) "haskell"
6
{% endhighlight %}
