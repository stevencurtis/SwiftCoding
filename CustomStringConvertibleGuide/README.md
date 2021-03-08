# Using Swift's CustomStringConvertible
## A practical protocol

![Photo by Hermes Rivera on Unsplash](Images/hermes-rivera-shEtkYRYt40-unsplash.jpg)<br/>
<sub>Photo by Hermes Rivera on Unsplash<sub>

If you'd like to see a video version of this article, it's right [HERE](https://youtu.be/CHTq_MJMNDw)

If you're familiar with `protocol` in Swift, you might be aware that either `struct` value types or `class` reference types can conform to them, and this can mean that there are some requirements you might need to meet or additional functionality is added to your conforming type.

One example might be if you have a `User` struct:

```
struct User {
    let name: String
    let age: Int
}
```

which can be instantiated with the following type of expression:

```swift
let friend: User = User(name: "Karen", age: 32)
```

which can of course be printed to the console:

`print (friend)`

which prints this to the console: `User(name: "Karen", age: 32)`. 

Of course this is fine, but not exactly user-friendly (and you may well want such a thing to be visible to the end user at some point).

This is the default description of the type, but we can do better by supplying our own description, and doing better is something that we should always be aiming for in coding.

## Conforming to CustomStringConvertable
Conforming to `CustomStringConvertable` is a reasonably easy task if you are familiar with conforming to a `protocol`

```swift
struct User: CustomStringConvertible {
    let name: String
    let age: Int
}
```
This, unfortunately leads to a rather basic error-message.

```swift
Type 'User' does not conform to protocol 'CustomStringConvertible'
```

So we need to do something in order to conform to the protocol. In this case, we need to implement the  `description` property on your conforming type.

The [documentation](https://developer.apple.com/documentation/swift/customstringconvertible) tells us the following `var description: String`, that we can implement as a computed property.

The completed version look something like the following:

```swift
struct User: CustomStringConvertible {
    var description: String {
        return "\(name) is \(age)"
    }
    
    let name: String
    let age: Int
}

let friend: User = User(name: "Karen", age: 32)
print(friend)
struct User: CustomStringConvertible {
    var description: String {
        return "\(name) is \(age)"
    }
    
    let name: String
    let age: Int
}

let friend: User = User(name: "Karen", age: 32)
print(friend)
```

Yet we can still do better.

## Conforming to protocol
This is a common thing in Swift.  To make code easier to read we place the conformance for protocols into an extension. This is because this makes it easier to read for other people using your code
```swift
struct User {
    let name: String
    let age: Int
}

extension User: CustomStringConvertible {
    var description: String {
        return "\(name) is \(age)"
    }
}

let friend: User = User(name: "Karen", age: 32)
print(friend)
```


# Conclusion
Conforming to `CustomStringConvertible` is a common thing we might do in Swift - but when we do it is important to get it right.

Doing the little extras like placing your conformance into an extension are not just good things to be doing in your code, but they are requisite in some places of employment so the sooner you think about doing this the better!

I hope this article has been of help to you! There is a video version of this article up on YouTube, if that would further help you: [HERE](https://youtu.be/CHTq_MJMNDw)

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)

