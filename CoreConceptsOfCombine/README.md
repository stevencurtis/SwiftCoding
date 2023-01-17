# Core Concepts of Combine
## Publisher, Subscriber, Operators and Subjects

No matter your coding background, you will need to get to grips with some of the core concepts of `Combine`, what it does and how to perform some programming tasks in the same.

This article is here to help you!

# What is Combine?
`Combine` is about what to do with values over time, including how they can fail.

This means that `Combine` uses many of the functional reactive concepts that are used by `RxSwift` (if you are familiar with that), but is Apple's implementation is baked-in to the iOS SDK meaning it has the advantages of Swift, being [type-safe](https://medium.com/@stevenpcurtis.sc/why-type-safety-is-essential-in-swift-363a5fd2a795) and usable with any asynchronous `API`.

In addition to [functional programming](https://medium.com/macoclock/imperative-vs-declarative-programming-swift-fa538e01a7ba) primitives like `map`, `filter`, and `reduce` you can split and merge streams of data.

These **steams** are important as we can visualise events (keyboard taps, touches etc.) as such a stream that can be observed. [The observer pattern](https://medium.com/swift-coding/the-observer-pattern-in-swift-97a0e6fafa58) watches an object over time, notifying changes - and applied over time this would produce a stream of objects.

So `Combine` helps developers implement code that functionally describes actions that should be taken when data is received in such a **stream**.

When applied to an `API`, `Combine` allows us to handle errors as they happen and more easily process data that relies on asynchronous `API`. Applied to a UI, we can think of the user actions as a **stream**, and even test particular states that a host App can be in.

A good partner for `Combine` is `SwiftUI`, yet there is no reason why you can't use `UIKit` to use `Combine`, the same way as we could happily use `RxSwift` with `UIKit`. [I've created an example with a network manager that you might like to take a look at](https://medium.com/@stevenpcurtis.sc/core-concepts-of-combine-71d6b13d43e2).

Understood. Let me describe them:

# The core concepts
## Publishers
These generate the value(s) in question, and allow the registration of a subscriber.

Under the hood, Publishers conform to the `protocol` `Publisher` that defines two `associatedtype`, that is **output** is the value that is produced by the publisher and a **Failure** that represents the error produced by a `publisher`.

So a `Publisher` provides data when available (and also potentially on request). A `Combine` publisher that does not have any subscribers will not provide any data.

So you might create a `publisher` that returns a `boolean` and an `error` type. If you don't need the error, you can use [Never](https://medium.com/@stevenpcurtis.sc/dont-return-never-in-swift-e427cdb63a9b):
```swift
var validLengthPassword: AnyPublisher<Bool, Never>
```

which could also be represented by any instance of an `Error` type (where you have declared `MyError` somewhere with something like `struct MyError: Error {}`):

```swift
var validLengthPassword: AnyPublisher<Bool, MyError>
```

## Subscribers
Subscribers subscribe to a `Publisher`.

Under the hood, `Subscribers` also have two `associatedtype`, that is input that is the value that is produced by the `publisher` and a **Failure** that represents the error produced by a `publisher`.

A `subscriber` subscribes to a `Publisher`, and in effect requests updates about a data stream (including any failures). The `Subscriber` makes requests of the `Publisher` (and without such a subscription data will not be generated and passed).

To make this clear, when a `Publisher` subscribes to a `Subscriber` the types of each (the `Publisher` and `Subscriber`) must match: Output-Input Failure-Failure.

## Operators

`Publishers` have operators and act on the values received from a `Publisher` and effectively republishes the results. This means that between `Publisher` and `Subscribers` there can be any number `Operators` that chain sequences of actions.

But how can we make this practical?

# The Examples
`Just`
What if we want something simple, that can't fail. Something that will emit a single value and then finish.
```swift
let myPublisher = Just(13)
```
now this is a `Just<Int>(output: 13)` but since this is a `Publisher` it won't emit anything without a `Subscriber`, so we need to fix that.

We would expect a subscriber to receive the value 13.

Happily:

```swift
let subscribeMyPublisher = myPublisher.sink { int in
    print("Value: \(int)")
}
```
Does indeed print `Value: 13`

`Empty`

`Empty` never emits and (as per default) immediately completes. This means the following compiles just fine:

```swift
let empty = Empty<Int, Never>()
let subscribeEmpty = empty.sink { int in
     print("Value: \(int)")
}
```

However, the value will never be printed. Of course, there will also be no `Error` type either.

`Fail`

If we wish to immediately fail without emitting a type, `Fail` has us covered.
```swift
let fail = Fail<Any, MyError>(error: MyError())
```

`sink`

You can see in the examples above, `.sink` which is the code that receives data, completion events or errors from a publisher and processes them.

There are two parts to the `sink`, that is we can subscribe to the `Just` 13 publisher described above (repeated here but you don't need to repeat it if you are following along with the code).

```swift
let myPublisher = Just(13)
let cancellable: AnyCancellable = myPublisher.sink(
    receiveCompletion: { completion in
        print("cancellable completion \(completion)")
},
    receiveValue: { value in
        print("cancellable value \(value)")
}
)
```

The code then outputs the following:
```swift
cancellable value 13
cancellable completion finished
```

`.publisher`, subscribed to

Any `Sequence` ( `Array`, or anything that conforms to the `Sequence` `Protocol`)

```swift
let integerPublisher = [0, 1, 2, 3, 4, 5].publisher
let subscribeInteger = integerPublisher.sink { value in
    print ("Values from integerPublisher \(value)")
}
```

Now `subscribeInteger` is of type `AnyCancellable` which is a token for a new `subscription`. This token must be retained, since as soon as the token is deallocated the `subscription` will be cancelled - hence the `Cancellable` part of the type!

Therefore it is prudent to (in implementation) to separate out the declaration as in:

```swift
let storeCancellable: AnyCancellable
storeCancellable = integerPublisher
    .sink { value in
        print ("Values from storeCancellable \(value)")
}
```

So then this can be stored outside the method that it is being called from.

```swift
var cancellableCollection = [AnyCancellable]()
integerPublisher
    .sink { value in
        print ("Values from storeCancellable \(value)")
}.store(in: &cancellableCollection)
```

Now in terms of memory management **AnyCancellable** calls **cancel()** on `deinit` to prevent reference cycles. Awesome!

These are exactly the same when observed as the property of an object so something like the following is implicitly valid:

```swift
class LoginViewModel {
    var shouldNav: AnyPublisher<Bool, Never>?
}
```

`PassthroughSubject`

A `PassthroughSubject` is an instance that can have several `subscribers` attached, and is an `Operator` as described above. `PassthroughSubject` itself does not maintain a state, but rather (as the name suggests) pass through a value. A `send()` call will send values to `Subscribers` (previous to this, `subscribers` will not receive any values).

This is *so* useful in creating tests, but also in converting imperative code to be used in the world of `Combine`.

The bare bones of this can be expressed with the following code:

```swift
var passThroughSubject = PassthroughSubject<Int, Never>()
let pass = passThroughSubject.sink( 
    receiveValue: value in { print("passThroughSubject \(value)" ) }
)
passThroughSubject.send(1)
```

which of course prints `passThroughSubject 1`

`CurrentValueSubject`

This is another `Operator`, but if you require some semblance of state, that is the current value we can use `CurrentValueSubject`

```swift
var currentSubject = CurrentValueSubject<Int, Never>(10)
let current = currentSubject.sink(receiveValue: { value in 
    print("currentSubject \(value)" ) }
)
currentSubject.send(1)
```
Since we have a current value this can be changed and retrieved with the following:
```swift
print ( currentSubject.value )
currentSubject.value = 5
```

`handleEvents`
This, well, handles events through closures. The events themselves are the following:
- receiveSubscription: Executed when the `publisher` receives the `subscription`
- receiveOutput: Executed when the `publisher` receives a value from the upstream `publisher`
- receiveCompletion: Executed when the `publisher` receives the completion from the upstream `publisher`
- receiveCancel: Executed when the downstream receiver cancels publishing
- receiveRequest: Executed when the `publisher` receives a request for more elements

This works as following (using `MyError()` as described above)

```swift
let passString = PassthroughSubject<String, MyError>()
let stringCancellable = passString.handleEvents(receiveSubscription: { (subscription) in
    print("receiveSubscription!")
}, receiveOutput: { _ in
    print("receiveOutput!")
}, receiveCompletion: { _ in
    print("receiveCompletion")
}, receiveCancel: {
    print("receiveCancel")
})
.replaceError(with: "Failure")
.sink { (value) in
    print("Subscriber received value: \(value)")
}
passString.send("Hello, World!")
passString.send(completion: .failure(MyError()))
```

This generates the following output:

```swift
receiveSubscription!
receiveOutput!
Subscriber received value: Hello, World!
receiveCompletion
Subscriber received value: Failure
```

**Combining operators**

```swift
let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()
let validatCancellable = Publishers
.CombineLatest(usernamePublisher, passwordPublisher)
.map { (username, password) -> Bool in
    username.count > 6 && password.count > 6
}
.eraseToAnyPublisher()
```

This features `eraseToAnyPublisher` which makes the `publisher` visible to a downstream `publisher`.
Would I use the above? Not exactly, as in my example using [Combine and URLSession](https://medium.com/@stevenpcurtis.sc/combine-and-urlsession-in-uikit-68f1caa40ee1) I preferred the following approach (where `validLengthUsername` and `validLengthPassword` are both `AnyPublisher` types:

```swift
var userValidation: AnyPublisher<Bool, Never> {
    validLengthUsername
    .zip(validLengthPassword)
    .map { $0 && $1 }
    .eraseToAnyPublisher()
}
```

`.zip` waits until both publishers have emitted, `.map` provides a transformative closure and as before `.eraseToAnyPublisher()` transforms the `Publisher` to be visible downstream.

Now each of `validLengthPassword` and `validLengthUsername` are similar (and I'll show you the latter here):

```swift
@Published var username: String = ""
var validLengthUsername: AnyPublisher<Bool, Never> {
    return $username.debounce(for: 0.2, scheduler: RunLoop.main)
    .removeDuplicates()
    .map{$0.count >= passwordLength ? true : false}
    .eraseToAnyPublisher()
}
```

now `username` is bound to a `UITextField`, meaning that `debounce` only receives elements when the user pauses or stops typing. `removeDuplicates` ensures that only distinct elements are used.

`Future`

A `Future` is a Publisher that only emits a single value (eventually!). The argument for a future is a closure that takes an argument for a single value. A good use for `Future` is where we wait for something asynchronous (perhaps a network call).

Here are the rules of futures in `Combine`:
- `futures` immediately execute on creation
- `futures` only run their closure once
- multiple `subscriptions` to a `Future` give the same result to each `subscriber`

Therefore we can create the following:
```swift
let future = Future<Bool, Never> { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        promise(.success(true))
    }
}
let fut = future.sink(
    receiveCompletion:
    {
        val in
        print("Future \(val)")
}
,
receiveValue: { val in
    print("Received \(val)")
})
```

In this case `promise(.success(true))` returns after a predetermined length of time (1 second in this case).

# Bind to components
This could almost be a separate article in itself, I'll provide a single example here:
```swift
let validationSub = loginViewModel?.userValidation
.receive(on: RunLoop.main)
.assign(to: \.isEnabled, on: loginView.loginButton)
```

Here we are attaching to a `AnyPublisher<Bool, Never>` in a view model, and when we observe a change we change the `loginButton` accordingly.

This uses keypaths, and works as might be expected.

# Debugging
You might like to set a breakpoint in a .sink , which is tricky. Fear not, Apple have some code that can help you set a breakpoint under a certain condition.

Behold!

```swift
let publisher = PassthroughSubject<String?, Never>()
let cancellable = publisher
    .breakpoint(
        receiveOutput: { value in return value == "DEBUGGER" }
    )
    .breakpointOnError()
    .sink { print("\(String(describing: $0))" , terminator: " ") }
    publisher.send("DEBUGGER")
```

Watch out for that `.breakpointOnError()` code in any case, though and we can print the current state with `.print("Current state")`

# Why would you use Combine, anyway?
It comes down to:
- maintainability
- readability

However, you use of something like `Combine` relies upon knowledge of event-driven code and of course overcome any difficulties in testing the same.

The idea is that we can eliminate some of the common coding problems in Swift, like nested closures and callbacks.

However, when and where you use it is entirely down to you, the developer.

# Conclusion
This article is all about `Combine`. Now since `Combine` has been available for longer than a year it is filtering into production code.

Isn't it time you got with the program?

People do like [Apple's documentation](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.apple.com%2Fdocumentation%2Fcombine) on this topic, and you might want to go there if you wish to get more information on this topic.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)
