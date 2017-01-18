//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 watchMovie :: (Integral a) => a -> String
 watchMovie age
 | age <= 10 = "You should play niba with your friends."
 | age <= 18 = "You should try to date girls."
 | age <= 22 = "Watch Movie! Watch Movie! Watch Movie!"
 | age <= 25 = "See Feng Insert Zhen."
 | age <= 30 = "You should try to be a gay."
 | otherwise = "You should try to be a gandie."
 */
func watchMovie(age: Int) -> String {
    
    switch age {
    case 1...10:
        return "You should play niba with your friends."
    case 11...18:
        return "You should try to date girls."
    case 19...22:
        return "Watch Movie! Watch Movie! Watch Movie!"
    case 23...25:
        return "See Feng Insert Zhen."
    case 26...30:
        return "You should try to be a gay."
    default:
        return "You should try to be a gandie."
    }
}

watchMovie(age: 50)

// where
func watchMovieWithWhere(age: Int) -> String {
    
    switch age {
    case 1...10 where age >= 5:
        return "You should play niba with your friends."
    case 11...18:
        return "You should try to date girls."
    case 19...22:
        return "Watch Movie! Watch Movie! Watch Movie!"
    case 23...25:
        return "See Feng Insert Zhen."
    case 26...30:
        return "You should try to be a gay."
    case _ where age >= 31:
        return "You should try to be a gay."
    default:
        return "please re-enter."
    }
}

let sixYears = watchMovieWithWhere(age: 6)
print(sixYears)

let twoYears = watchMovieWithWhere(age: 2)
print(twoYears)

// where + for in
for case let i in 1..<10 where i % 2 == 0{
    print(i)
}

// let in

func optionalStr() -> String? {
    return "haskell"
}

if let opt = optionalStr() {
    print(opt)
}

// fallthrough
func watchMovieWithFallthrough(age: Int) {
    
    switch age {
    case 1...10 where age >= 5:
        print("You should play niba with your friends.")
        fallthrough
    case 11...18:
        print("You should try to date girls.")
    case 19...22:
        print("Watch Movie! Watch Movie! Watch Movie!")
    case 23...25:
        print("See Feng Insert Zhen.")
    case 26...30:
        print("You should try to be a gay.")
    case _ where age >= 31:
        print("You should try to be a gay.")
        fallthrough
    default:
        print("please re-enter.")
    }
}

watchMovieWithFallthrough(age: 8)

watchMovieWithFallthrough(age: 40)


