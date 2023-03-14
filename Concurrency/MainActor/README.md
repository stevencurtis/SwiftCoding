# Swift Concurrency: Working with MainActor to Manage Task Execution
## We can!

Introduced in Swift 5.5 along with Swift's new concurrency model, `@MainActor' marks a class, struct or function as being run on the main thread.

Let's take a look.
Difficulty: **Beginner** | Easy | Normal | Challenging

This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites
- Be able to produce a ["Hello, World!" SwiftUI project](https://stevenpcurtis.medium.com/hello-world-swiftui-92bcf48a62d3)

It might be nice if you had some knowledge of
- [Actors](https://medium.com/@stevenpcurtis/actors-in-programming-fc6e8e282a75) are a conceptual model used to deal with concurrency

## Keywords and Terminology
@MainActor: is a Swift attribute used to indicate that a type or function must be executed on the main thread.

# Eh, Threads
Threads 
https://medium.com/@stevenpcurtis/swift-threads-the-guide-ed11f35945e6 can be tricky things in programming. Even views shouldn't know about threads, as they are an implementation detail: https://stevenpcurtis.medium.com/swift-views-shouldnt-know-about-threads-3de632cccd47'

We do know that UI rendering should be on the main thread (as should user interaction events). 

## What, what
If you make network calls from the main thread you block the main thread and the UI will freeze.

You really don't want to use the main thread for computationally expensive operations which you would need to wait for.

Usually I would perform work off the main thread by using:

```swift
DispatchQueue.main.async
```

which submits the task on the queue for the runloop https://stevenpcurtis.medium.com/what-is-a-runloop-anyway-swift-and-ios-guide-aa574577331b
. The main run loop then dequeues the tasks from its queue and executes them on the main thread.

However we can use Swift's new concurrency system (at least relatively new since implementation in Swift 5.5) to solve the same problem.

# Using MainActor in Swift for Task Execution
Apple's [documentation](https://developer.apple.com/documentation/swift/mainactor) states that the `MainActor` class is "A singleton actor whose executor is equivalent to the main dispatch queue.".

We can run call `mainActor.run` directly, which can be used as an alternative or in conjunction with `Task` to manage concurrency and scheduling tasks for execution.

Let's take a look.

```swift
await MainActor.run {
    print("AAA")
}
```

The code is then executed immediately. However we need to understand that this code runs on the main actor and code awaits the result. So we await the result of the closure (which in this case will return 11).

```swift
let result = await MainActor.run { () -> Int in
    sleep(2)
    print("This is run on the main actor.")
    return 11
}

print(result) // 11
```

That is very nice.

If we do not want to (for want of a better name) await the result of our closure we can wrap our `MainActor.run` in a `Task`.

```swift
Task {
    let resultTwo = await MainActor.run { () -> Int in
        sleep(2)
        print("resultTwo is run on the main actor.")
        return 22
    }
}

print("resultTwo complete") // but you can't access resultTwo here
```

We can also mark that task as running on the main actor:

```swift
let resultThree = Task { @MainActor in
    sleep(2)
    print("resultThree is run on the main actor.")
    return 33
}

print(await resultThree.get())
print("resultThree complete")
```

However a given `Task` does not execute immediately, meaning that it is placed on a task queue.

As a result we can investigate how these might interact.

```swift
let resultFour = await MainActor.run { () -> Int in
    print(41)
    Task { @MainActor in
        print(42)
    }
    print(44)
    return 33
}

print(resultFour)
print("resultFour complete")
```

This would output the following:

```swift
41
44
42
33
```
To hammer home the point, `Task` isn't run immediately.

# The @mainActor attribute
The `@mainactor` attribute can be applied to a function, property or type declaration. It indicates that the constituent code must be executed on the main thread (probably because the changes will be used to update the user interface). In other words, it marks the function, property or type declaration as being part of the main actor's context.

These code snippets are from the repo included in this project. You might notice that within that project I've applied the `@mainActor` attribute to a function, property and class all in the same `JokeViewModel`. It doesn't usually make a whole lot of sense to do so since applying the attribute to the type declaration indicates that any instance of it (in this case `JokeViewModel`) must be accessed and modified only from the main thread.

Still, to make it easy to follow, that's what I've done. 

## Applied to a function

The `@mainActor` attribute has been applied to `getJoke` here. This indicates the function should be run on the main thread. This would make sense for a function performing a network call like this as we ensure that when the function completes and returns the result that the code will be run on the main thread. That is, if we use it to interact with the UI we avoid a painful crash which might occur if the UI is updated from a background thread.

```swift
@MainActor
private func getJoke() async throws -> String {
    let url = URL(string: "https://api.chucknorris.io/jokes/random")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()
    
    let result = try decoder.decode(JokeData.self, from: data)
    return result.value
}
```

## Applied to a property

Within the repo code I've used a state to communicate the state between the viewmodel and view. 

One use of the `@mainActor` attribute is to mark the `state` property so it can only be accessed and modified from the main thread. Since this `state` property is used to drive the user interface this makes sense (once again, to prevent painful crashes or other problems from updating the UI on a background thread).

```swift
final class JokeViewModel: ObservableObject {
    @MainActor
    @Published var state: State = .initial
    
    enum State {
        case error(Error)
        case initial
        case joke(String)
        case loading
    }
...
```

## Applied to a type declaration
I'm going to do it. I'm going to say that the easiest way of making sure we work on the main thread is to mark the viewcontroller with the `@mainActor` attribute.

That means when the viewmodel is accessed or modified it must only be from the main thread. This means we can safely use the viewmodel to manage the state of the view and trigger UI updates since changes are dispatched to the main thread.

Crashes from using a background thread? Shouldn't happen.

```swift
@MainActor
final class JokeViewModel: ObservableObject {
...
```

# Conclusion
The `@MainActor` attribute in Swift is a great way to ensure that code runs on the main thread. 

Something which helps us to write robust and reliable code? That's something to think about, and `@MainActor` is certainly something we should think about when writing our code in general.

Thank you for reading.

Anyway, happy coding!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
