# Which of these properties COULD cause a Swift Retain Cycle
## Only one correct answer

Let's look at the class:
```swift
final class Car {
    var make: String
    var model: String?
    var engine: Engine
}
```

# The answer:
Make and model are both `String` value types. They cannot possibly cause a retain cycle in Swift.

Now the answer as to whether `Engine` is a value or reference type (probably a struct or a class) is left open. If it *is* a reference type then a retain cycle could be caused. that is, if we had the following complete:

```swift
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
    var car: Car?
    
    init(horsepower: Int) {
        self.horsepower = horsepower
    }
}

let car = Car(
    make: "Toyota",
    model: "Yaris",
    engine: .init(horsepower: 40)
)
```

Even when the engine is a variable type, you can make sure that a retain cycle isn't formed by making the reference back to car weak

```swift
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
```

# Conclusion
Yes, I know you knew the answer. Now we all know. Well done us!
