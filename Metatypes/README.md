# Metatypes in Swift
## Why .self and .type matter

# Before we start
Difficulty: **Beginner** | Easy | Normal | Challenging<br/>

## Keywords and Terminology:
Metatypes: the type of any type 

## Prerequisites:
* None

## Why
In Swift, you might have noticed that some code uses `.self` and some uses `.type` for various uses which can seem rather opaque to the beginner.

These are useful, and should not simply be ignored however!

# A Simple example
You might have a rather forced example as follows:

```swift
struct Person{
    var name: String
    init(_ name: String) {
        self.name = name
    }
}

let tina = Person("Tina")
```

so tina is clearly an instance of `Person`.

We can see this with the following print statements:

```swift
print(tina.self) // Person(name: "Tina")
print(type(of: tina)) // Person
```

# The overview
Each instance of `Person` can be represented by two things, the Type of the metatype.

```swift
Type: Person
Metatype: Person.Type
```

The Type here represents the type of an instance, but the Metatype represents the metatype, which is a type that describes another type. In other words, the metatype describes the structure and properties of the type (including methods and properties) but does not describe the actual values.

## When a function needs a type
So if you are writing a function that accepts a type (i..e Person.Type) rather than an instance you can write Person.Type as the type of the parameter - and that parameter would be Person.self.

A common use of self is from the register function in tableview:

```swift
tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
```

where the register function itself asks for any class with the definition:

```swift
func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String)
```

or equally we use a decoder while decoding JSON:

```swift
let decoder = JSONDecoder()
let decoded = try decoder.decode(Model.self, from: json)
```

where of course Model is a Struct that represents a model type.

## Referring to the type (the metatype)

If we want to refer to the type itself (in our example `Person`) rather than an instance of the type we can refer to it with a `.Type` suffix, and we call that the metatype.  

That is, we might want to access the type of a thing, rather than the type of a particular instance.

Since `AnyClass` is actually:

```swift
typealias AnyClass = AnyObject.Type
```

this is reasonably easy to understand.

By using `type(of:)` you can access the metatype of a class
`print(type(of: tina)) // Person`

and here you can also access static functions or variables on that particular metatype, as in Apples example reproduced here:

```swift
class SomeBaseClass {
    class func printClassName() {
        print("SomeBaseClass")
    }
}
class SomeSubClass: SomeBaseClass {
    override class func printClassName() {
        print("SomeSubClass")
    }
}
let someInstance: SomeBaseClass = SomeSubClass()
// The compile-time type of someInstance is SomeBaseClass,
// and the runtime type of someInstance is SomeSubClass
type(of: someInstance).printClassName()
// Prints "SomeSubClass"
```

## .self and .type
Since `String` is a type, and a value of an instance of String can be represented as "Hello, World!" we can apply the same generally as `String.Type` is a type and `String.self` is a value of a metatype.

In fact `.self` is a static metatype, so is a compile time type of an object. `.type` refers to the dynamic metatype of a type so is a runtime type of an object.

To access a dynamic metatype you should use `type(of)` which gives you an object's runtime type.

```swift
class MyClass {
    static func foo() {
        print("foo")
    }
    
    func bar() {
        print("bar")
    }
    
    required init() {
    }
}

let myInstance = MyClass()

// Use .self to access the static metatype of MyClass
MyClass.self.foo()

// Use .type to access the dynamic metatype of myInstance
type(of: myInstance).init().bar()

// Create an instance of MyClass as an alternative to MyClass()
MyClass.self.init()
```

## Hashable?
A metatype cannot usually be used as a key in one of Swift's dictionaries since they are not Hashable by default. 
There are however ways to use them as keys in a dictionary.

One approach is to use ObjectIdentifier to convert the metatype into a hashable value.

Since Hashable is a protocol that is implemented by `ObjectIdentifier` you can use as in `ObjectIdentifier(MyType.Type)` produces a `Hashable` type. ObjectIdentifier implements `Hashable` in order to be used as a key in a dictionary.

```swift
class Shape {}
class Circle: Shape {}
class Square: Shape {}

var shapeCounts = [ObjectIdentifier: Int]()
shapeCounts[ObjectIdentifier(Shape.self)] = 0
shapeCounts[ObjectIdentifier(Circle.self)] = 1
shapeCounts[ObjectIdentifier(Square.self)] = 2

print(shapeCounts[ObjectIdentifier(Circle.self)]) // 1
```
The dictionary above is called `shapeCounts` which then uses an `ObjectIdentifier` as it's key type.

You might do this if you wish to work with a set of types that cannot be easily enumerated, for example a plugin where third-party modules can add new types to an application dynamically it could do so with a dictionary of all available types.

# Conclusion
If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
