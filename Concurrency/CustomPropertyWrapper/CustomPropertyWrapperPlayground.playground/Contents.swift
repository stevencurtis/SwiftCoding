import UIKit

@propertyWrapper
struct Clamped {
    var wrappedValue: Int {
        didSet {
            if wrappedValue < minValue {
                wrappedValue = minValue
            } else if wrappedValue > maxValue {
                wrappedValue = maxValue
            }
        }
    }
    
    let minValue: Int
    let maxValue: Int
    
    init(wrappedValue: Int, min: Int, max: Int) {
        self.minValue = min
        self.maxValue = max
        self.wrappedValue = wrappedValue
    }
}

class Person{
    @Clamped(min: 0, max: 120) var age: Int = 0
}

let dave = Person()
print(dave.age) // 0
dave.age = 33
print(dave.age) // 33
dave.age = 130
print(dave.age) // 120


@propertyWrapper
struct LogChanges<T> {
    private var value: T
    private let propertyName: String
    
    var wrappedValue: T {
        get { value }
        set {
            print("Changing \(propertyName) from \(value) to \(newValue)")
            value = newValue
        }
    }
    
    init(wrappedValue: T, _ propertyName: String) {
        self.value = wrappedValue
        self.propertyName = propertyName
    }
}

class MyViewModel {
    @LogChanges("count") var count: Int = 0
}

let viewModel = MyViewModel()
viewModel.count = 1 // Output: "Changing count from 0 to 1"
viewModel.count = 2 // Output: "Changing count from 1 to 2"
