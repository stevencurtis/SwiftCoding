import UIKit

protocol Animal {
    func animalSound(pain: Bool) -> String
}

class Mammal: Animal {
    func animalSound(pain: Bool = false) -> String {
        return "Indeterminate grunt \(pain ? "ttttt" : "")"
    }
}

class Pig: Mammal {
    override func animalSound(pain: Bool = true) -> String {
        return "Oink \(pain ? "kkkk" : "")"
    }
}

let mammal = Mammal()
mammal.animalSound() // "Indeterminate grunt" [not in pain]

let jessie: Mammal = Pig()
jessie.animalSound() // "Oink" [not in pain]

class A {
    func execute(ind: Int = 0) {
        print("A: \(ind)")
    }
}
class B: A {
    override func execute(ind: Int = 1) {
        print("B: \(ind)")
    }
}
let instance: A = B()
instance.execute()
