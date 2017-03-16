//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person {
    let teddy: Dog
    init() {
        teddy = Dog()
        teddy.master = self
    }
    deinit {
        print("person deinit")
    }
}

class Dog {
    weak var master: Person?
    deinit {
        print("dog deinit")
    }
}

var xiaoming: Person? = Person()

xiaoming = nil