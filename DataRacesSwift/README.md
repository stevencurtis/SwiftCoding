# Data Races in Swift
## And how to prevent them

I've already written an article about [Data Races in Programming](https://medium.com/@stevenpcurtis/data-races-in-programming-350fd434798a) which I would say is well worth a read. 

However, you don't *have* to do that, and this particular article is (hopefully) suitable for any Swift programmer who wants to learn something about Data Races.

Difficulty: Beginner | Easy | **Normal** | Challenging
This article has been developed using Xcode 14.2, and Swift 5.7.2 

# Prerequisites:
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)
* If you like examples of [Mutable State in Swift](https://medium.com/@stevenpcurtis/mutable-state-in-swift-967503dcd2ee) you can look at that link!

# Swift's Data Races
Data races occur when multiple threads access the same memory location, and at least one modifies the data.

This can lead to difficult to find bugs as the behaviour of the software can be unpredictable. 

# How Data Races Occur in Swift
Ah, shared mutable state.

If I take my simple example from my [Mutable State in Swift](https://medium.com/@stevenpcurtis/mutable-state-in-swift-967503dcd2ee) of a counter we aren't in any danger of a data race. Look:

```swift
final class Counter {
    var count = 0

    func inc() {
        count += 1
    }
}

let counter = Counter()
print(counter.count) // 0

counter.inc()
print(counter.count) // 1

counter.inc()
print(counter.count) // 2
```

since the class is accessed by a single thread there is no possibility of concurrent access.

If we have some code that can access the `count` property concurrently without any synchronisation mechanism we risk a data race.

**The initializer example**
The following is a basic `class` to represent a person:

```swift
final class Person {
    var name: String?
    
    func set(name: String) {
        self.name = name
    }
    
    init() { }
}
```
An instance can be created with something like the following:
let person = Person()

If multiple threads called `set(name:)` we don't have clearly defined behaviour as there is a potential data race if the function is called at the same time.

**The GCD example**
The example? Using GCD something like the following can suffice:

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


**The Task example**
```swift
var tasks = [Task<Void, Never>]()
tasks += [
    Task.detached {
        counter.inc()
    }
]

tasks += [
    Task.detached {
        counter.inc()
    }
]

print(counter.count)
```

There is a possibility that the tasks will attempt to modify the counter simultaneously, leaving us with undetermined behaviour. It's not great!

Data races never are.

**A possible solution**
It really depends on what you are doing. If you had a counter you might decide to use a `DispatchQueue` to synchronize access to the `count` property. A solution might be something like this:

```swift
final class SafeCounter {
    private var count = 0
    private let queue = DispatchQueue(label: "SafeCounter.queue")

    func inc() {
        queue.sync {
            count += 1
        }
    }

    var currentCount: Int {
        return queue.sync { count }
    }
}

let safeCounter = SafeCounter()

DispatchQueue.global().async {
    for _ in 0..<1000 {
        safeCounter.inc()
    }
}

DispatchQueue.global().async {
    for _ in 0..<1000 {
        safeCounter.inc()
    }
}

Thread.sleep(forTimeInterval: 1)
print(safeCounter.currentCount) // 2000

```

# Conclusion
Thank you for reading.
