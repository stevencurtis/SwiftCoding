# Type Properties in Swift
## Static?

Let's take a look.
Difficulty: **Beginner** | Easy | Normal | Challenging

This article has been developed using Xcode 14.2, and Swift 5.7.2

Type properties rather than [properties](https://stevenpcurtis.medium.com/properties-in-swift-47a8868c2297)? Let's take a look at this Swift code!

## Prerequisites
- Some knowledge of [properties](https://stevenpcurtis.medium.com/properties-in-swift-47a8868c2297) could be useful

# Type Properties
Type properties belong to a type itself. That means that they do not belong to an instance of that type.

So a property on a struct might look like:

```swift
struct MyStruct {
    let myProperty: Int
}
```
Which can intialised as an instance of this struct:

```swift
let myInstance = MyStruct(myProperty: 4)
```

we can then access that property

```swift
myInstance.myProperty // 4
```

Whereas type properties belong to the type itself.

We set up the struct slightly differently. The property belongs to the type, so we set the value in the type definition.

```swift
struct MyStruct {
    static let myProperty: Int = 4
}
```

We can then access the property from the type

```swift
MyStruct.myProperty // 4
```

**Why would we ever want to use type properties?**

Type properties can be useful in situations where you want to define properties that are shared across all instances of a type, or when you want to define properties that belong to a type itself rather than to any specific instance.

They can be used to define constants, global variables, and other shared state that is accessed by all instances of a type.

# Conclusion
I use type properties [to store constants](https://stevenpcurtis.medium.com/constants-in-swift-c6dd22bbea5e)

You?
