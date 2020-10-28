import UIKit

protocol Animal {
    func animalSound() -> String
}

extension Animal {
    var name: String {"Doggy"}
    func animalSound() -> String {
        return "Woof"
    }
}

final class Dog: Animal { }

let fluffy = Dog()

fluffy.name
fluffy.animalSound()

protocol Building {
    var walls: Int { get }
}

extension Building {
    var walls: Int { return 4 }
}

protocol Residential: Building { }

struct Tent: Residential {
    var walls: Int { return 0 }
}

let dome = Tent()
print (dome.walls) // 0
let tunnel: Residential = Tent()
print (tunnel.walls) // 4

