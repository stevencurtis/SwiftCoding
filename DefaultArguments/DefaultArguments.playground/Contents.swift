import UIKit

//func sayHelloWorld(name: String, message: String) {
//    print (name + " " + message)
//}

func sayHelloWorld(name: String, message: String = "Hello, World") {
    print (name + " " + message)
}

sayHelloWorld(name: "Kyrone", message: "Hello, World")
sayHelloWorld(name: "Tarik", message: "Hello, to you too!")

class Person {
    var name: String
    var age: Int
    init(name: String, age: Int = 21) {
        self.name = name
        self.age = age
    }
}

let chau = Person(name: "Chau")
print (chau.name)
print (chau.age)
