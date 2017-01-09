//: [Gallery](Gallery) | [List String](List%20String) | [Previous](@previous)
//: ****

//: ## String
import Foundation
let example = String(repeating: "5", count: 10)
print(example)

let example2 = String(repeating: "5, 6, 7 ", count: 3)
print(example2)

let example3 = String(repeating: "[1, 2, 3], ", count: 5)
print(example3)


//: ## Array
let exam = Array(repeatElement(5, count: 8))
print(exam)

let exam2 = Array(repeatElement("abc", count: 3))
print(exam2)

let exam3 = Array(repeating: [10], count: 5)
print(exam3)

let exam4 = Array(repeating: [exam, exam2, exam3], count: 1)
print(exam4)

let exam5 = [Int](repeatElement(5, count: 3))
print(exam5)

let exam6 = Array(1..<10) // [Int](1..<10)
print(exam6)

//: ****
