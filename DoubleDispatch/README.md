# Double Dispatch in Swift
## Collaborate together!

![Photo by William Isted](Images/photo-1547343052-1f5e556d53d6.jpeg)<br/>
<sub>Photo by William Isted<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.5, and Swift 5.2.4

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* It would be useful to understand something about [Polymorphism](https://stevenpcurtis.medium.com/polymorphism-in-swift-3b35d354e875) in Swift.
* You should be aware of the types of [method dispatch in Swift](https://stevenpcurtis.medium.com/method-dispatch-in-swift-protocols-and-inheritance-548743a6be1f)

## Terminology:
Double Dispatch: A mechanism that dispatches a function call to different concrete functions depending on the runtime types of two objects involved in the call
Polymorphism: This is the ability of an object to take on many forms, with a common using being a parent class reference to refer to a child class object

# Introduction

Double Dispatch is a technique used to invoke an overload method where parameters vary among an inheritance hierarchy.

The [Visitor Pattern](https://stevenpcurtis.medium.com/the-visitor-design-pattern-in-swift-d78bb517431a) is build upon the double dispatch principle. So what is it?

# Double Dispatch
Double Dispatch solves the problem of how to dispatch a message to different methods depending not only on the receiver, but also depending on the arguments.

In Swift we typically set up a `Visitor` protocol that allows us to perform some operations depending on the classes used. In this example there are two different items that can be used, either a `Shape` or a `Dot`

```swift
protocol Visitor {
    func visit(s: Shape)
    func visit(d: Dot)
}
```

These operations will differ depending on the object chosen (in this case a `Shape` or a `Dot`), which conforms to the `Visitor` protocol and performs the appropriate action. 

```swift
class Draw: Visitor {
    func visit(s: Shape) {
        print ("Drew Shape")
    }
    
    func visit(d: Dot) {
        print ("Drew Dot")
    }
}
```

The Visitable protocol allows the object to accept an operation:

```swift
protocol Visitable {
    func accept(_ v: Visitor)
}
```

In both these examples self is used as in each case the compiler knows which class the self refers to, meaning we can safely visit the "correct" visit function.

We set up a shape can adopt the graphic protocol.

```swift
class Shape: Visitable {
    func accept(_ v: Visitor) {
        v.visit(s: self)
    }
}

class Dot: Shape {
    override func accept(_ v: Visitor) {
        v.visit(d: self)
    }
}
```

Then we can call accept on the object, giving it an operation to function on. Fantastic!

```swift
let visitor = Draw()
let shape = Shape()
shape.accept(visitor) // Drew Shape

let dot = Dot()
dot.accept(visitor) // Drew Dot
```

# A more complex example
Some might appreciate a more complex example of double dispatch. Take a look and have fun with it!

```swift
protocol Visitable {
    func accept(_ visitor: Visitor)
}

protocol Visitor {
    func visit(rectangle: Rectangle)
    func visit(circle: Circle)
}

class Rectangle: Visitable {
    let width: Double
    let height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func accept(_ visitor: Visitor) {
        visitor.visit(rectangle: self)
    }
}

class Circle: Visitable {
    let radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    func accept(_ visitor: Visitor) {
        visitor.visit(circle: self)
    }
}

class AreaCalculator: Visitor {
    func visit(rectangle: Rectangle) {
        let area = rectangle.width * rectangle.height
        print("Area: \(area)")
    }

    func visit(circle: Circle) {
        let area = Double.pi * pow(circle.radius, 2)
        print("Area: \(area)")
    }
}

let rectangle = Rectangle(width: 10, height: 5)
let circle = Circle(radius: 3)
let areaCalculator = AreaCalculator()

rectangle.accept(areaCalculator) // Area: 50.0
circle.accept(areaCalculator) // Area: 28.274333882308138
```

It's a little more complex, but it has pretty much the same ideas as the example above.

# Conclusion
That's double dispatch. I hope that you enjoyed reading this article.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
