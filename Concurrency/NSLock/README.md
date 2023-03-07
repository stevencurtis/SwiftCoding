# Synchronizing Concurrent Tasks in Swift with NSLock
## Seal it off!

Difficulty: Beginner | **Easy** | Normal | Challenging
This article has been developed using Xcode 14.2, and Swift 5.7.2 

# Prerequisites:
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)
* Some knowledge of [Data Races in programming](https://medium.com/@stevenpcurtis/data-races-in-programming-350fd434798a) would be useful

# Keywords and Terminology:
NSLock: A synchronization method to control access to shared resources in multithreaded code. 

# NSLock
## Introduction
In concurrent programming, tasks can access shared resources. This can lead to corruption or race conditions and associated unexpected behaviour. NSLock is one synchronization tool which can be used to ensure that only one task at a time can access a shared resource, preventing data races and other synchronization issues. 

Using NSLock to synchronize access to shared resources, developers can write more robust and reliable code that performs well under various concurrent scenarios.

[NSLock](https://developer.apple.com/documentation/foundation/nslock) provides two methods for locking and unlocking the critical section: `lock()` and `unlock()`. When a thread calls the lock() method, it acquires the lock and enters the critical section. 

If another thread tries to acquire the lock while it is already held by a thread, the thread is blocked until the lock is released by the first thread using the unlock() method.

## The problem
When dealing with concurrency, we might encounter a data race.
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
`Thread.sleep(forTimeInterval: 1)` waits for the threads to finish, and counter.count is written to the screen with different values (on my machine I got 1999 then 2000, followed by 2000).

It needs to be fixed.

We could solve it using a serial queue to eliminate the possibility of concurrent access to the count property. We could also use a semaphore or a GCD barrier.

Usually an NSLock is suitable in situations where a relatively small number of threads need to access the shared resource and that resource needs to be protected from multiple updates. In this case, I'd usually solve this type of issue with a serial queue however to write an article with a trivial example has necessitated writing the solution to this particular problem.

## NSLock
`NSLock` is similar to `pthread_mutex_t` in C or C++, but exists as an easy to use high-level API in Swift.

Instances of `NSLock` can be created with this rather friendly-looking code:

```swift
let lock = NSLock()
```

which can then be used to synchronize access to shared resource.

# That example
Remember we had some code with a possible (or is that probable) data race condition above? We can solve that with an NSLock.

```swift
final class Counter {
    private var _count = 0
    private let lock = NSLock()

    func inc() {
        lock.lock()
        defer {
            lock.unlock()
        }
        _count += 1
    }

    var count: Int {
        lock.lock()
        defer {
            lock.unlock()
        }
        return _count
    }
}
```

We `inc()` function increments the `_count` backing store, and to access that property the `lock()` method is called to acquire the lock. Once the property has been incremented, it is relinquished with the `unlock()` method.

The `count` property returns the current value of the `_count` backing store, using `lock.lock()` to acquire the lock once again and relinquishes when the value is returned.

If a task attempts to access a locked resource that is already locked by another task, it will be blocked and will wait until the lock is released. The task will be put on hold, allowing other tasks to execute, until it can acquire the lock and access the resource. This ensures that multiple tasks do not access the same resource simultaneously, preventing data corruption and other synchronization issues.

# Conclusion

NSLock is a powerful tool for controlling access to shared resources in concurrent programming. It provides a simple and effective way to prevent data races and other synchronization issues that can occur when multiple threads access the same resource simultaneously. 

I hope with the knowledge from this article developers can write more robust and reliable code that performs well under various concurrent scenarios.
