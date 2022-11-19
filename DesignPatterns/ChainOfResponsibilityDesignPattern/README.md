# The Chain of Responsibility Pattern in Swift
## Pass a request along until someone handles it!

![Photo by Joseph Barrientos](Images/photo-1449034446853-66c86144b0ad.jpeg)<br/>
<sub>Photo by Joseph Barrientos<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.5 and Swift 5.2.4

The chain of responsibility is an OO version of `if ... else ``` in a way that promotes the idea of loose coupling within your App.

## Prerequisites: 
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

# Terminology:
Design Pattern: a general, reusable solution to a commonly occurring problem

# Comparison with the decorator design pattern 
The chain of responsibility pattern is very similar to the [decorator pattern](DecoratorDesignPattern), but only one of the objects in the chain of responsibility.

# First responder
Effectively you give multiple objects the opportunity to process a request. One great example of the Chain of Responsibility is the concept of responders.

`UIKit` starts with the first responder control that activated the keyboard, and then passes the call up the chain until a component can deal with the action.

# Example
There are many animals that need to be handled in a zoo. It is pertinent that any given animal is handled by the lowest status handler that can control them.

As a result, there are 5 animals that are in increasing order:

```swift
enum Animal: Int, Comparable {
    case cat
    case dog
    case wolf
    case fox
    case elephant
    static func < (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
```

Each handler will conform to a protocol:

```swift
protocol Handler {
    var next: Handler? { get }
    func handle(request: Animal)
}
```

we then have some logic for each handler that means if they cannot handle the animal they pass it on to the next handler in the chain

```swift
class DogHandler: Handler {
    func handle(request: Animal) {
        if request > .dog {
            next?.handle(request: request)
        } else {
            print ("Handled by the dog handler")
        }

    }
    var next: Handler?
}

class WolfHandler: Handler {
    func handle(request: Animal){
        if request > .wolf {
            next?.handle(request: request)
        } else {
            print ("Handled by the wolf handler")
        }
    }
    var next: Handler?
}

class ElephantHandler: Handler {
    func handle(request: Animal){
        if request > .elephant {
            next?.handle(request: request)
        } else {
            print ("Handled by the elephant handler")
        }
    }
    var next: Handler?
}
```

This then needs to be called and set up which can be performed using the following code:

```swift
let dogHandler = DogHandler()
let wolfHandler = WolfHandler()
let elephantHandler = ElephantHandler()

dogHandler.next = wolfHandler
wolfHandler.next = elephantHandler

dogHandler.handle(request: Animal.cat) // handled by the dog handler
dogHandler.handle(request: Animal.elephant) // handled by the elephant handler
```

# Conclusion
The chain of responsibility pattern is used to achieve loose coupling in software design. This article has given some examples of just that, and I hope that it has helped you out with your coding journey.
Good luck!

If you've any questions, comments, or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
