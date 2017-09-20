---
layout: post
date: 2017-09-19
title: 一篇关于学习运用CoreAnimation的文章
img: "coreanimation.png"
---

### 实现效果

![gif](http://ogkg37m8j.bkt.clouddn.com/image/gif/coreanimation.gif)

### 动画分解

要达到上面的效果，需要实现下面3种不同的动画：

1. 折叠／展开
2. 抖动
3. 按钮文字动画

### 在xib中配置Views

分为三个部分：

    RememberView
          |
          | ------ HeaderView
          |             | ------ Switch
          |             | ------ Text
          | ------ FoldView
          |             | ------ Text
          |             | ------ TextField
          | ------ PayButton

### 折叠／展开

当用户关闭开关时，View折叠，反之展开。实现这一操作需要注意两点：
1. 设置layer的 **isDoubleSided** 为false，否则当layer被transform后仍然会显示，这个属性默认是true
2. 设置锚点为(0.5, 0)，**anchorPoint** 默认值是(0.5, 0.5)，在这里x值不影响，你可以设置0...1之间的任何数，但y值一定要注意，我们是在view的上边线处折叠，所以一定是0.

{% highlight swift %}
foldView.layer.isDoubleSided = false
foldView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
{% endhighlight %}

开关被选择时触发的方法

{% highlight swift %}
  @IBAction func switchValueChanged(_ sender: UISwitch) {

      UIView.animate(withDuration: 0.7,
                     delay: 0,
                     usingSpringWithDamping: 0.7,
                     initialSpringVelocity: 0.2,
                     options: .allowAnimatedContent,
                     animations: {

          self.folding(by: sender.isOn)

      }, completion: nil)
  }
{% endhighlight %}

**folding** 方法做两件事：
1. 对 **foldView.layer** 做3D旋转
2. 计算布局

{% highlight swift %}
func folding(by on: Bool) {
    let angle = on ? 0 : -90
    foldView.layer.transform = CATransform3DMakeRotation(angle.toRadian, 1, 0, 0)
    layout()
}

func layout() {
    foldView.frame = CGRect(x: headerView.frame.origin.x,
                            y: headerView.frame.maxY - headerView.layer.borderWidth,
                            width: headerView.bounds.width,
                            height: 100)

    payBtn.frame.origin.y = foldView.frame.maxY + 10
    frame.size.height = payBtn.frame.maxY + 10
}

{% endhighlight %}

### 抖动

{% highlight swift %}
extension CALayer {
    func shake() {
        let values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]

        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        translation.values = values

        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.y");
        rotation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotation.values = values.map { $0.toRadian }

        let group = CAAnimationGroup()
        group.animations = [translation, rotation]
        group.duration = 0.6
        add(group, forKey: "shakeIt")
    }
}
{% endhighlight %}

### 按钮文字动画

{% highlight swift %}
extension CALayer {
    func addTransition() {
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        transition.duration = 0.5
        add(transition, forKey: kCATransition)
    }
}
{% endhighlight %}

添加动画到button的layer上

{% highlight swift %}
@IBAction func payBtnClicked(_ sender: UIButton) {
    guard let text = phoneTextField.text, !text.isEmpty else {
        layer.shake()
        return
    }
    configPayBtn(.push("Sending", .gray))
    DispatchQueue.mainDelay(1.5) {
        self.configPayBtn(.pop("Sent", .green))
    }
}
{% endhighlight %}


[Demo](https://github.com/redtwowolf/Demos/tree/master/CoreAnimationDemo)
[原文链接](http://merowing.info/2015/12/details-matter---harnessing-the-power-of-coreanimation/)
