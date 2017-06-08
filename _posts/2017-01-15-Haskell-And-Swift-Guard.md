---
layout: post
date: 2017-01-15
title: Haskell And Swift (Guard)
img: "purple.jpg"
---

Guard
---
判断一个值是否为真，如果为真则执行其对应的函数体，否则跳至下一个 **guard** 。跟模式匹配、if、switch语句都很类似。

guard 有自己的形式
---
**guard** 用 **|** 来表示。

通过一个不满18岁看电影的例子来认识 **guard** 。在 **test.hs** 中声明一个名为 *watchMovie* 的函数，它需要一个整型的参数来作为年龄，返回一个这个年龄该干的事儿。🤡🤡🤡🤡🤡🤡🤡🤡
{% highlight haskell %}
watchMovie :: (Integral a) => a -> String
watchMovie age
    | age <= 10 = "You should play niba with your friends."
    | age <= 18 = "You should try to date girls."
    | age <= 22 = "Watch Movie! Watch Movie! Watch Movie!"
    | age <= 25 = "See Feng Insert Zhen."
    | age <= 30 = "You should try to be a gay."
    | otherwise = "You should try to be a gandie."
{% endhighlight %}

将 **test.hs** 加载到 ghci ，看看你适合干啥。🤠🤠🤠🤠🤠🤠

{% highlight haskell %}
ghci>watchMovie 5
"You should play niba with your friends."

ghci>watchMovie 18
"You should try to date girls."

ghci>watchMovie 20
"Watch Movie! Watch Movie! Watch Movie!"

ghci>watchMovie 24
"See Feng Insert Zhen."

ghci>watchMovie 28
"You should try to be a gay."

ghci>watchMovie 35
"You should try to be a gandie."
{% endhighlight %}

><h3>max'</h3>

用 **guard** 来实现 **max** 函数。
{% highlight haskell %}
max' :: (Ord a) => a -> a -> a
max' x y
    | x > y = x
    | otherwise = y
{% endhighlight %}

在 **test.hs** 中声明一个名为 *max'* 的函数，它需要两个可比较类型的参数，并返回一个同类型的值。

{% highlight haskell %}
ghci>max
max       max'      maxBound  maximum

ghci>max' 10 8
10

ghci>max 10 8
10
{% endhighlight %}

><h3>compare'</h3>

用 **guard** 来实现 **compare** 函数。
{% highlight haskell %}
compare' :: (Ord a) => a -> a -> Ordering
compare' x y
    | x > y     = GT
    | x == y    = EQ
    | otherwise = LT
{% endhighlight %}

再次加载 **test.hs** 之后，测试一下。

{% highlight haskell %}
ghci>compare
compare   compare'

-- compare'
ghci>compare' 10 8
GT
ghci>compare' 0 0
EQ
ghci>compare' 50 100
LT
ghci>10 `compare'` 8
GT

-- compare
ghci>compare 10 8
GT
ghci>compare 0 0
EQ
ghci>10 `compare` 8
GT
{% endhighlight %}

Swift 中的 guard
---

Swift 中的 **guard** 必须和 **else** 一起出现，而且 **else** 语句必须以 **return, break, continue, throw** 四者之一结束。它的形式看起来是这样：
{% highlight swift %}
guard condition else {
    statements
}
{% endhighlight %}
Swift 中的 **guard** 不止可以判定一个 *Bool* 值语句，还可以与可选绑定一起使用。举几个例子看看：
{% highlight swift %}
func input(str: String?) {
    guard str != nil else {
        return
    }
    print("You just input " + "\"" + str! + "\"")
}

input(str: "hello")
// You just input "hello"
{% endhighlight %}

**guard** 判定一个 *Bool* 值的情况大概就是这样，下面举一个 **guard** 与 *可选绑定* 一起使用的例子🌰🌰🌰🌰🌰🌰🌰

{% highlight swift %}
func getImage(urlString: String) {
    guard let url = URL(string: urlString) else {
        print("Get url failed")
        return
    }
    guard let data = try? Data(contentsOf: url) else {
        print("Get data failed")
        return
    }
//    someImgView.image = UIImage(data: data)!
    print("Get image data successed")
}

let source = "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"
getImage(urlString: source)
// Get image data successed
{% endhighlight %}

这个例子讲述的是从远端获取一张图片填到某个 *view* 上。你还可以这样做：

{% highlight swift %}
func getImage(urlString: String) {
    guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
        return
    }
    let _ = UIImage(data: data)!
    print("Get image data successed")
}

let source = "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"
getImage(urlString: source)
// Get image data successed
{% endhighlight %}

前面说了与 **guard** 配合的 **else** 必须以 **return, break, continue, throw** 四者之一结束，那么这里再举一个 **throw** 的例子。

{% highlight swift %}
enum UserInfoError: Error {
    case idInvalid, nameInvalid, phoneNumberInvalid
}

struct User {
    var id:          String
    var name:        String
    var phoneNumber: String

    init(id: String, name: String, phoneNumber: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
    }
}

// 如果一个用户的 id 长为 5，name 在 3～15 之间，phoneNumber 长度为 11 那么这个用户的信息就是合法的
func check(user: User) throws -> String {
    guard user.id.characters.count == 5 else {
        throw UserInfoError.idInvalid
    }
    guard user.name.characters.count > 3 && user.name.characters.count < 15 else {
        throw UserInfoError.nameInvalid
    }
    guard user.phoneNumber.characters.count == 11 else {
        throw UserInfoError.phoneNumberInvalid
    }
    return user.name + " | " + user.id + " | " + user.phoneNumber
}
{% endhighlight %}

判断录入的用户信息是否合法，下面是它的调用。

{% highlight swift %}
// 1.
let user = User(id: "00001", name: "Danny", phoneNumber: "12345678901")
do {
    let result = try check(user: user)
    print(result)
} catch UserInfoError.idInvalid {
    print("id invalid")
} catch UserInfoError.nameInvalid {
    print("name invalid")
} catch UserInfoError.phoneNumberInvalid {
    print("phoneNumber invalid")
}
// Danny | 00001 | 12345678901

// 2.
let user2 = User(id: "00001", name: "Danny", phoneNumber: "")
do {
    let result = try check(user: user2)
    print(result)
} catch UserInfoError.idInvalid {
    print("id invalid")
} catch UserInfoError.nameInvalid {
    print("name invalid")
} catch UserInfoError.phoneNumberInvalid {
    print("phoneNumber invalid")
}
// phoneNumber invalid
{% endhighlight %}

这些文章或许能帮到你
---

[Swift Guard](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Statements.html)
