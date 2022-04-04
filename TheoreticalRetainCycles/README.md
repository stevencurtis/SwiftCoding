# Retain Cycles and Memory Management in Swift
## All aboard the ARC!

# Prerequisites:
- Be able to produce a "Hello, World!" iOS application (guide HERE)

# Terminology
Retain cycles: This is the state when two objects hold weak references to one another. Since the first object's reference count cannot be 0 until the second object is released, and the second object's reference count cannot be 0 until the first objet is released neither object can be released! It is self-evident that it is not possible to create retain cycles with value types, as they are passed by value.
Memory footprint: the amount of memory that a program uses or references. The more resources that are used, the larger the footprint. If objects are not released the occupied memory will grow, leading to memory warning and crashes.
Memory leak: A memory leak is a portion of memory that will never be used, yet is held onto forever. It is both a waste of space and can cause including crashes for the end-user.

# Avoiding Retain cycles
## Understanding ARC
Swift uses Automatic Reference Counting (ARC) to manage memory in an App. This means that Swift automatically releases memory which is no longer used in the App - this is rather fantastic and means that we can deliver a great user experience!

ARC only applies to *reference types* (that is, classes) and in this article the terms classes and objects are used for the instances that need to be managed in this way.

When an object is created, it's reference count will be set at 1. Each time a strong reference is made to the object this count will be incremented by one. Each time an object is released (deallocated) the count will be decremented by 1. When an object's reference count reaches zero, it will be released by the system and the memory used released to the system.

## A Retain Cycle
**The Abstract Example**
A retain cycle (also known as a reference cycle) is when two objects hold a strong reference to one another. An example of this is shown below:

![Images/StrongReferenceCycle.png](Images/StrongReferenceCycle.png)

`Object A` is holding a strong reference to `Object B`, and `Object B` is also holding a strong reference to `Object B`.
When this situation is created, neither `Object A` nor `Object B` can ever be released by the system, so the amount of memory it takes to store these objects is held on forever.

# The Code Example
## Strong References
A coding problem might be that one or more students attend a tutorial. The danger is that the tutorial holds a strong reference to the student, and the student holds a strong reference to the tutorial.
A simplified diagram for this might be:

![Images/studenttracherinstancesmall.png](Images/studenttracherinstancesmall.png)

The Code
In code we might have something like the following:

```swift
class Tutorial {
    private var students = [Student]()
    func enroll(_ student: Student) {
        students.append(student)
    }
    init() {
        print ("Tutorial initialized")
    }
    deinit {
        print ("Tutorial deinitialized")
    }
}

class Student {
    private var tutorial : Tutorial
    private var name : String
    init(tutorial: Tutorial, name: String) {
        print ("Tutorial initialized")
        self.tutorial = tutorial
        self.name = name
    }
    deinit {
        print ("Tutorial deinitialized")
    }
}

var computing : Tutorial? = Tutorial()
var dave : Student? = Student(tutorial: computing!, name: "Dave")
computing?.enroll(dave!)

computing = nil
dave = nil
```

As you can see from the last two lines we are setting our `Tutorial` and `Student` instances to be nil. You might think that both instances would be released, but here is the thing. `deinit` for either instance isn't called!

## A Note On Force-Unwrapping
NOTE: Please don't use force-unwrapping in your production code. It is used here to try to make this article easier to read. Please take a look at my force unwrapping article for reasons why this isn't a good idea: [Avoiding Force Unwrapping in Swift](https://stevenpcurtis.medium.com/avoiding-force-unwrapping-in-swift-6dae252e970e)

## A Detailed Look
We can look into the `computing` and `student` instances we have created
Everything is fine, and works as expected while we have the strong references for computing and student, but the link between Tutorial and Student means that these objects are never released by the system.

![Images/TutorialStudentInstancesmall.png](Images/TutorialStudentInstancesmall.png)

## Solutions?
**Use a struct**
ARC doesn't apply to struct in Swift. This means that we can code the same functionality in Swift avoiding classes altogether!

```swift
struct Tutorial {
    private var students = [Student]()
    mutating func enroll(_ student: Student) {
        students.append(student)
    }
}

struct Student {
    var tutorial : Tutorial
    var name : String
    init(tutorial: Tutorial, name: String) {
        self.tutorial = tutorial
        self.name = name
    }
}

var computing : Tutorial? = Tutorial()
var dave : Student? = Student(tutorial: computing!, name: "Dave")
computing?.enroll(dave!)

computing = nil
dave = nil
```

There is no deinitializer to call in this case, but when the instances are set to nil the `struct` are released so we really do have a great solution!

## Use a weak reference
Since the `Tutorial` instance is holding onto the `Student` instance and vice-versa, the memory for both are never released.
We can use a `weak` reference (I've a full article on that topic if you want a deeper dive  https://stevenpcurtis.medium.com/swift-self-weak-or-unowned-7e2327974f36)

```swift
class Tutorial {
    private var students = [Student]()
    func enroll(_ student: Student) {
        students.append(student)
    }
    init() {
        print ("Tutorial initialized")
    }
    deinit {
        print ("Tutorial deinitialized")
    }
}

class Student {
    weak var tutorial : Tutorial? = nil
    private var name : String
    init(tutorial: Tutorial, name: String) {
        print ("Student initialized")
        self.tutorial = tutorial
        self.name = name
    }
    deinit {
        self.tutorial = nil
        print ("Student deinitialized")
    }
}

var computing : Tutorial? = Tutorial()
var dave : Student? = Student(tutorial: computing!, name: "Dave")
computing?.enroll(dave!)
computing = nil
dave = nil
```

Output:
```
Tutorial initialized
Student initialized
Tutorial deinitialized
Student deinitialized
```

**Weak or unowned**

There is an alternative to weak references - unowned. 
The difference between weak and unowned is quite technical, but here is a quick guide to when to use them:
Use a weak reference when the other instance has a shorter lifetime.
Use an unowned reference when the other instance has the same lifetime or a longer lifetime.

# Closures
## Strong
In the case of reference types (in this case class and class-bound protocol types) we can specify weak or unowned to specify whether the reference is (well) weak or unowned.
Commonly this means the classic warnings we get from the compiler when we write something like the following, which commonly occurs when using a [ViewController and ViewModel in your architecture](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fmvvm-in-swift-19ba3f87ed45):

```
viewModel.articlesDidChange = { value in
    self.value = value
}
```

By default Swift uses strong capturing, which means that it creates a strong reference to the values used inside a closure.
This example might be for some newspaper articles that the viewModel obtains from somewhere (a network call, perhaps) which communicates this change and perhaps presents the data to the user.
Unfortunately with the closure as presented above, the viewModel has a strong reference to the articlesDidChange closure and this closure has a strong reference to self (which is the viewController). This is a classic case of a reference cycle as the ViewController and ViewModel will never be able to be deallocated.

The canonical solution is to create a weak reference to self, meaning that we can release the `ViewController` when the time comes.
Since self is now an optional and can either be a value or nil, we append ? to self. By making this a weak reference we no longer risk the retain cycle! Wonderful!

```
viewModel.articlesDidChange = { [weak self] value in
    self?.value = value
}
```

As an alternative, we might choose to place a [guard](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fprecondition-assert-fatal-error-or-guard-in-your-swift-code-5f9297658be0) before self is used, which would give a code snippet like the following:

```
viewModel.articlesDidChange = { [weak self] value in
    guard let self = self else {return}
    self.value = value
}
```

Either solution works, and of course we may choose to use an unowned reference as explained earlier in the article.

# Conclusion
It does feel like a technical consideration, retain cycles with the cognitive work around it. However, we might consider that this is something that directly impacts the user and their experience of the App - reference cycles can even lead to an App crashing at an embarrassing moment?
If you don't want to avoid crashes, perhaps you might think about pursuing a new line of work!
If you've any questions, comments or suggestions please hit me up on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)
Any questions? You can get in touch with me [here](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fprofile)
