//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// fibonacci
func fibonacci(n: Int) -> Int {
    guard n > 0 else {
        fatalError("you should input a positive integer.")
    }
    return n < 3 ? 1 : fibonacci(n: n - 1) + fibonacci(n: n - 2)
  
}
//fibonacci(n: 1)
//fibonacci(n: 2)
//fibonacci(n: 3)
//fibonacci(n: 4)
//fibonacci(n: 5)
//fibonacci(n: 10)
//fibonacci(n: 20)
//fibonacci(n: 50)
//fibonacci(n: 0)




// zipWith: [1, 2] [3, 4] = [4, 6]
func zipWith(fst: [Int], snd: [Int]) -> [Int] {
    if fst.isEmpty || snd.isEmpty {
        return []
    }
    return zip(fst, snd).reduce([]) { (res, tup) in
        return res + [tup.0 + tup.1]
    }
}
//zipWith(fst: [1, 2, 3], snd: [5, 6, 7])
//zipWith(fst: [1, 2], snd: [6])

// fibonacci'
func fibonaccis(n: Int) -> [Int] {
    switch n {
    case _ where n <= 0:
        fatalError("you should input a positive integer.")
    case 1:
        return [1]
    case 2:
        return [1, 1]
    default:
        let tail = fibonaccis(n: n - 1).dropFirst()
        return [1, 1] + zipWith(fst: Array(tail), snd: fibonaccis(n: n - 2))
    }
}
//print(fibonaccis(n: 10))



// Tail Recursion

//func fib(n: Int, accrlerator: Int = 0) -> Int {
//    if n < 3 {
//        return 1
//    }
//    return fib(n: n - 1, accrlerator: accrlerator + n) + fib(n: n - 2)
//}
//
//fib(n: 5)
//fib(n: 10)
//fib(n: 20)



