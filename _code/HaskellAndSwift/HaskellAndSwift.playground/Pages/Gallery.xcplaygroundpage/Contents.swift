//: [Next](@next) | [List Array](List%20Array) | [List Range](List%20range)
//: ****
import UIKit

var str = "Hello, playground"

// List

var letters = ["a", "b", "c"]
print(letters)
var strs = [["a"], ["b"], ["c"]]
print(strs)


// ++

let helloWorld = "hello" + " " + "world" + " " + "!"
print(helloWorld)

let numbers = [1, 2, 3, 4] + [10, 9, 8, 7, 5]
print(numbers)

let haskell = ["h", "a", "s"] + ["k", "e", "l", "l"]
print(haskell)

letters.append("d")
print(letters)

let abcd = "abc".appending("d")
print(abcd)

let anyArray: [Any] = [1, "2", 20, "haha"]
print(anyArray)

// :
var anotherHaskell = "askell"
anotherHaskell.insert("h", at: anotherHaskell.startIndex)
print(anotherHaskell)
anotherHaskell.insert(contentsOf: ["h", "i", " "], at: anotherHaskell.startIndex)
print(anotherHaskell)

var anotherNumbers = [1, 2, 3]
anotherNumbers.insert(5, at: anotherNumbers.startIndex)
print(anotherNumbers)
anotherNumbers.insert(contentsOf: [5, 10], at: anotherNumbers.startIndex)
print(anotherNumbers)


infix operator ♣︎
extension Int {
    static func ♣︎(left: Int, right: [Int]) -> [Int]  {
        return [left] + right
    }
}
let testNums = 5 ♣︎ [1, 2, 3]
print(testNums)

// !!
let haskellStr = "Haskell"
let firstIdx = haskellStr.startIndex
print(haskellStr[firstIdx])

let fifthIdx = haskellStr.index(firstIdx, offsetBy: 5)
print(haskellStr[fifthIdx])

//: ****
//: [Next](@next) | [List Array](List%20Array) | [List Range](List%20range)

