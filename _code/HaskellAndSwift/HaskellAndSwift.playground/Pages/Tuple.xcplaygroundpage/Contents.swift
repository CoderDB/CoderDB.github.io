//: [Previous](@previous)
//: ****

import Foundation

// 这就是一个 Tuple
let tuple1 = (5, 8)
print(tuple1)


let hasABS = ("ABS", true)
print(hasABS)

let tom = ("Tom", "Cat", 25)
print(tom)

let tuple4 = (("Jerry", 123), (["Apple"], "Origin"), tom)
print(tuple4)
print(tuple4.2.1)

let tuple5 = (name: "Tom", gender: 1, age: 25)
print(tuple5.gender)
print(tuple5.0)


let tuple6: (Int, Int, Int) = (1, 2, 8)
var tuple7 = (1, 2, 5)
print(tuple6 > tuple7)


let result = [1, 2, 8] > [1, 2, 5]
print(result)
let test1 = [1, 2, 8]
let test2 = [1, 2, 5]
//test1 > test2
let isEqual = test1.elementsEqual(test2)
print(isEqual)

let test3 = [10, 20, 30]
let test4 = [1, 2, 3]
let test3GreaterThanTest4 = test3.elementsEqual(test4, by: >)
print(test3GreaterThanTest4)


let test3GreaterThanTest4TenTimes = test3.elementsEqual(test4) { (a, b) -> Bool in
    return a > b * 10
}
print(test3GreaterThanTest4TenTimes)

// zip
let numbers = [1, 2, 3, 4, 5]
let words = ["one", "two", "three", "four", "five"]
//Zip2Iterator
let zipResult = zip(numbers, words)
print(Array(zipResult))

let zip2 = zip(words, 100...Int.max)
print(Array(zip2))


//: ****
//: [Next](@next)
