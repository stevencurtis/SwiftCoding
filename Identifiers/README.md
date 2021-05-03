# Using Type-Safe Identifiers
## Stop your own silly mistakes

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>

## Keywords and Terminology:
Identifier: In this instance, an identifier for values 
UUID: A 128-bit number used to identify information

## Prerequisites:
* None, but creating a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) would be useful

## Why
You need to uniquely identify both values and objects - and this is often brought into focus when you are using Core Data in your project.

If you want to keep track of instances of your value types, you can use an `Identifier` in much the same way that you might use `ObjectIdentifier` for class-types (well, objects).

You may well be able to do this through `UUID`, but using your own `Identifier` gives you more flexibility, and allows you to make your code type-safe which may well be particularly important when using databases (for example CoreData abstractions).

## My previous solution
I'd usually be satisfied creating trackable instances of value types using a simple String as the identifier (or even an Integer).

This would look something like the following:

```swift
struct Person {
    var name: String
    var id: String
}

let dang = Person(name: "Đặng", id: "1")
```

which is quite a fragile way of working, we don't have any of Swift's type safety. 

More than this, items is a set or a dictionary need to conform to the `Hashable` protocol (as detailed in my [article](https://medium.com/@stevenpcurtis.sc/swifts-hashable-fd57e6cd6426)) - and there is a way to get this...wait for it!

## Create an Identifier
By creating an identifier type we can create a `hashable` instance of our types, that can then be put into dictionaries or sets. 

In order to do so it makes sense to create an `Identifier` type, something like:

```swift
struct Identifier: Hashable {
	let string: String
}
```

which can then be used in the class

```swift
struct Identifier: Hashable {
    let string: String
}

struct Person {
    var name: String
    var id: Identifier
}

let dang = Person(name: "Đặng", id: Identifier(string: "1"))
```

## Using Type-Safety
We need to also store what type of Identifier we are using, and we can do so by storing a `Object` value in the identifier.

```swift
struct Identifier<Object>: Hashable {
    let string: String
}

struct Person {
    var name: String
    var id: Identifier<Person>
}

let dang = Person(name: "Đặng", id: Identifier(string: "1"))
```
this means that we get Swift's type-safety for the `Identifier`- it has to be the right **type** of Identifier in order to compile now.


## Using different type of Identifier
Instead of using just Strings, which let's face it are not great for all uses, we can use any type of Id:

```swift
struct Identifier<Object, Id: Hashable & Codable>: Hashable {
    let rawId: Id
}

struct Person {
    var name: String
    var id: Identifier<Person, String>
}

let dang = Person(name: "Đặng", id: Identifier(rawId: "1"))
```

# Conclusion
There is certainly use for using `UUID` in your project. But there is also use for using identifiers in your project.

This is one of those issues where you need to think about your project, and what is the best solution for the problem that you are solving. 

So I'm saying the classic "it depends" solution. Sorry about that. But yes, both these type of identifiers are great ways for using `DiffableDataSource` (but that is another story completely). 

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
