# Swift Actors: Manage Concurrency and Prevent Data Races
## The conceptual model

Let's take a look at Actors in Swift. They're rather great, as they can help to solve data races.
Difficulty: **Beginner** | Easy | Normal | Challenging

This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites
It would be useful to have some idea about [Actors in programming](https://medium.com/@stevenpcurtis/actors-in-programming-fc6e8e282a75)

## Keywords and Terminology
actor: A role played by the user with respect to interacting with the system


# Actors
[Actors](https://medium.com/@stevenpcurtis/actors-in-programming-fc6e8e282a75) are a conceptual model used to deal with concurrency

They are similar to classes in OO languages. In swift they are also reference types, which means when we create Actors with the `actor` keyword which means a reference to the object is passed when the `actor` is assigned.

An actor is a conceptual model which has been imported into swift. In programming we use actors to deal with concurrency in the model computation world.

In Swift `actor` types have private state (cannot be modified by another actor) which means their state is protected from data races which can occur from concurrent access to mutable data.

# Taking a look
A classic example of a non-thread safe class is a `Counter`. Something like the following:

```swift
final class Counter {
    var count = 0

    func inc() {
        count += 1
    }
}

let counter = Counter()

DispatchQueue.global().async {
    for _ in 0..<1000 {
        counter.inc()
    }
}

DispatchQueue.global().async {
    for _ in 0..<1000 {
        counter.inc()
    }
}

Thread.sleep(forTimeInterval: 1)
print(counter.count)
``` 

Which sometimes prints 1998, sometimes 2000, sometimes 1999. It's not ideal as there is a data race occurring. I have previously used [NSLock](https://stevenpcurtis.medium.com/synchronizing-concurrent-tasks-in-swift-with-nslock-7c2206bbfefe) to solve this problem.

However, I can instead use `actor` to do so.


```swift
actor Counter {
    private var value = 0
    
    func next() -> Int {
        let current = value
        value = value + 1
        return current
    }
    
    func total() -> Int {
        value
    }
}

let counter = Counter()

Task {
    for _ in 0..<1000 {
        await (counter.next())
    }
}

Task {
    for _ in 0..<1000 {
        await (counter.next())
    }
}

try await Task.sleep(nanoseconds: 1000000000)
await print(counter.total())
```

The `actor` keyword means the `Counter` type above is a reference type. To create a method that accesses a local property we must mark the request with `await`.

This is where the [theory](https://stevenpcurtis.medium.com/actors-in-programming-fc6e8e282a75) kicks in. An actor has isolated mutable state, so in order to access state the actor can send and receive messages - conceptually a single message at a time. We can imagine that an actor receiving many concurrent messages would use a serial queue to ensure that only a single message is processed at a time (in received order).

In my example `value` is marked as `private`, but if it were `internal` or `public` a programmer may be tempted to make changes to the property from outside the actor (say from the main actor). Luckily, Swift's actor isolation comes into play and you might well get an error message like the following:

```swift
Actor-isolated property 'value' can not be mutated from the main actor
```

If you try to update a property from another actor (or another actor instance) you will get a message much like this:

```swift
Actor-isolated property 'value' can not be mutated on a non-isolated actor instance
```

Which is really us told.

This is the real advantage of Swift: It uses compiler errors to let us know where we are going wrong!

# Conclusion
Thank you for reading.


Anyway, happy coding!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
