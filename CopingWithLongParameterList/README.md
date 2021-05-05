# Coping with a long parameter list in Swift
## Real-life Problems == Solved

# Before we start
Difficulty: Beginner | **Easy** | Normal | Challenging<br>
This article has been developed using Xcode 12.2, and Swift 5.3

## Prerequisites
* You'll need to either be able to write [an iOS application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) or write some Swift code in [Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)

## Keywords and Terminology
Initialization: The process of preparing an instance of a class, structure, or enumeration for use
Parameter: A special kind of variable referring to a piece of data passed to a function

# The high-level stuff
## The problem
You might be a *most excellent coder* and separate out your UI code from your business logic. You might then notice that some of your business logic classes have rather long parameter lists, and you might have heard that having more than three or four (this is one of *those rules* is a code smell. 

Oh dear and oh my or oh my goodness. We must be able to fix that in order to pass our code review. 

## The feedback you might receive
You might be told that a long parameter list is contradictory (as in the network manager example below) or confusing. Depending on the techniques you use, it may be difficult for you to determine whether an object has all of the data it needs in order to be instantiated. You might be told that it is hard to provide the parameters in the correct order as it is not clear what each one does.

## Some solutions
This problem is often caused by a function trying to do too much (that is violate the [Single Responsibility Principle](https://stevenpcurtis.medium.com/the-solid-principle-applied-to-swift-974e29b94d23)

## Replace a parameter where we can derive the data
You may be able to derive one or more of your parameters from the other parameters that are passed. For example if you are dealing with width, height and volume as three parameters volume can be calculated by multiplying width and height, meaning that just two parameters are needed. 

More likely, you may be working out some UI element sizes according to an `enum`.

This can be called with 

```swift
let viewWidth = self.view.frame.width
let sizeRatio = ratio(width: viewWidth, size: .small)
``` 

where the enum and the function is:

```swift
enum UserSize: Double {
    case small = 0.8
    case medium = 1.0
    case large = 1.2
}

func ratio(width: CGFloat, size: UserSize) -> CGFloat {
    return width * CGFloat(size.rawValue)
}
```

rather than passing the width, an alternative here is to use the view's width from within the function, removing one of the parameters from the function.

```swift
func ratio(size: UserSize) -> CGFloat {
    return self.view.frame.width * CGFloat(size.rawValue)
}
```

If we derive the data from existing parameters, we are simplifying the function. However, in the case of using an available parameter like the view we are restricting where the function will be usable - so care should be taken in that case.

## Replace
Rather than using several values from an object, you can pass the whole object instead.
So you might have the following `averageHeight` function

```swift
_ = averageHeight(lowValue: 1, highValue: 3, n: 3)
func averageHeight(lowValue: Double, highValue: Double, n: Int) -> Double {
    return highValue - lowValue / Double(n)
}
```

A refactored version of this is with Swift's [Variadic parameters](https://medium.com/@stevenpcurtis.sc/let-swift-organise-an-array-for-you-using-variadic-parameters-e78add1e5ca2), and excuse the [force-unwrapping](https://medium.com/@stevenpcurtis.sc/avoiding-force-unwrapping-in-swift-6dae252e970e).

and we just pass all the values to the function, and reduce the complexity of the parameters that we need to use:

```swift
_ = averageHeight(values: 1,2,3)
func averageHeight(values: Double...) -> Double {
    return values.max()! - values.min()! / Double(values.count)
}
```

this does mean that our method has a potentially more limited interface, however. This is, as ever, an "it depends" answer to solve the problem of long parameter lists. 

## Using a data object
It is possible to use a data object to pass information to a class or function. However, there is a question about whether you should be doing this if you only use that data class one time - creating a one time class (or, perhaps a [tuple](https://medium.com/p/5ee9106283be) although that is a [value type](https://medium.com/swlh/value-and-reference-types-in-swift-3abf240edba).

```swift
func studentScore(name: String, age: Int, testScore: Int, testSubject: String){
    print ("\(name): \(age) got \(test) out of 10")
}
```

which can be refactored into the following:

```swift
struct Test {
    let testScore: Int
    let testSubject: String
    init (testSubject: String, testScore: Int) {
        self.testSubject = testSubject
        self.testScore = testScore
    }
}

struct Student {
    let name: String
    let age: Int
    init (name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

func studentScore(test: Test, student: Student){
    print ("\(student.name): \(student.age) got \(test.testScore) out of 10")
}
```

Which does use [Swift interpolation](https://medium.com/swlh/string-interpolation-in-swift-c66b7bac9fd1) in the example.

Now this looks like we haven't achieved anything, after all we have the same number of parameters just "moved" to the data object. The point is that this is understandable, and when we call `studentScore` we just have one parameter to deal with. In this example, you can claim that we haven't solved a problem here, that there should be *two* objects here (one for Test and one for Student) and that is getting to the heart of the problem - this should be much easier to read and understand.

# The example
## Network managers
Ok, this is something that you really should have by now. A nice little network manager module that you can use and import and export to your projects at will.

In the deep and distant past I developed a [basic network manager](https://medium.com/@stevenpcurtis.sc/my-basic-httpmanager-in-swift-db2be1e340c2), that I then updated with an [updated network layer](https://stevenpcurtis.medium.com/write-a-network-layer-in-swift-388fbb5d9497).

I did notice that one of the most essential things that I changed was the **initialization** process. 

## A poor initialization process
This came as part of adding to the functionality of the network library, that is adding more than just get and post up to making all of these [REST methods](https://medium.com/@stevenpcurtis.sc/rest-and-crud-ca5522bf3fc3):

* GET
* POST
* PATCH
* PUT
* DELETE

all work.

However, we don't need to pass data in the same way for all of these methods for example only a post has body data.

To solve this, here is a naive function signature:

`fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, body: [String: Any], completionBlock: @escaping (Result<Data, Error>)`

Note that [default arguments](https://medium.com/@stevenpcurtis.sc/overcoming-default-arguments-in-a-protocol-27427b9ed275) are used (and the article goes on to overcome issues in using default parameters in a protocol). 

This is a **classic** case of a function that is doing too much! 

## A better initialization process
Essentially I'm making a better interface, one for each of the [REST methods](https://medium.com/@stevenpcurtis.sc/rest-and-crud-ca5522bf3fc3). I'd usually do that with a [protocol](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18), but here I actually opted for an enum with associated values (get me!):

```swift
public enum HTTPMethod {
    case get(headers: [String : String] = [:], token: String? = nil)
    case post(headers: [String : String] = [:], token: String? = nil, body: [String: Any])
    case put(headers: [String : String] = [:], token: String? = nil)
    case delete(headers: [String : String] = [:], token: String? = nil)
    case patch(headers: [String : String] = [:], token: String? = nil)
}
```

this meant that only the required data would be used for each of the HTTP Methods, which is then passed into my fetch function:

```swift
func fetch(url: URL, method: HTTPMethod, completionBlock: @escaping (Result<Data, Error>) -> Void)
```

which is rather wonderful! Job done! Fewer Parameters.

Also note: There are multiple functions (this is fetch, but I'm sure you can think of others).

# Conclusion
Limiting the parameters is something you should really think about when coding in Swift. This article has gone through some of the ways in which you can limit the number of parameters you might use, and even come up with an example you might use.

I hope this article has helped you out a little bit, and helped you on your coding journey.

There are always different methods, with varying outcomes to overcome coding challenges. You might have other methods of doing the same - let me know!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
