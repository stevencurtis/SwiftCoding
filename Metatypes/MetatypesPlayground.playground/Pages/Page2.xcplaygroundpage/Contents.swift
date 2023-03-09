//: [Previous](@previous)

import Foundation

class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let person = Person(name: "John", age: 30)
let personType = type(of: person)

for property in Mirror(reflecting: personType).children {
    print("\(property.label!): \(property.value)")
}


//: [Next](@next)
