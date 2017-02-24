---
layout: post
date: 2017-02-24
title: UICollectionView 悬停 header 或 footer
feature-img: "img/pink.jpg"
---
iOS9 之后只需要设置一个属性便可实现 UICollectionView 的 section header 或 footer 悬停效果

![](http://ogkg37m8j.bkt.clouddn.com/gif/swift/UICollectionView-hover-header-footer/UICollectionViewHoverHeaderFooter.gif)

像这样的悬停效果在 iOS9 之后只需要设置 layout 属性即可。

{% highlight swift %}
let layout = UICollectionViewFlowLayout()
layout.sectionHeadersPinToVisibleBounds = true
layout.sectionFootersPinToVisibleBounds = true
// ...
{% endhighlight %}

![](http://ogkg37m8j.bkt.clouddn.com/image/swift/UICollectionView-hover-header-footer/UICollectionViewSectionHeaderFooterPin.png)

再也不用像以前一样自定义 layout 写一大堆代码，算个不停了！🤣🤣🤣🤣🤣🤣🤣🤣🤣

上面gif是项目中稍微修改后做的，这里是临时写的一个简单的 [Demo](https://github.com/redtwowolf/redtwowolf.github.io/blob/master/_code/Swift/UICollectionViewHoverHeaderFooter)。
