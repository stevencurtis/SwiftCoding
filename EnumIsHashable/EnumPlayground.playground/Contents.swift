import UIKit

//struct Animal: Hashable {
//    let animalName: String
//}
//
//let dog = Animal(animalName: "dog")
//let cat = Animal(animalName: "cat")
//
//let animalSet: Set<Animal> = [dog, cat]
//
//
//
//enum Animal {
//    case dog
//    case cat
//}
//
//let animalSet: Set<Animal> = [.cat, .dog]


enum Animal: Hashable {
    case dog(breed: String)
    case cat(breed: String)
}

let animalSet: Set<Animal> = [.cat(breed: "moggy"), .dog(breed: "lab")]
