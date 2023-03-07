# Mastering Swift: Create Your Own Property Wrapper
## Elevate Your Swift Code to the Next Level by Customizing Property Behaviour with Property Wrappers

In 2020 I wrote an article about Swift's property wrappers. I even called it ["Understanding Swift's Property Wrappers"](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Funderstanding-swifts-property-wrappers-805340a8ced6). The problem? 

I still don't feel I adequately understand Property Wrappers. 

I need to create my own to really "understand" what is going on under the hood. When that happens, I feel like making an article about the journey.

That article? You're reading it.

Difficulty: Beginner | *Easy* | Normal | Challenging

This article has been developed using Xcode 14.2, and Swift 5.7.2

# Prerequisites:
You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), or a Playground to run Swift code

It might be worth exploring what a [property wrapper](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Funderstanding-swifts-property-wrappers-805340a8ced6) is, if you are unsure

## Keywords and Terminology:
Property Wrapper: A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property

# Property Wrappers
A property wrapper in Swift enables you to add custom behaviour to properties. It has the advantage of encapsulating and reusing code which modifies the behaviour of a property (so it does not need to be repeated for each individual property.

## The Clamped example
Let's make this clearer with an example, where we clamp a given number (that is, restrict a number between two other numbers).

```swift
Let's make this clearer with an example, where we clamp a given number (that is, restrict a number between two other numbers).
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
```

Here we have defined an `@Clamped` property wrapper that is being used in a `Person` class. A person has an initial age of 0 (although you should be careful with that, as it is not true in all cultures).

## Log Changes
If we think of a example that does not involve number theory, we can create a property wrapper by creating another new type that implements the @propertyWrapper attribute.

In this example, our property wrapper logs changes to a property:

```swift
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
```
`LogChanges` takes a generic type parameter T (the compiler infers this when we write `@LogChanges("count") var count: Int = 0` based on the type of the count property ). 
It can be used like the following code snippet:

```swift
class MyViewModel {
    @LogChanges("count") var count: Int = 0
}

let viewModel = MyViewModel()
viewModel.count = 1 // Output: "Changing count from 0 to 1"
viewModel.count = 2 // Output: "Changing count from 1 to 2"
```

The `wrappedValue` property is responsible for getting and setting the value of the property being wrapped. The `wrappedValue` property prints out a message each time the property value is set.

In this case, `MyviewModel` is a class with a count property wrapped with the property wrapper `LogChanges`. The `wrappedValue` (when called) prints out a suitable message to the console.

That's it. There are two `@PropertyWrapper` attributes that can be used in code, and have nice little examples.

# Conclusion
Property wrappers are a Swift feature that can help you write easy to read and maintainable code in Swift. They have been available since Swift 5.1, and have particular power when coupled with SwiftUI - so this is certainly something you should look at as you enhance your understanding of Swift and iOS/iPadOS.

When creating code you should always think about reusability, what a great use of abstraction in the constructs of the language!
