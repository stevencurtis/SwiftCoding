import UIKit

struct Person {
    let name: String
}

let me = Person.init(name: "Dave") // my name isn't Dave
let you = Person(name: "Dave") // applies if your name is Dave

print (me, you)

class Dog {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let myDog = Dog.init(name: "DaveDog") // I don't have a dog
let yourDog = Dog(name: "DaveDog") // if you have a dog

print (myDog, yourDog)

let arrayConstruct: [Person] = [Person(name: "DaveOne"), Person(name: "DaveTwo")]
let arrayInit: [Person] = [.init(name: "DaveOne"), .init(name: "DaveTwo")]

let myStringArray = "Hello, World!".map(String.init)
let mySecondStringArray = "Hello, World!".map({ String($0) })

print (myStringArray, mySecondStringArray)
