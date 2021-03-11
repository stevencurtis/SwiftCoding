import UIKit


class Person {
    var age: Int
    init (age: Int) {
        self.age = age
    }
}

let dave = Person(age: 24)

class Dog {
    var mood: String
    init() {
        self.mood = "Happy"
    }
}

let bear = Dog()

struct Square {
    var height: Int
    var width: Int
}

Square(height: 2, width: 10 )


enum Day {
    case Sunday
    case Monday
    case Tuesday
    case Wednessday
    case Thursday
    case Friday
    case Saturday
}
 let day = Day.Friday

enum Weather: String {
    case Hot = "Toasty"
    case Cold
}
Weather.Hot.rawValue // Toasty
Weather.Cold.rawValue // Cold


Weather(rawValue: "Toasty") // Hot
Weather(rawValue: "Not there")


class Address {
    var number : String
    var address : String
    init(firstLineAddress: String) {
        let lineComponents = firstLineAddress.components(separatedBy: " ")
        self.number = lineComponents.first!
        self.address = lineComponents.last!
    }
    init(number: String, address: String) {
        self.number = number
        self.address = address
    }
}

let address = Address(firstLineAddress: "22 King's Street")
print(address.number, address.address)
let addressQ = Address(number: "44", address: "Queen's Street")
print(addressQ.number, addressQ.address)

class Food {
    var name: String
    init(forname name: String) {
        self.name = name
    }
}

let fruit = Food(forname: "Orange")

class Vegetable {
    var name: String = "Turnip"
}
let turnip = Vegetable()

struct Meat {
    var name: String = "Pork"
}

let pig = Meat()
let cow = Meat(name: "Beef")




class Animal {
    var created: Bool
    init() {
        created = true
    }
    func screams() {
        print ("AHhhhh")
    }
}

class Pig: Animal {
    var name: String
    init(name: String) {
        self.name = name
        super.init()
    }
    
    convenience override init() {
        self.init(name: "No Name")
    }
}

let piggy = Pig()
(piggy as Animal).created

let john = Pig(name: "John")
(john as Animal).created

class Sheep: Animal {}
let wooly = Sheep()

class Tamworth: Pig {
    override init(name: String) {
        super.init(name: "Tammy")
    }
}

let lunch = Tamworth(name: "Lunch")



struct Veggie {
    let type: String
    init?(type: String) {
        if type == "Tomato" { return nil }
        self.type = type
    }
}
let tomato = Veggie(type: "Tomato") // nil
let carrots = Veggie(type: "Carrots") // is a Veggie








class Clothes {
    var name: String
    required init(){
        self.name = "No Name"
    }
}
class Shoes: Clothes {
    var shoesName: String = "No Shoes Names"
    init(shoesName: String) {
        self.shoesName = shoesName
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
let adidas = Shoes(shoesName: "Adidas")

