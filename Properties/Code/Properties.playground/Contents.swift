import UIKit

struct Rectangle {
    var height : Float
    var width : Float
}

let myRect = Rectangle(height: 10, width: 10)


//lazy var importer = 5

struct Square {
    var height: Float
    var width: Float
    var area: Float {
        get {
            return width * height
        }
    }
}

let sqr = Square(height: 20, width: 20)
print (sqr.area)

//struct Person {
//    var isMale:Bool?
//
//    lazy var genderDescription: String = {
//        return "I am an iOS developer"
//    }()
//    lazy var androidResumeDescription: String = {
//        return "I am an android developer"
//    }()
//}

struct Person {
    var age = 16
    
    lazy var doubleAge: Int = {
        return age * 2
    }()
}

var person = Person()
person.doubleAge
