//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class Person {
    var teddy: Dog?
    deinit {
        print("person deinit")
    }
}

class Dog {
    unowned let master: Person
    init(master: Person) {
        self.master = master
    }
    deinit {
        print("dog deinit")
    }
}

var xiaoming: Person? = Person()
xiaoming!.teddy = Dog(master: xiaoming!)

xiaoming = nil
