//: [Previous](@previous) | [Next](@next)
//: ****
//: ## 在Swift中以String的形式和Haskell中的List做比较

import Foundation
let haskell = "Haskell"
print(haskell)
//: ## head
let head = haskell[haskell.startIndex]
print(head)
//: ## tail
let secondIdx = haskell.index(after: haskell.startIndex)
let range = Range(uncheckedBounds: (lower: secondIdx, upper: haskell.endIndex))
let tail = haskell.substring(with: range)
print(tail)
////: 当然你还可以使用其他方法
//: ## last
let last = haskell.characters.last
print(last)
//: ## init
let `init` = haskell.substring(with: range)
print(`init`)
//: 因为 init 在 Swift 中是关键字，所以需要用 ` 来包裹。一般不建议这么做

//: ## length
let length = haskell.characters.count
//let length = haskell.lengthOfBytes(using: String.Encoding.utf8)
print(length)
//: ## null
let null = haskell.isEmpty
print(null)
//: ## reverse
let reverseCharacterView = haskell.characters.reversed()
let reverse = String(reverseCharacterView)
print(reverse)
//: ## maximum
let maximum = haskell.characters.max()
print(maximum)
//: ## mimimum
let minimum = haskell.characters.min()
print(minimum)
/*:
- callout(🗣):
    - sum
    - product
 
 将以 Array 的形式展现 [List Array](List%20Array)
*/
//: ## take n
let take5 = haskell.substring(to: haskell.index(haskell.startIndex, offsetBy: 5))
// let anotherTake5 = haskell.characters.dropLast(haskell.characters.count - 5)
// String(anotherTake5)
print(take5)
//: ## drop n
let drop3CharacterView = haskell.characters.dropFirst(3)
let drop3 = String(drop3CharacterView)
print(drop3)

//: ## elem x
let elem = haskell.contains("a")
print(elem)

//: ****
//: [Previous](@previous) | [Next](@next)


