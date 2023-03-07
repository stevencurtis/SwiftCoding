# GCD Barriers in Swift: Synchronising Concurrent Tasks
## Shalt not pass

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 14.2, and Swift 5.7.2 

# Prerequisites:
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)
* Some familiarity with [GCD and concurrency](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2) would be useful for the reader

# Keywords and Terminology:
Grand Central Dispatch (GCD): Apple's high-level API for managing concurrency on macOS, iOS, and other Apple platforms. It provides a way to manage concurrent tasks using dispatch queues, which can be used to execute tasks asynchronously and in a thread-safe manner.
Barrier: A synchronisation tool that ensures only one task accesses a shared resource at a given time. 

# GCD and barriers
## Introduction
GCD is a low-level API for managing concurrent operations, and used well will help make your application smooth and response. 

We might use any particular queue to dispatch a task. Here we are using the global queue to do so:

```swift
// Async Dispatch
DispatchQueue.global().async {
    // Perform task asynchronously on a background thread
}

// Sync Dispatch
DispatchQueue.global().sync {
    // Perform task synchronously on the current thread
}
```

That's fine, and we can even assign a Quality of service (QoS)  level to assign a priority to our task. Excellent! https://medium.com/@stevenpcurtis/mastering-concurrency-in-swift-understanding-grand-central-dispatch-quality-of-service-265d04e1bf21

## The problem
When dealing with concurrency, we might encounter a [data race](https://medium.com/@stevenpcurtis/data-races-in-programming-350fd434798a).

A sample problem of a data race in Swift is shown in the following code:

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

`Thread.sleep(forTimeInterval: 1)` waits for the threads to finish, and `counter.count` is written to the screen with different values (on my machine I got 1999 then 2000, followed by 2000).

It needs to be fixed.

We could solve it using a serial queue to eliminate the possibility of concurrent access to the `count` property. We could also use a semaphore.

Usually a barrier is most suitable for situations where multiple tasks are performed concurrently on a shared resource and some tasks depend on the completion of other tasks. As such, solving such a trivial example with a barrier is overkill but to make this article not *too* complex we can still solve it with a barrier.

## Barriers
GCD supports barriers. Barriers create a point in a concurrent queue where all previously submitted tasks must complete before the barrier task can be executed. Once the barrier task is executed, all the tasks submitted after the barrier task can begin execution. 

This means barriers can ensure tasks are executed in a synchronised manner and shared resources can be protected from simultaneous access by multiple tasks.

Barriers can actually be split into *read* and *write* barriers.

*Read Barriers*
A read barrier allows multiple tasks to read a resource, but only a single task can write to the shared resource at a given time. 

*Write Barriers*
A write barrier ensures that only one task can access a shared resource at a given time. This applies to either reading or writing a shared resource.

## That example
Remember we had some code with a possible (or is that probable) data race condition above? We can solve that with a barrier. Our barrier (`queue.async(flags: .barrier)`) ensures that the block of code in the closure executes atomically and only one thread can access the `count` property at any given time (so it is a write barrier).

```swift
final class Counter {
    private var count = 0
    private let queue = DispatchQueue(label: "myQueue", attributes: .concurrent)

    func inc() {
        queue.sync(flags: .barrier) {
            self.count += 1
        }
    }

    var value: Int {
        return queue.sync {
            self.count
        }
    }
}
```

The `inc()` method uses a synchronous barrier dispatch to ensure thread safety when implementing the `count` property, so any concurrent access to this method will be blocked until the current execution completes. Since `value` is on the same queue (and  uses synchronous dispatch) the barrier requires all previously submitted tasks are completed before task in the barrier closure are executed.

However for the write we can use async. The reason the read is dispatched synchronously is because you have to wait for the result to be returned. In respect to the write, nothing needs to be returned meaning we don't need to wait for the dispatched block to be finished which avoids blocking the caller's thread.

```swift
final class Counter {
    private var count = 0
    private let queue = DispatchQueue(label: "myQueue", attributes: .concurrent)

    func inc() {
        queue.async(flags: .barrier) {
            self.count += 1
        }
    }

    var value: Int {
        return queue.sync {
            self.count
        }
    }
}
```

# Conclusion

 GCD barriers are a powerful tool for managing concurrency in Swift. They allow tasks to be executed in a synchronized manner, ensuring that shared resources are protected from simultaneous access by multiple tasks.
 
 Barriers can be split into read and write barriers, with read barriers allowing multiple tasks to read a resource but only a single task to write to it, and write barriers ensuring that only one task can access a shared resource at a given time. By using GCD barriers, we can ensure that our application is thread-safe and free from data race conditions, leading to improved performance and stability.
