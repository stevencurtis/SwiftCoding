import UIKit

class Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name
    }
    
    var name: String
    init(_ name: String) {
        self.name = name
    }
}
let alisha = Person("Alisha")
let personIdentifier = ObjectIdentifier(alisha)

print (personIdentifier) // ObjectIdentifier(0x0000600003fdb060)



var objectDictionary = [ObjectIdentifier: String]()
let metaObject = ObjectIdentifier(Person.self)
objectDictionary[metaObject] = "Test"

for object in objectDictionary {
    print (object)
}
