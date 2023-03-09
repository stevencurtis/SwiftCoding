import UIKit

var str = "Hello, playground"
print (str)

struct Person{
    var name: String
    init(_ name: String) {
        self.name = name
    }
}

let tina = Person("Tina")

print(tina.self) // Person(name: "Tina")
print(type(of: tina)) // Person




class SomeBaseClass {
    class func printClassName() {
        print("SomeBaseClass")
    }
}
class SomeSubClass: SomeBaseClass {
    override class func printClassName() {
        print("SomeSubClass")
    }
}
let someInstance: SomeBaseClass = SomeSubClass()
// The compile-time type of someInstance is SomeBaseClass,
// and the runtime type of someInstance is SomeSubClass
type(of: someInstance).printClassName()
// Prints "SomeSubClass"

var person: Person
person = .init("Rob")

class Shape {}
class Circle: Shape {}
class Square: Shape {}

var shapeCounts = [ObjectIdentifier: Int]()
shapeCounts[ObjectIdentifier(Shape.self)] = 0
shapeCounts[ObjectIdentifier(Circle.self)] = 1
shapeCounts[ObjectIdentifier(Square.self)] = 2

print(shapeCounts[ObjectIdentifier(Circle.self)]) // 1


class MyClass {
    static func foo() {
        print("foo")
    }
    
    func bar() {
        print("bar")
    }
    
    required init() {
    }
}

let myInstance = MyClass()

// Use .self to access the static metatype of MyClass
MyClass.self.foo()

// Use .type to access the dynamic metatype of myInstance
type(of: myInstance).init().bar()

// Create an instance of MyClass as an alternative to MyClass()
MyClass.self.init()
