//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// fibonacci
func fibonacci(n: Int) -> Int {
    if n == 0 {
        fatalError("0 is not a positive integer")
    } else if n == 1 || n == 2 {
        return 1
    } else {
        return fibonacci(n: n - 1) + fibonacci(n: n - 2)
    }
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

// fibonacci'

//func fibonacciArray(n: Int) -> [Int] {
//    let pattern1 = [1]
//    let pattern2 = [1, 1]
//    
//    switch n {
//    case 0:
//        fatalError("0 is not a positive integer")
//    case 1:
//        return pattern1
//    case 2:
//        return pattern2
//    default:
//        var fib1 = fibonacciArray(n: n - 1)
//        fib1.remove(at: 0)
//        
//        var fib2 = fibonacciArray(n: n - 2)
//        fib2.remove(at: 0)
//        let fib = zip(fib1, fib2)
//        let result = Array(fib)
//        
//        
//        return
//    }
//}

