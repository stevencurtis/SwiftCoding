# What are Swift's Keypaths?
## They help with KVO and more!

![Walking](Images/0*xho-boNpvzWf9cNG.jpeg)

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.4.1, and Swift 5.2.2

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), or a [Playground](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to run Swift code

## Terminology:
keypath: Read-only access to a property
writablekeypath: read-write access to a value-type property
referencewritablekeypath: read-write access to a reference-type property

# Motivation
`Combine` uses `ReferenceWritableKeyPath<Root, Bool>` in the assign function

```swift
func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Bool>, on object: Root) -> AnyCancellable
```

which is the one that allows us to connect to `UIKit` elements, for example

```swift
validationSub = loginViewModel?.userValidation
    .receive(on: RunLoop.main)
    .assign(to: \.isEnabled, on: loginView.loginButton)
```

That seems fine, but what are keypaths? How are they used, and what do they mean?

Could you make an article explaining this for me?

I don't mind if I do!

## What is a keypath?
A keypath provides read-only access to a property, whilst a writable keypath provides (well...) writable access to a property.

## A keypath example
Perhaps the best way to describe this access is through an example, where we can set up a rather basic `struct` object.

```swift
struct Person {
    var firstname: String
    var secondname: String
    var age: Int
}
let dave = Person(firstname: "Dave", secondname: "Trencher" , age: 21)
```

we can then access the properties through `WritableKeyPath<Person, String>` or `WritableKeyPath<Person, Int>` (where firstname and secondname are represented by a `String` and age is represeted by a `Int`).

The following keypath therefore returns a `String`, and that can be printed out

```swift
let firstname: String = dave[keyPath: \Person.firstname]
print (firstname) // Dave
```

Now even the property type can be stored

```swift
var writableKeyPathFirstName: WritableKeyPath<Person, String> = \Person.firstname
print (dave[keyPath: writableKeyPathFirstName]) // Dave
```

which means that you can potentially use the same property in multiple places, and storing it as a property itself means that it would only need to be stored in one place.

## Nested properties
The following is an example of nested keypaths

``` swift
struct Socks {
    var sockname: String
}

struct DrawContents {
    var name: String
    var socks: Socks
}

let topdrawer = DrawContents(name: "top", socks: Socks(sockname: "Birthday Socks"))
print (topdrawer)
print (topdrawer[keyPath: \DrawContents.name]) // top
print (topdrawer[keyPath: \DrawContents.socks.sockname]) // Birthday Socks
```

## KeyPath composition
Swift allows you to dynamically combine keypaths at runtime (of course the types need to be compatible).
```swift
let topdrawerkpath = \DrawContents.socks
let sockspath = \Socks.sockname
let composedPath: WritableKeyPath<DrawContents, String> = topdrawerkpath.appending(path: sockspath)
```

## KeyPaths as type-erased variants
You may wish to have a keypath that does not require the Value parameter

```swift
let drawerName: PartialKeyPath<DrawContents> = \.name
let drawerSocks: PartialKeyPath<DrawContents> = \.socks
```

So both `drawerName` and `drawerSocks` can be stored with the same type: `PartialKeyPath<DrawContents>`. The `Value` parameter has been type-erased.

## KeyPaths of reference types
This shouldn't be a too big surprise, but if you use a keypath on a reference type (for example a `class` )

```swift
let horse = Animal(name: "Keith")
var refKeyPath: ReferenceWritableKeyPath<Animal, String> = \Animal.name
let animalname: String = horse[keyPath: \Animal.name] // Keith
```

# Are keypaths new?
Keypaths have been around for some time, they're present in `Objective-C`!  However, they were not type safe (`keyPath()` is actually a `String`).
```swift
#keyPath(Person.firstname)
```

# Limitations
`Key path cannot refer to static member 'lifeform'`

If we change `Person` to have a static var. 
```swift
struct Person {
    static var lifeform = "Carbon"
    var firstname: String
    var secondname: String
    var age: Int
}

dave[keyPath: \Person.lifeform] // Key path cannot refer to static member 'lifeform'
```

As, well, keypaths cannot refer to static members! What a shame!

## Conclusion
So, keypaths are actually useful in iOS development, being relevant for `Combine` and SwiftUI. You want to buckle up and become familiar with this, or not? I'd say that the former is more important - and you can read up on this [HERE](https://medium.com/@stevenpcurtis.sc/combine-and-urlsession-in-uikit-68f1caa40ee1).

I hope that this article has helped you out in become more familar in this relatively new feature of Swift.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
