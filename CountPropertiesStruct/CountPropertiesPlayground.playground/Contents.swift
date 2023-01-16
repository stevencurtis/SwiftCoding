import UIKit

enum Species {
    case dog
    case cat
}

struct Animal {
    var name: String
    var species: String
    var owner: String
    var test: String?
}

var derek = Animal(name: "Derek", species: "Dog", owner: "Kim")
var mirror = Mirror(reflecting: derek)
print (mirror)
// "Mirror for Animal"
print (mirror.children.map{ $0.label })
// [Optional("name"), Optional("species"), Optional("owner")]
print (mirror.children.map{ $0.value })
// ["Derek", "Dog", "Kim"]
print (mirror.children.count)
// 3

class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

var ahmed = Person(name: "Ahmed", age: 21)
print (mirror.children.count)

