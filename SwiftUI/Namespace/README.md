# SwiftUI's Namespace
## A property wrapper

Difficulty: Beginner | *Easy* | Normal | Challenging
This article has been developed using Xcode 14.2, and Swift 5.7.2

# Prerequisites:
You will be expected to make a [Single View SwiftUI Application in Swift](https://medium.com/@stevenpcurtis.sc/hello-world-swiftui-92bcf48a62d3).

It would be useful to know something about [property wrappers in SwiftUI](https://github.com/stevencurtis/SwiftCoding/tree/master/SwiftUI/PropertyWrappers/)

# Terminology
Property Wrappers: A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property

# Motivation
When you think about properties in Swift you usually recognise that they have an explicit type. You know the code, something like:

```swift
var myNum: Int
```

When using type inference you might skip the explicit type and infer it. Something like the following:

```swift
var myNum = 3
```

In SwiftUI the @Namespace property wrapper creates a unique identifier to group and distinguish views or elements within a context. 

## Why
A namespace identifies views. You might want to do that to ensure animations and transitions are properly coordinated. That is you might use @Namespace to ensure smooth and coherent visual transitions.


## Usage
Here is how you might use the code.

`@Namespace private var myNamespace`
Once declared, myNamespace can be used in various contexts within SwiftUI to associate views with this particular namespace.

# Conclusion
@Namespace is an interesting one. If you ask many iOS developers if you can have a `var` without a type they might well say no. Then they might think about namespace, and off we go!
