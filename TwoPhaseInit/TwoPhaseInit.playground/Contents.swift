import UIKit

//Think of it this way. Phase 1 is quite limited. All it does is set all required property values. You can't do anything else until that's done.
//In phase 1, you can't refer to self, and you can't call other methods. That's very limiting.
//Once phase 1 is complete, you are free to call other methods and to refer to self.
//Most of what you think of as code that takes place in an init method takes place in phase 2.
//If you have an object that manages a network connection, it would need to set up that network connection in phase 2, for example


class Animal {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Dog: Animal {
    var owner: String
    init(name: String, owner: String) {
        self.owner = owner
        super.init(name: name)
    }
}

let trevor = Dog(name: "Trevor", owner: "Dave")
print (trevor.name, trevor.owner) // Trevor Dave



//class Person {
//  let awake: Bool
//  let eating: Bool
//  let sleeping: Bool
//
//  init(awake: Bool, eating: Bool, sleeping: Bool) {
//    self.awake = awake
//    self.eating = eating
//    if self.awake && self.eating {
//        print ("Awake and eating is impossible")
//    }
//    self.sleeping = sleeping
//  }
//}

//class Person {
//  let awake: Bool
//  let eating: Bool
//  let sleeping: Bool
//
//  init(awake: Bool, eating: Bool, sleeping: Bool) {
//    self.awake = awake
//    self.eating = eating
//    self.sleeping = sleeping
//    if self.awake && self.eating {
//        print ("Awake and eating is impossible")
//    }
//  }
//}

class Person {
  let awake: Bool
  let eating: Bool
  let sleeping: Bool

  init(awake: Bool, eating: Bool, sleeping: Bool) {
    self.awake = awake
    if self.awake {
        print ("Awake")
    }
    self.eating = eating
    if self.eating {
        print ("Eating")
    }
    self.sleeping = sleeping

  }
}


class Mage {
    var spellPower: Int
    var physicalPower: Int

    init() {
        self.spellPower = 4
        self.physicalPower = 3
    }
}
class Witch: Mage {
    var charm: Int

    override init() {
        charm = 3
        super.init() // Phase 1: Initialize superclass

        // Phase 2: Additional customizations
        physicalPower = 2
    }
}
