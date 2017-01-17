---
layout: post
date: 2016-12-23
title: Cocoapods, Carthage
feature-img: "img/orange.jpg"

---

<h3>一、 关于</h3>
---
<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/cocoapods&carthage.jpg" alt="packagemanager_cocoapods&carthage"/>
[Cocoapods](https://cocoapods.org/)、 [Carthage](https://github.com/Carthage/Carthage)都是第三方框架管理工具

<h3>二、 如何集成到项目中</h3>
---
<h4>1. 安装</h4>
[Cocoapods安装方法](https://guides.cocoapods.org/using/getting-started.html#getting-started)、
[Carthage安装方法](https://github.com/Carthage/Carthage#installing-carthage)

<h4>2. 集成到项目</h4>

<em><strong> 1. Cocoapods </strong></em>

* 创建一个名为Podfile的空文件，推荐直接使用 pod init
{% highlight swift %}
pod init // pod init 会为我们做好一些初始设置
// 或者
touch Podfile // 只创建一个名为Podfile的空文件
{% endhighlight %}

* 查找你想要集成的库
{% highlight swift %}pod search Alamofire{% endhighlight %}

* 将库添加到Podfile

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/podfi.jpg" alt="packagemanager_podfi"/>

* 执行pod install
{% highlight swift %}
pod install // 将第三方库集成并生成.xcworkspace文件。
{% endhighlight %}
到这里就算集成成功了！之后打开.xcworkspace开始coding

<em><strong> 2. Carthage </strong></em>

* 创建`cartfile`
{% highlight swift %}touch cartfile{% endhighlight %}

* 添加想要集成的库到`cartfile`

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/cartfile.jpg" alt="packagemanager_cartfile"/>

* 执行`carthage update` 或者 `carthage update --platform iOS`
{% highlight swift %}
carthage update
carthage update --platform iOS //fetch指定平台的代码
{% endhighlight %}
* 将生成的.framework文件拖到Xcode target

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/carthageInXcode.jpg" alt="packagemanager_carthageInXcode"/>
CMD+B看看是不是编译成功了！

<h3>三、 如果不想用了怎么卸载？</h3>
---
<em><strong> 1. 对于Cocoapods来说稍微有点繁琐 </strong></em>

* 删除Cocoapods生成的文件

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/podfileOrNot.jpg" alt="packagemanager_podfileOrNot"/>

* 删除Xcode项目中Pods相关文件

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/deletePods.jpg" alt="packagemanager_deletePods"/>

<em><strong> 2. 对于Carthage来说就很简单了 </strong></em>

* 删除Carthage生成的文件

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/cartfileOrNot.jpg" alt="packagemanager_cartfileOrNot"/>

* 删除Xcode->Target->Build Phases->Link Binary With Libraries中对应的framework
* 删除Xcode->Target->Build Settings->Framework Search Paths

<h3>四、 原理</h3>
---

*  Cocoapods 将第三方库以target的形式添加到 *Pods project*，而 *Pods project* 在编译时生成 *libPods.a* 的静态库供母工程使用。
*  Carthage 依靠 *xcodebuild* 将第三方库 build 成 *.framework*

[更多Cocoapods原理](https://www.objccn.io/issue-6-4/)
