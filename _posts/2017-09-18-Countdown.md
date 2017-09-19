---
layout: post
date: 2017-09-18
title: 记一次倒计时
img: "Rx.jpg"
---

倒计时有很多种，我只爱你这一种

### 实现效果

![gif](http://ogkg37m8j.bkt.clouddn.com/image/gif/countdown.gif)


电商类app都用一个倒计时来对某些促销商品做限制，怎么实现了？看代码
{% highlight swift %}

import Foundation
import Dispatch

class CountDown {

    static let `default` = CountDown()

    private var timer: DispatchSourceTimer?

    private init() { }

    /**
     start countdown

     seconds = end - now

     * parameter end:       截止时间戳。
     * parameter onMain:    跳至主线程
     * parameter touchZero: 当seconds <= 0时，cancel Timer，跳至主线程
     */
    func start(terminate: Int,
               onMain: @escaping (Int) -> Void,
               touchZero: @escaping () -> Void) {

         timer = DispatchSource.timer(terminate: terminate,
                                      onMain: onMain,
                                      touchZero: touchZero)
    }

    /// stop countdown, cancel timer
    func stop() {
        timer?.cancel()
    }
}

extension DispatchSource {

    public class func timer(terminate: Int,
                            onMain: @escaping (Int) -> Void,
                            touchZero: @escaping () -> Void) -> DispatchSourceTimer {

        let current = Int(Date().timeIntervalSince1970)
        var seconds = terminate - current

        let result = DispatchSource.makeTimerSource(queue: .global())
        result.scheduleRepeating(deadline: .now(),
                                 interval: .seconds(1),
                                 leeway: .microseconds(1))
        result.setEventHandler {
            seconds -= 1
            if seconds >= 0 {
                DispatchQueue.main.async { onMain(seconds) }
            } else {
                DispatchQueue.main.async(execute: touchZero)
            }
        }
        result.resume()
        return result
    }
}

{% endhighlight %}

到这里一个倒计时的类基本封装起来了！当然还可以再写几个方法公开出去以便使用者更加方便参数传递，但是目前这一种就够了！你要倒计时，你只需要告诉我截止的时间戳就好了！其他没你事儿了！不过这里还需再补充一点：对 **Int** 做个extension
{% highlight swift %}
   var days: Int {
       return self / 86400
   }
   var hours: Int {
       return (self % 86400) / 3600
   }
   var minutes: Int {
       return (self % 3600) / 60
   }
   var seconds: Int {
       return (self % 3600) % 60
   }
   /// 123456789 -> 5天10小时33分46秒
   var dhms: String {
       return "\(days)天" + "\(hours)小时" + "\(minutes)分" + "\(seconds)秒"
   }
{% endhighlight %}

下面就看看怎么使用，举个🌰倒计时10秒钟

{% highlight swift %}
// countdown 10 seconds
let terminate = Date(timeIntervalSinceNow: 10).timeIntervalSince1970

CountDown.default.start(terminate: Int(terminate), onMain: { (sec) in
    self.timeLabel.text = "距离地球💥还有" + sec.dhms + "😱😱😱"
}) {
   self.timeLabel.text = "倒计时结束了，怎么没💥💥😿😿😿"
}
{% endhighlight %}
