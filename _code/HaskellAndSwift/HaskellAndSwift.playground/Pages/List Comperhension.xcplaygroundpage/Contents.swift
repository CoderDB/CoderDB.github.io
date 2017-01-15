//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

let aaa: [[Int]] = [[1, 2, 3], [4, 5, 6]]
let bb = [1, 2]

func removeOdd(a: [Int]) -> [Int] {
    var a = a
    for ele in a {
        if ele / 2 == 0 {
            a.remove(at: a.index(of: ele)!)
        }
    }
    return a
}

let evenNumers = removeOdd(a: bb)
evenNumers



//: [Next](@next)
