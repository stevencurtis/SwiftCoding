# Swift's Future Class
## It's not the future now, it's the past


Waaaay back in 2020 I created an article about the [core concepts of combine](
https://stevenpcurtis.medium.com/core-concepts-of-combine-71d6b13d43e2) but I'm not satisfied with the practicality of the `Future` section. This is something I wanted to put right, and this article is intended to do exactly that.

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

## Terminology
Future: A publisher that eventually produces a single value and then finishes or fails.
Promise: An object returned by an asynchronous function, which represents the current state of the operation.

# Apple's documentation
Apple have of course provided us with some [documentation](https://developer.apple.com/documentation/combine/future).

and they show the *declaration* for the `class`

```swift
final class Future<Output, Failure> where Failure : Error
```

and even some code! I'm sure you (like me) find that the documentation from Apple has got better over time, but still is lacking in providing real-life examples which I can directly work from.

They give an example of a function that will publish a random number after a two-second delay.

```swift
func generateAsyncRandomNumberFromFuture() -> Future <Int, Never> {
    return Future() { promise in
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let number = Int.random(in: 1...10)
            promise(Result.success(number))
        }
    }
}
```

This published value can then be received from a `Combine` subscriber. The example uses `Subscribers.Sink` to do so in the code block below:

```swift
cancellable = generateAsyncRandomNumberFromFuture()
    .sink { number in print("Got random number \(number).") }
```

Inevitably in the documentation they haven't set up a property for `cancellable` which is OK, yet it's so long since I've used combine that it is actually quite hard to remember how to do this stuff. To help you out, this code is all in the repo on GitHub (which I hope helps everyone) but to keep this article self-sufficient here is the property:

```swift
var cancellable: AnyCancellable?
```

which I've then assigned in the initializer in my view controller in the project. And you know what, it works and gives the output

```swift
Got random number 3.
```

Of course the output is random so if you run the code (even from the same repo) you might get a different answer. 

What is happening is a single element is being published asynchronously and a closure is being called that fulfils the Promise (actually a `Future.Promise` called with a `Result`).

- How Apple combines (sigh) `Future` with async-await.

Apple introduced async-await in Swift 5.5 and many people have thought Combine (and `Future`) to be dead after it's introduction. I don't think that, I believe that Combine is useful for many circumstances but it has opened the door to the combination (sigh) of the technologies.

```swift
func futureWithConcurrency() async {
    let number = await generateAsyncRandomNumberFromFuture().value
    print("Got a random number \(number).")
}
```

Since this is an `async` function, to successfully call it we would need to call this from within a `Task` which allows us to create an environment for `futureWithConcurrency` from a non-concurrent method (in the case of the example `init`), calling it using `await`.

```swift
Task {
    await futureWithConcurrency()
}
```


# The Code
I would previously use [Result type](https://medium.com/swlh/result-type-in-swift-1b4e2a84f2c2) to be able to return a success or failure. `Future` does a similar job

# Use Future To Return an Async Response
## The nuts and bolts
By wrapping an asynchronous operation in a `Future` we can not only use the Combine API, but this opens the door to Swift's concurrency features.

The following example uses `DispatchQueue.main.asyncAfter` as an asynchronous operation (you'd usually have a network call in there, I've cut this implementation down so you'll just see a response after a second).

```swift
Future { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        promise(.failure(NSError(domain: "", code: 0, userInfo: nil)))
    }
}
```

This returns a failure. We can also (alternatively) return a success. Something like the following would suffice:

```swift
Future { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        promise(
            .success(
                .init(
                    page: 0,
                    perPage: 0,
                    total: 0,
                    totalPages: 0,
                    data: [],
                    support: .init(url: "", text: "")
                )
            )
        )
    }
}
```

Yes, the `.success` has a wholly artificial response but I'm sure you'll bare with me.

## How a ViewModel-ViewController pair might work
**ViewModel**

We are simulating a download from an external API. We might get something like the following:

```swift
final class ViewModel {
    func download() -> Future<Users, Error> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            }
        }
    }
}
```

**ViewController**
We would then need to call this function from our ViewController. I wouldn't necessarily always call this from `viewDidAppear` but needs must (and this is probably a more sensible place than `viewDidLoad`)

```swift
var subscriptions = Set<AnyCancellable>()

override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.download()
        .sink(receiveCompletion: {
            switch $0 {
            case .failure:
                print("error")
            case .finished:
                print("finished")
            }
        }, receiveValue: {
            print("Users received: \($0)")
        })
        .store(in: &subscriptions)
}
```
I'm not doing anything exciting with the result of download here, just printing to the console.

Note that at the top of the class we have the line.

```swift
var subscriptions = Set<AnyCancellable>()
```

So `AnyCancellable` is (according to Apple) *A type-erasing cancellable object that executes a provided closure when canceled* and it really is the last piece of that sentence which interests us at this point.

Looking at the documentation again, "An `AnyCancellable` instance automatically calls `cancel()` when deinitialized.". So when we `deinit` the `ViewController` (and therefore our subscriptions) each of the type-erased set will be cancelled. This is wonderful because we don't have to worry about retaining those properties.

*What about that sink?*
We are attaching a subscriber, and use `sink(receiveCompletion:receiveValue:)` to observe values. The output? If we have a failure: error. If we successfully get information from our "API" (of course this is simply our delay) we'll get the following output:

```swift
Users received: Users(page: 0, perPage: 0, total: 0, totalPages: 0, data: [], support: FuturesBasic.Users.Support(url: "", text: ""))
finished
```

**Testing**
We can test the view model using the following code. It's just a start (as in, it's not perfect) but might give you an idea of where testing futures could go.

```swift
final class FuturesBasicTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    let viewModel = ViewModel()
    
    func testReceiveCompletion() {
        let expect = expectation(description: #function)
        viewModel.download()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        expect.fulfill()
                    case .failure:
                        XCTFail()
                    }
                },
                receiveValue: { _ in})
            .store(in: &subscriptions)
        
        waitForExpectations(timeout: 3)
    }
    
    func testReceiveValue() {
        let expect = expectation(description: #function)
        let expected: Users = .init(
            page: 0,
            perPage: 0,
            total: 0,
            totalPages: 0,
            data: [],
            support: .init(url: "", text: "")
        )
        viewModel.download()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    XCTAssertEqual(expected, $0)
                    expect.fulfill()
                })
            .store(in: &subscriptions)
        
        waitForExpectations(timeout: 3)
    }
}
```

# Conclusion

Thank you for reading. This is an article about Futures, and the basic use of the same in Swift code. I hope that helps you.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
