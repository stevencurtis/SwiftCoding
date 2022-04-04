# What is the @Published Property Wrapper?
## This ain't bound

![photo-1580762410711-aa47eb8872d7](Images/photo-1580762410711-aa47eb8872d7.png)
<sub>Image by Lorna Ladril @lorna_ladril</sub>

# Before we start
Difficulty: **Beginner** | Easy | Normal | Challenging<br>
This article has been developed using Xcode 12.2, and Swift 5.3

## Prerequisites
* You will be expected to make a [Single View SwiftUI Application](https://medium.com/@stevenpcurtis.sc/hello-world-swiftui-92bcf48a62d3) in Swift.
* Some of this article touches on the [Core Concepts of Combine](https://medium.com/@stevenpcurtis.sc/core-concepts-of-combine-71d6b13d43e2)

## Keywords and Terminology
Combine: A framework that provides a declarative Swift API for processing values over time
ObservableObject: A type of object with a publisher that emits before the object has changed.
Published: A type that publishes a property marked with an attribute.

# This project
## Background
If you are familiar with `UIKit` you might have tried to create a MVVM architecture using something like [this two-way binding library](https://github.com/stevencurtis/TwoWayBindingUIKit).

Playing with 
[Semantic Versioning](https://stevenpcurtis.medium.com/upgrade-to-semantic-versioning-31342b11ce97)

## The code
`@Published` is at the heart of SwiftUI, and is the property wrapper that enables objects to be able to announce when changes occur. It should be noted however, that `@Published` is part of the `Combine` framework, and you might like to read more about that particular framework in [this article]()

`@Published` publishes it's changes through the projected value (preceeded with a dollar sign) which is a Publisher (invoking `objectWillChange.send()` on the enclosing `ObservableObject`).

Due to the use of will, this means that subscribers receive the new value before it is set on the property.

The `@Published` attribute is class constrained. Use it with properties of classes, not with non-class types like structures.

In order to make a property observable through `@Published` to classes outside the containing class, that containing class would need to inherit from `ObservableObject`, and the relevant property should be marked as `@Published` - which synthesizes an `objectWillChange` publisher to announce that the value will change.

```swift
class Device: ObservableObject {
    @Published var major: Int = 1
    var minor: Int = 0
    var patch: Int = 0
    
    func updateToNewVersion() {
        major += 1
        minor = 0
        patch = 0
    }
}

let tablet = Device()
print ("version: \(tablet.major).\(tablet.minor).\(tablet.patch)")

let cancellable = tablet.objectWillChange
    .sink { _ in
        print ("\(tablet.major).\(tablet.minor).\(tablet.patch) willChange")
}

tablet.updateToNewVersion()
```

This outputs the following:

```swift
version: 1.0.0
1.0.0 willChange
```

This seems absolutely fine! However, if we mark `minor` and `patch` as `@Published` too, then `tablet.objectWillChange` will be fired three times. 

Therefore if we make the following changes:

```swift
@Published var major: Int = 1
@Published var minor: Int = 0
@Published var patch: Int = 0
```

we will have the following output:

```swift
1.0.0 willChange
2.0.0 willChange
2.0.0 willChange
```

**Under the hood**
We can create some equivalent code to the `@Published` variable above:
```swift
class Device: ObservableObject {   
    var major: Int = 1 {
        willSet {
            objectWillChange.send()
        }
    }
    var minor: Int = 0
    var patch: Int = 0
    
    func updateToNewVersion() {
        major += 1
        minor = 0
        patch = 0
    }
}

let tablet = Device()
print ("version: \(tablet.major).\(tablet.minor).\(tablet.patch)")

let cancellable = tablet.objectWillChange
    .sink { _ in
        print ("\(tablet.major).\(tablet.minor).\(tablet.patch) willChange")
}

tablet.updateToNewVersion()
```

Effectively `objectWillChange.send()` is fired in the `willSet` [property observer]() and we execute this manually rather than getting the automatic advantages of using `@Published`, and the same result is printed to the console:

```swift
version: 1.0.0
1.0.0 willChange
```

**A real-world example**
I'm a big fan of the view model to keep my code testable, and out of loading everything into my view. This means for a login flow I might make a view model an `ObservableObject`. 

The view model looks something like the following:

```swift
class LoginViewModel: ObservableObject {
    @Published var username: String = ""
...
```

which can then be changed, and in this example a `TextField` would be bound to this value. This binding is out of the scope of this article so you might like to look at my Authentication article [SwiftUIAuthentication](https://stevenpcurtis.medium.com/authentication-using-swiftui-8bf92f76b9a2)

# Conclusion
I hope this article has been of use to you. `@Published` is at the heart of SwiftUI, meaning it is something well worth becoming used to and applying to your own work
The [Repo](https://github.com/stevencurtis/SwiftCoding/tree/master/SwiftUI/PublishedPropertyWrapper) makes things rather easier to follow in this project, and I do recommend you download this project.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
