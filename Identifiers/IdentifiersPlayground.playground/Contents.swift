import UIKit

//struct Person {
//    var name: String
//    var id: String
//}
//
//let dang = Person(name: "Đặng", id: "1")





//struct Identifier: Hashable {
//    let string: String
//}
//
//struct Person {
//    var name: String
//    var id: Identifier
//}
//
//let dang = Person(name: "Đặng", id: Identifier(string: "1"))



struct Identifier<Object, Id: Hashable & Codable>: Hashable {
    let rawId: Id
}

struct Person {
    var name: String
    var id: Identifier<Person, String>
}

let person = Person(name: "Đặng", id: Identifier(rawId: "1"))



struct PersonEquatable: Equatable {
    var name: String
    var id: Identifier<Person, String>
}

let person1 = PersonEquatable(name: "Đặng", id: Identifier(rawId: "1"))
let person2 = PersonEquatable(name: "Đặng", id: Identifier(rawId: "2"))

print(person1 == person2)
print(person1 == person1)
