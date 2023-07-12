# Mastering ObjectIdentifier in Swift 
## Ensuring Uniqueness of Class Instances

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>

## Keywords and Terminology:
ObjectIdentifier: A unique identifier for a class instance or metatype 

## Prerequisites:
* None

## Why
In Swift, class instances and metatypes have unique identities (because if we make a copy, we copy a reference to a unique instance). 

## Usage
You might create a simple Class type that represents a person, something (for simplicity's sake) that looks like the following:

```swift
class Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name
    }
    
    var name: String
    init(_ name: String) {
        self.name = name
    }
}
let alisha = Person("Alisha")
```

Now we can create an identifier

```swift
let personIdentifier = ObjectIdentifier(alisha)
```

if we print (in this case) personIdentifier, we get a rather lovely address (and of course this is likely to differ on your machine):

```swift
print (personIdentifier) // ObjectIdentifier(0x0000600003fdb060
```

now since `ObjectIdentifier` conforms to both `Equatable` and `Hashable` if you compare two instances of alisha they will be true, but if you compare two instances of person that happen to have the same name (perhaps "Alisha") they will only be equal if they are the SAME instance.

## Equality matters
In Swift we have the equality operator `===` and this is essentially a wrapper for `ObjectIdentifier`. 

Also, since `ObjectIdentifier` conforms to `Hashable`, this can be used in conjunction with Swift's dictionaries. 

```swift
var objectDictionary = [ObjectIdentifier: String]()
let metaObject = ObjectIdentifier(Person.self)
objectDictionary[metaObject] = "Test"

for object in objectDictionary {
    print (object) // (key: ObjectIdentifier(0x000000010bd610b8), value: "Test")
}
```

It would traditionally be a limitation of these metatypes, so using `ObjectIdentifier` really overcomes this limitation.

Not only that, you'd be able to use `Sets` too!

## Sets and ObjectIdentifiers

Similarly to dictionaries, `ObjectIdentifier` can be extremely useful when working with Sets. For example, you can use it to uniquely identify instances of a class and store these identifiers in a Set. Here's an example:

```swift
class Dog {
    var name: String
    init(_ name: String) {
        self.name = name
    }
}

let rover = Dog("Rover")
let fido = Dog("Fido")
let roverAgain = Dog("Rover")

let dogIdentifiers: Set<ObjectIdentifier> = [ObjectIdentifier(rover), ObjectIdentifier(fido), ObjectIdentifier(roverAgain)]

print(dogIdentifiers.count) // Prints "3", because each instance has a unique identifier, even if their names are the same
```

## ObjectIdentifier and Memory Management

Swift's automatic memory management model is based on reference counting. While ObjectIdentifier doesn't directly influence memory management, it can be leveraged to understand and debug memory-related issues.

**Debugging Retain Cycles**
ObjectIdentifier can be a powerful tool when debugging retain cycles. By logging or storing the identifiers of your class instances, you can more easily detect cases where two or more objects are retaining each other, preventing each other from being deallocated.

```swift
class MyClass {
    var name: String
    init(name: String) {
        self.name = name
        print("Object \(ObjectIdentifier(self)) of \(MyClass.self) was created.")
    }
    
    deinit {
        print("Object \(ObjectIdentifier(self)) of \(MyClass.self) was deallocated.")
    }
}

do {
    let instance1 = MyClass(name: "Instance1")
    print("Identifier: \(ObjectIdentifier(instance1))")
} // instance1 is deallocated here
```

The use of `ObjectIdentifier` can be particularly helpful when paired with custom debug logging or breakpoints in your deinit methods. This can assist you in tracking the lifecycle of your objects, and help you spot any instances that aren't being deallocated as expected.

# Conclusion
I hope this article helps you in some way. `ObjectIdentifier` is powerful and perhaps something you will use in your projects going forwards.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
