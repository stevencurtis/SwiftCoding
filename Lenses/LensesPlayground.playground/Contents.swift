import UIKit

struct Person {
    let name: String
    let address : Address
}

struct Address {
    let houseNumber: Int? = nil
    let street: String
    let city: String
}

let person = Person(name: "Ronald McDonald", address: Address(street: "West Loop", city: "Chicago"))

print(person.name)
//person.name = "The King"

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

// this is equivalent to the Lens above
struct LensEquivalent<A, B> {
    let from: (A) -> B
    let to: (B, A) -> A
}

let personName = Lens<Person, String>(
    get: { $0.name },
    set: { (newName, person) in
        Person(name: newName,
               address: person.address)
    }
)

personName.get(person)
let theRealKing = personName.set("The Burger King", person)
personName.get(theRealKing)
