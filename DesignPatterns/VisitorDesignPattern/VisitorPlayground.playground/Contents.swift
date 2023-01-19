


// each time we want to add a new operation, we must modify the interface to every single class in the hierarchy

//protocol Animal {
//    func makeSound()
//}
//class Dog: Animal {
//    func makeSound() {
//        print ("Woof")
//    }
//}
//class Cat: Animal {
//    func makeSound() {
//        print ("Meow")
//    }
//}






//// the component should take the visitor interface as an argument
//protocol Animal {
//    func accept(_ visitor: Visitor)
//}
//
//// concrete component A
//class Dog: Animal {
//    func accept(_ visitor: Visitor) {
//        visitor.hereIsADog(d: self)
//    }
//
//    func woof() -> String {
//        return "woof"
//    }
//
//}
//
//// concrete component B
//class Cat: Animal {
//    func accept(_ visitor: Visitor) {
//        visitor.hereIsACat(c: self)
//    }
//
//    func miow() -> String {
//        return "miow"
//    }
//}
//
//
//// abstract Visitor class (Operation)
//protocol Visitor {
//    func hereIsADog(d: Dog)
//    func hereIsACat(c: Cat)
//}
//
///// Concrete Visitors implement several versions of the same algorithm, which
///// can work with all concrete component classes.
//
//class Sound: Visitor {
//    func hereIsADog(d: Dog) {
//        print (d.woof())
//    }
//
//    func hereIsACat(c: Cat) {
//        print (c.miow())
//    }
//}
//
//let animals: [Animal] = [Cat()]
//
//let visitor1 = Sound()
//
//
//let animalNames = animals.map{ animal in
//    let theSound = Sound()
//    animal.accept(theSound)
//}





// the component should take the visitor interface as an argument
protocol Animal {
    func accept(_ visitor: Visitor)
}

// concrete component A
class Dog: Animal {
    func accept(_ visitor: Visitor) {
        visitor.hereIsADog(d: self)
    }
}

// concrete component B
class Cat: Animal {
    func accept(_ visitor: Visitor) {
        visitor.hereIsACat(c: self)
    }
}


// abstract Visitor class (Operation)
protocol Visitor {
    func hereIsADog(d: Dog)
    func hereIsACat(c: Cat)
}


class Sound: Visitor {
    func hereIsADog(d: Dog) {
        print ("Woof")
    }
    
    func hereIsACat(c: Cat) {
        print ("Miow")
    }
}

class Move: Visitor {
    func hereIsADog(d: Dog) {
        print ("Run")

    }

    func hereIsACat(c: Cat) {
        print ("Jump")
    }
}

let animals: [Animal] = [Cat(), Dog()]

let visitor1 = Sound()
//let visitor2 = Move()


let _ = animals.map{ animal in
    let theSound = Sound()
    animal.accept(theSound)
}


let _ = animals.map{ animal in
    let theMovement = Move()
    animal.accept(theMovement)
}


let dog = Dog()
let sound = Sound()
dog.accept(sound)
