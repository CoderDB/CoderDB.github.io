//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



func input(str: String?) {
    guard str != nil else {
        return
    }
    print("You just input " + "\"" + str! + "\"")
}

input(str: "hello")


// Get image successed
func getImage(urlString: String) {
//    guard let url = URL(string: urlString) else {
//        print("Get url failed")
//        return
//    }
//    guard let data = try? Data(contentsOf: url) else {
//        print("Get data failed")
//        return
//    }
//    print("Get image data successed")
//    someImgView.image = UIImage(data: data)!
    
    guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
        return
    }
    let _ = UIImage(data: data)!
    print("Get image data successed")
    
}
let source = "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"
getImage(urlString: source)


// guard throw
enum UserInfoError: Error {
    case idInvalid, nameInvalid, phoneNumberInvalid
}

struct User {
    var id: String
    var name: String
    var phoneNumber: String
    
    init(id: String, name: String, phoneNumber: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
    }
}

func check(user: User) throws -> String {
    guard user.id.characters.count == 5 else {
        throw UserInfoError.idInvalid
    }
    guard user.name.characters.count > 3 && user.name.characters.count < 15 else {
        throw UserInfoError.nameInvalid
    }
    guard user.phoneNumber.characters.count == 11 else {
        throw UserInfoError.phoneNumberInvalid
    }
    return user.name + " | " + user.id + " | " + user.phoneNumber
}

let user = User(id: "00001", name: "Danny", phoneNumber: "12345678901")
do {
    let result = try check(user: user)
    print(result)
} catch UserInfoError.idInvalid {
    print("id invalid")
} catch UserInfoError.nameInvalid {
    print("name invalid")
} catch UserInfoError.phoneNumberInvalid {
    print("phoneNumber invalid")
}

let user2 = User(id: "00001", name: "Danny", phoneNumber: "")
do {
    let result = try check(user: user2)
    print(result)
} catch UserInfoError.idInvalid {
    print("id invalid")
} catch UserInfoError.nameInvalid {
    print("name invalid")
} catch UserInfoError.phoneNumberInvalid {
    print("phoneNumber invalid")
}


// TODO guard case 
//enum InitUser {
//    case success(String, String)
//    case failed
//}
//
//func signIn(user: InitUser) {
//    guard case let InitUser.success(name, id) = user else {
//        return
//    }
//    print(name)
//}
//
//signIn(user: InitUser(user))
//
//
//
//



// TODO:
//func isInvalidName(_ name: String) -> Bool {
//    let pattern = "^[A-Za-z]+$" //由26个英文字母组成的字符串
//    do {
//        let regax = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
//        let result = regax.matches(in: name, options: .anchored, range: NSRange(location: 0, length: name.characters.count))
//        
//    } catch let err {
//        print(err)
//    }
//}
