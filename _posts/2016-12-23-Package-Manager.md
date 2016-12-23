---
layout: post
date: 2016-12-23
title: Cocoapods, Carthage
feature-img: "img/orange.jpg"

---

<h3>一、 关于</h3>
[Cocoapods](https://cocoapods.org/)、 [Carthage](https://github.com/Carthage/Carthage)都是第三方框架管理工具

<h3>二、 如何集成到项目中</h3>
<h5>1. 安装</h5>
[Cocoapods安装方法](https://guides.cocoapods.org/using/getting-started.html#getting-started)、
[Carthage安装方法](https://github.com/Carthage/Carthage#installing-carthage)

<h5>2. 集成到项目</h5>

<em><strong> 1. Cocoapods </strong></em>

* 创建一个名为Podfile的空文件，推荐直接使用 pod init
{% highlight ruby %}
pod init 或者 touch Podfile
// pod init 会为我们做好一些初始设置
{% endhighlight %}

* 查找你想要集成的库

`pod search Alamofire`

* 将库添加到Podfile

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/podfile.jpg" alt="packagemanager_podfile"/>

* `pod install`

`pod install`会将第三方库集成并生成.xcworkspace文件

<em><strong> 2. Carthage </strong></em>

* 创建`cartfile`

`touch cartfile`

* 添加想要集成的库到`cartfile`

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/cartfile.jpg" alt="packagemanager_cartfile"/>

* 执行`carthage update` 或者 `carthage update --platform iOS`
* 将生成的.framework文件拖到Xcode target

<img class="alignnone size-full wp-image-35" src="http://ogkg37m8j.bkt.clouddn.com/image/packagemanager/carthageInXcode.jpg" alt="packagemanager_carthageInXcode"/>

<h3>三、 如果不想用了怎么卸载？</h3>
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

*  Cocoapods 将第三方库以target的形式添加到Pods project，而Pods project在编译时生成libPods.a的静态库供母工程使用。
*  Carthage 依靠xcodebuild 将第三方库build成.framework

[更多Cocoapods原理](https://www.objccn.io/issue-6-4/)
