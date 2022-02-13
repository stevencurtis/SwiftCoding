# Why do we ever need to inherit from NSObject?
## Is NSObject still important?

![Photo by Mike Dorner on Unsplash](Images/photo-1481349518771-20055b2a7b24.jpeg)<br/>
<sub>Photo by Mike Dorner on Unsplash<sub>

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift, or be able to code in [Swift Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)

## Terminology:
NotificationCenter: A notification dispatch mechanism that enables the broadcast of information to registered observers
NSObject: The root class of most Objective-C class hierarchies, from which subclasses inherit a basic interface to the runtime system and the ability to behave as Objective-C objects
Objective-C: An Object Oriented language
Subclassing: This is the act of basing a new class on an existing class

# NSObject
`NSObject` is the root class of most `Objective-C` hierarchies, from which subclasses inherit an interface to the runtime system and have the ability to behave as `Objective-C` objects.

# Performance
Swift is known to be faster than `Objective-C`, and inheriting the interface gives you a performance disbenefit against running pure Swift code.

# Benefits of subclassing NSObject
These classes are actually `Objective-C` classes, meaning that classes inheriting from `NSObject` are in some sense "`Objective-C` compatible".

Subclassing `NSObject` in Swift gets you Objective-C runtime flexibility but also `Objective-C` performance. Avoiding `NSObject` can improve performance if you don't need `Objective-C`'s flexibility.

Swift classes that are subclasses of `NSObject`:
- are `Objective-C` classes themselves
- use `objc_msgSend()` for calls to (most of) their methods
- provide `Objective-C` runtime metadata for (most of) their method implementations

Swift classes that are not subclasses of `NSObject`:

- are `Objective-C` classes, but implement only a handful of methods for NSObject compatibility
- do not use `objc_msgSend()` for calls to their methods (by default)
- do not provide `Objective-C` runtime metadata for their method implementations (by default)

**What?**

This means that there are some specific circumstances that you might have to subclass NSObject like for KVO where [addObserver(_:forKeyPath:options:context:)](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.apple.com%2Fdocumentation%2Fobjectivec%2Fnsobject%2F1412787-addobserver) requires that the observer is a subclass of `NSObject` - no getting around that!
Another circumstance where inheriting from `NSObject` is required is when using `NSCoding` to persist to a disk (you will need to inherit from both `NSCoding` and `NSObject` in your class )


# Real Example: KVO
If you want to use KVO you're going to need to subclass from `NSObject` [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/KVOvsNotificationCenter).

This is because `Objective-C` is all about objects sending messages to other object. `NSObject` exists to mark a class in Swift that you will provide that basic functionality - basically `Objective-C` needs you to build up from a base class with your functionality on top (That is, `NSObject` is a Universal Base Class).

This is because `addObserver(_:forKeyPath:options:context:)` requires that the observer is a subclass of NSObject — no getting around that!

# UIKit classes
`UIKit` classes ultimately inherit from `NSObject`. You don't have to (you did in `Objective-C`), but the `UIKit` classes do. 

Now Apple don't guarantee this going forwards so KVO compatibility may fall off in the future- we're going to have to wait and see on this one as at the moment this is one of the features that depend on the functionality brought from `NSObject`.

# Swizzling
In order to perform method Swizzling you would need to inherit from `NSObject` - and the functions you wish to swizzle would need the `dynamic` attribute to show that you will provide accessor methods dynamically at runtime. This can be done using the Objective-C runtime functions.

# Hashable
NSObject already conforms to the [Hashable](https://medium.com/better-programming/swifts-hashable-fd57e6cd6426) protocol, but what if we wish to override the hash? 

Well to do so, we can override the `hash` property:

```swift
override var hash : Int {
    return value
}
```

Of course you should remember that `Equatable` is the base protocol for `Hashable`, which is nice!

# But...
Subclassing NSObject will give you a runtime hit - that is you are going to get Objective-C performance while subclassing NSObject - meaning that you'd probably want to avoid this if at all possible.

# Conclusion
You're probably always going to need to inherit from NSObject, well where always means at least for now.
It is kind of one in the eye for Swift only iOS programmers, it is still seemingly useful for current iOS programmers to know something about Objective-C.

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
