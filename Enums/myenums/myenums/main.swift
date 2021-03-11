//
//  main.swift
//  myenums
//
//  Created by Steven Curtis on 30/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

print("Hello, World!")

enum Bird {
    case none
    case Chicken
    case Turkey
    
    // init here allows us to initialize an instance without explicitly specifying a value
    init(){
        self = .none
    }
}

let test = Bird.Chicken
let testTwo = Bird.Chicken

print (Bird.Chicken.self)
print (Bird.none)
print (Bird())


enum Dog : String {
    case Alsation = "Kim"
    case Puppy = "Tigger"
    case none = ""
    
    init() {
        self = .none
    }
    
    init(_ value: String) {
        self = .Alsation
    }
    
}

print (Dog())
print (Dog.Alsation)




// Associated Values


//enum Stock {
//    case buy
//    case sell
//}
//
//let initialTrade = Stock.buy
//print (trade)



enum Trade {
    case buy
    case sells
}

let trade = Trade.buy
print (trade == .buy) // true
print (trade == .sells) // false

//enum Trade {
//    case buy(stock: String, amount: Int)
//    case sells
//}
//
//let trade = Trade.buy(stock: "Apple", amount: 4)
//print (trade) // buy(stock: "Apple", amount: 4)


print ("z:", trade.self)

//switch trade {
//case let Trade.buy(stock, amt) : print ("trade stock: ", stock, "trade amount: ", amt)
//default : ()
//}

//if case let Trade.buy(stock, amount) = trade {
//    print("trade stock \(stock) trade amount:  \(amount)")
//}


//enum Wearable {
//    enum Weight: Int {
//        case light = 1
//        case mid = 4
//        case heavy = 10
//    }
//    enum Armor: Int {
//        case light = 2
//        case strong = 8
//        case heavy = 20
//    }
//    case helmet(weight: Weight, armor: Armor)
//    case breastplate(weight: Weight, armor: Armor)
//    case shield(weight: Weight, armor: Armor)
//}
//let woodenHelmet = Wearable.helmet(weight: .light, armor: .light)
//print (woodenHelmet)

enum Foods {
    enum Energy: Int {
        case healthy = 1
        case neutral = 4
        case unhealthy = 10
    }
    case chocolate(energy: Energy)
}

let mars = Foods.chocolate(energy: .unhealthy)

if case let Foods.chocolate(energy: energy) = mars {
    print("energy level \(energy.rawValue)")
}



enum Transportation {
    case car(Int)
    case train(Int)
    
    func distance() -> String {
        switch self {
        case .car(let miles): return "\(miles) miles by car"
        case .train(let miles): return "\(miles) miles by train"
        }
    }
}

let car = Transportation.car(20)
print (car.distance())

enum Animals {
    case dog(age: Int)
    case cat(age: Int)
    
    func ageInAnimalYears() -> Int {
        switch self {
        case.dog (let age) : return age * 7
        case.cat (let age) : return age * 4
        }
    }
}
let kim = Animals.dog(age: 12)
print ( kim.ageInAnimalYears() ) // 84

let dave = Animals.cat(age: 2)
print ( dave.ageInAnimalYears() ) // 8




//enum Device {
//    case iPad
//    case iPhone
//    let introduced: Int // enums cannot contain stored properties
//}


//enum Device {
//    static var newestDevice: Device {
//        return .appleWatch
//    }
//    case iPad
//    case iPhone
//    case appleWatch
//}
//
//let iPhone = Device.iPhone // cannot use newestDevice on iPhone here
//print (Device.newestDevice)



enum LightSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var light = LightSwitch.low
print (light) // low
light.next() // high
print (light)
light.next()
print (light) // off
print (light == .off)
print (light == .low)







