## The Lazy Variables: What and Why in Swift
# lazy var innit (not init)


Difficulty: Beginner | **Easy** | Normal | Challenging

---

Prerequisites:
Be able to [code Swift using Playgrounds](https://stevenpcurtis.medium.com/coding-in-swift-playgrounds-1a5563efa089)
Some knowledge of [closures would be useful](https://medium.com/swift-coding/swift-closures-c14cb7aa2170)

---

# Terminology
closure: A self-contained block of functionality that can be passed around
lazy variables: A technique in that a property is only created when it is needed

---

# Motivation
I recently completed a rather [fantastic date manager](https://medium.com/p/619cb951ee0f/edit) in Swift, that creates the dateFormatter as a lazy var.

```swift
private lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    return dateFormatter
}()
```

The way this closure works is interesting, and demands more attention than can be given in a couple of sentences.
So let us press on!

---

# The step-by-step
Properties can be rather easily set up, for example here an optional name
```swift
var name: String?
```

which can of course form part of a class or struct, using an initialiser.
```swift
class Person {
    var name: String?
    init(name: String) {
         self.name = name
    }
}
```
but what if we need more complex initialisation of the property?
This is where `closures` come in. The setup of these can be close to the property declaration (rather than hidden in the initializer)
```swift
class Person {
    var name: String?
    init(name: String) { self.name = name }
    let stagesOfLife: [String] = {
["Infancy","Schoolboy", "Teenager", "Youn man", "Middle aged", "Old man" , "Dotage and death"]
    }()
}
let dave = Person(name: "Dave")
dave.stagesOfLife[0] // Infancy
```
What is important here is that the closure is called when the property is initialized, and the trailing () in the code indicates that the closure need to be executed.

# Let us be lazy
Executing the `property` closure above is totally fine, and would of course happen just once when the class `Person` is initialized.

## The example
You can, however, use the lazy keyword to indicate that you only want the property closure to be executed the first time it is used.
Let us see an example that is really quite similar to the last one
```swift
class Person {
    var name: String?
    init(name: String) { self.name = name }
lazy var stagesOfLife: [String] = {
["Infancy","Schoolboy", "Teenager", "Youn man", "Middle aged", "Old man" , "Dotage and death"]
    }()
}
let dave = Person(name: "Dave")
dave.stagesOfLife[0] // Infancy
```

notice that the lazy property needs to be a var. Why? Because this is calculated at runtime meaning that we do not know the value of the property until it is run (in other words it would need to be changed as runtime, and must therefore be a var rather than a constant let).

## The example for a property reliant on self
You can use a lazy var like a computed property, but it is run just once (on demand). This means the following is possible:

```swift
class Dog {
    var owner: String
    lazy var name: String = {
        return "poodle\(owner)"
    }()
    
    init(owner: String) {
        self.owner = owner
    }
}

let dog = Dog(owner: "Keith")
dog.name
```

Which of course is only called when the name of the dog is called.

## Why use a lazy property
If the property is dependent on other property on the class (or in fact self) lazy is a great way to square the circle - because when the lazy property is called the initilization is complete.

Lazy vars are only run once after initilization, so if the property requires a computationally expensive setup this can be deferred until it is needed.

---

# Conclusion
A **lazy var** gives you another option in your Swift toolbag. Want to delay the computation of a variable, or even you might be unsure whether the property will ever be called - a **lazy var** is your thing.
As ever, don't overuse your powers programmers!

---

Extend your knowledge
Apple have documentation around date and time

---

Questions
You can get in touch with me on Twitter; I'm usually available on Twitter so can get back to you…fast
