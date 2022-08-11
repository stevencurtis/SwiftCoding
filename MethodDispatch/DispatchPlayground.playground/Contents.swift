import UIKit

protocol Animal {
    func animalSound() -> String
}

extension Mammal {
    func animalThinks() -> Bool { return true } // static dispatch
}

class Mammal: Animal {
    func animalSound() -> String {
        return "Indeterminate grunt"
    }
    
    @objc dynamic func legs() -> Int { 4 }
}

class Pig: Mammal {
    override func animalSound() -> String {
        return "Oink"
    }
}

class Fox: Mammal {}

extension Mammal {
    @objc func happyPlay() { } // message dispatch
}

class Dog: Mammal {
    override func animalSound() -> String {
        return "Woof"
    }
}

let trevor = Dog()
let percy = Pig()
let pepper = Pig()

print (trevor.animalSound()) // Woof
print (percy.animalSound()) // Oink
print (pepper.animalSound()) // Oink


struct Customer {
    func lifetimeValue() -> Double { return 0.0 }
}

extension Customer {
    func currentCustomer() -> Bool { return true }
}

enum Value {
    case one
    case two
}
