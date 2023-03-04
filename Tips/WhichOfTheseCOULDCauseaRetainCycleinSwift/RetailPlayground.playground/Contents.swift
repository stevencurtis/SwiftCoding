import UIKit

//final class Car {
//    var make: String
//    var model: String
//    var engine: Engine
//
//    init(make: String, model: String, engine: Engine) {
//        self.make = make
//        self.model = model
//        self.engine = engine
//        self.engine.car = self // set the car property of the engine to be the current car object
//    }
//}


final class Car {
    var make: String
    var model: String
    var engine: Engine
    
    init(make: String, model: String, engine: Engine) {
        self.make = make
        self.model = model
        self.engine = engine
        self.engine.car = self
    }
}

final class Engine {
    var horsepower: Int
    weak var car: Car?
    
    init(horsepower: Int) {
        self.horsepower = horsepower
    }
}

let car = Car(
    make: "Toyota",
    model: "Yaris",
    engine: .init(horsepower: 40)
)
