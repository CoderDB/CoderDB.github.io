//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var op: String?
op = "Hello"
print(op)
var opt: Optional<String>? = "hi"
print(opt)

var anotherOp: String! = "anotherOp"
print(anotherOp)



var array = ["Swift", "Objective-C", "C", "Java"]

if let idx = array.index(of: "Swift"), idx == array.startIndex {
    print("The first element in array is Swift")
}

if let idx = array.index(of: "Swift") {
    if idx == array.startIndex {
        print("The first element in array is Swift")
    }
}

//
let source = "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"
if let url = URL(string: source),
    let data = try? Data(contentsOf: url),
    let image = UIImage(data: data) {
    print("Get image successed")
}


if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}



class Person {
    var address: Address?
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingNumber != nil && street != nil {
            return street! + " No.\(buildingNumber!)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}
let sh = Person()
let address = Address()
address.buildingName = "开瓶器"
address.buildingNumber = "100"
address.street = "China Shanghai Pudong Avenue Century"
sh.address = address

if let beginsWithThe = sh.address?.buildingIdentifier()?.hasPrefix("China") {
    if beginsWithThe {
        print("SH's building identifier begins with \"China\".")
    } else {
        print("SH's building identifier does not begin with \"China\".")
    }
}

print(sh.address!.buildingName)


// while let

var languages = ["Swift", "Objective-C", nil, nil]
//while let lang = languages.popLast() {
//    print(lang)
//}

//while let lang = languages.popLast(), !lang.isEmpty {
//    print(lang)
//}
var iterator = languages.makeIterator()
//while let i = iterator.next() {
//    print("element: \(i)")
//}
//
//for element in languages {
//    print("element: \(element)")
//}


//while var i = iterator.next() {
//    i! += "haha"
//    print(i)
//}

for case let lan? in languages {
    // lan? 类型现在是 String，而不是String?
    print(lan)
}
for case let .some(lan) in languages {
    print(lan)
}

for case nil in languages {
    print("has nil")
}
for case .none in languages {
    print("has nil")
}






