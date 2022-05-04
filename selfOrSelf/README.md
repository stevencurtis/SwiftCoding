# Self or Self in Swift?
## That capital makes a difference

Difficulty: **Beginner** | Easy | Normal | Challenging

# Prerequisites:
No specific prerequisites are required for this

https://www.appypie.com/self-swift-how-to/

# What is self?
`self` (with a lowercase s) is a property of an instance that holds the instance itself. This means `self` can refer to any current object.

`self` is a common sight in much Swift code. Yes, since Swift 5.3 we do not have to explicitly declare self on a [value type](https://medium.com/swift-coding/when-to-use-class-or-struct-in-swift-e6037147c1d).

# What? What is Self and self?
`self` (with a lowercase s) is an object. It can represent a `struct`, `class` or property.

`Self` (with an uppercase S) is a type. This means that `Self` can mean any current type`.

```swift
static func createPeople(count: Int) -> [Self] {
```

`Self` is often used in Protocols and Extensions. I most often use these as static functions for testing. Something like the following:

```swift
struct Person {
    let name: String
    init(name: String) {
        self.name = name
    }
}

extension Person {
    static func test(name: String = "Rosa") -> Self {
        .init(name: name)
    }
}
```

Of course there are **multiple** examples of `self` and `Self` used in that code snippet. I think this requires more explanation.

# The basic example `self`

```swift
struct Person {
    let name: String
    init(name: String) {
        self.name = name
    }
}
```

let us take the first example of `self`.

```swift
self.name = name
```

This is a use of `self` explicitly used to set a property from the initilizer. 

There can also be an implicit use of `self` (so you could remove this self under certain circumstances), but in this example the `self` is required so it is clear we are setting the property `name` on the struct rather than attempting to change the property being passed in the initializer (which is also called `name`).

Uses of `self` in Swift also includes the following:
- Setting an outlet property on a `UIViewController`
- Avoid strong reference cycles in closures

# The basic example `Self`
```swift
struct Person {
    let name: String
    init(name: String) {
        self.name = name
    }
}

extension Person {
    static func test(name: String = "Rosa") -> Self {
        .init(name: name)
    }
    
    static func createPeople(count: Int) -> [Self] {
        Array(repeating: test(), count: count)
    }
}
```
Focussing on the extension here, `Self` represents a type, specifically a `Person`.

So I would use this to create instances of the person (usually in a test) without having to explicitly produce a name for the person.

So something like
```swift
print(Person.test())
```

would print out a person with the name `Rosa`.

# A complex example
Don't panic! This is only complex because it uses both `self` and `self` within a protocol. 

Say I wanted `UIViewController` to conform to a protocol to make it programmatically instantiable. I might make a protocol as in the following code snippet:

```swift
public protocol Instantiable {
    static func instantiateFromNib() -> Self
}

extension UIViewController: Instantiable {
    public static func instantiateFromNib() -> Self {
        return self.init(
            nibName: String(describing: self),
            bundle: Bundle(for: self)
        )
    }
}
```

We've gained `self` and `Self` all over the place.

`self.init`

represents that we are using the current intializer. 

`String(describing: self)`

Is a `String` that will be formed from the current object.

`Bundle(for: self)`

Is the `Bundle` for the current instance of the `UIViewController`.

# Conclusion

It can seem confusing when we have two keywords that are separated only by the case of the initial letter. However, we do that all the time! An uppercase usually declares a type, while a lowercase usually declares a value.

`self` is no exception to this.

So I hope that this article has been of help to you, and you have enjoyed reading it. Thank you!

I'd love to hear from you if you have questions

Subscribing to Medium using this link shares some revenue with me.
