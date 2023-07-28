import UIKit

class PersonClass: Equatable, NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let newElement = PersonClass(name: name, age: age)
        return newElement
    }
    
    static func == (lhs: PersonClass, rhs: PersonClass) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let pClass = PersonClass(name: "Arnold", age: 84)
let bClass: PersonClass = pClass.copy() as! PersonClass

print (pClass.name)
print (bClass.name)
