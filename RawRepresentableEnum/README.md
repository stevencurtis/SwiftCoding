# Exploring RawRepresentable and Enums in Swift
## Enums for Raw types


Difficulty: Beginner | **Easy** | Normal | Challenging

RawRepresentable is a protocol from the Swift standard library. We might be aware of this in that conformance is autosynthesized - but are we able to dive deeper? This article is designed to help us do just that.


## Prerequisites:
Be able to produce a "Hello, World!" iOS application (guide [HERE](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71))
Know about Segues in iOS applications (guide [HERE](https://medium.com/@stevenpcurtis.sc/segues-in-swift-8a7933c1242c))
Understand the use or Enums in Swift (guide [HERE](https://medium.com/@stevenpcurtis.sc/enums-in-swift-f242a571bf9f))

# Terminology
Character: A character, usually associated with a letter of the alphabet
Enum: A type consisting of a set of named values, called members
RawRepresentable: A type that can be converted to and from an associated raw value

# The Motivation
When using enum types as in the Counts case below, the Swift compiler automatically adds RawRepresentable conformance

```swift
enum Counts: Int {
    case one
    case two
}
```
The first case has an automatic value of 0, for clarity. 
Let's dive into this:

This means that we get a failable initializer to construct an enum value from a raw value, that is:

```swift
Counts.init(rawValue: 0) // one
Counts.init(rawValue: 1) // two
```

(The synthesized raw value begins at 0, and increments for each subsequent value).

Indeed you can access an instance's raw value through the rawValue property.

```swift
let first = Counts.init(rawValue: 0)
first?.rawValue // 0
```

Indeed, if we wish to change the initial raw value Swift calculates the subsequent `raw values`. Neat.

```swift
enum Counts: Int {
    case one = 1
    case two
}
let first = Counts.init(rawValue: 0)
first?.rawValue // 0
```

To quote the documentation:

"For any enumeration with a string, integer, or floating-point raw type, the Swift compiler automatically adds RawRepresentable conformance."

**Ok, Ok, what happens when we don't use String, Integer or Floats?**

# Conformance to RawRepresentable
When I quickly try to create an enum type with a Character raw type I get the following series or worring errors. Oh dear.

![Images/Error.png](Images/Error.png)

Swift suggests we add protocol stubs - so we can do exactly that.

```swift
enum Chrs: Character {
    typealias RawValue = Character
    case one = "A"
    case two = "B"
}
```

we can then print to the console, or do whatever we wish to the enum to do (as above) including the **failable initializer** as below:

```swift
let b = Chrs.init(rawValue: "A") //one
b?.rawValue // "A"
```

# Conclusion
RawRepresentable is a protocol in the Swift standard library that allows types to be converted to and from an associated raw value.

When using enums with integer, string, or floating-point raw types, RawRepresentable conformance is automatically added by the Swift compiler.

 However, for other types like Character, we need to add protocol stubs to make the type conform to RawRepresentable. Once a type conforms to RawRepresentable, we can use the failable initializer to construct an enum value from a raw value and access an instance's raw value through the rawValue property.
 
This protocol provides us with a convenient way to work with enums and their associated raw values.

# Extend your knowledge

Apple have created documentation for RawRepresentable [HERE](https://developer.apple.com/documentation/swift/rawrepresentable)
