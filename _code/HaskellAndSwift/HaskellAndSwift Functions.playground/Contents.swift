//: Playground - noun: a place where people can play

import UIKit


func myMax(_ a: Int) -> (Int) -> Int {
    return { (b: Int) -> Int  in
        return a > b ? a : b
    }
}

myMax(10)


let test = myMax(12)
test(10)




//func addThree(_ a: Int) -> (Int) -> (Int) -> Int {
//    return {(b: Int) -> (Int) -> Int in
//        return {(c: Int) -> Int in
//            return a + b + c
//        }
//    }
//}


func addThree(_ a: Int) -> (Int) -> (Int) -> Int {
    return { b in
        return { c in
            return a + b + c
        }
    }
}

addThree(3)(4)(5)

let addTwo = addThree(3)(4)
addTwo(5)



