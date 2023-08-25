# Global actors in Swift Concurrency
## Everywhere!

Introduced in Swift 5.5 along with Swift's new concurrency model, global actors provide synchronization and ensure correct data access.

Let's take a look.
Difficulty: **Beginner** | Easy | Normal | Challenging

This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites
- Be able to produce a ["Hello, World!" SwiftUI project](https://stevenpcurtis.medium.com/hello-world-swiftui-92bcf48a62d3)

It might be nice if you had some knowledge of
- [Actors](https://medium.com/@stevenpcurtis/actors-in-programming-fc6e8e282a75) are a conceptual model used to deal with concurrency
- Be familiar with [@MainActor](https://medium.com/@stevenpcurtis/swift-concurrency-working-with-mainactor-to-manage-task-execution-996285c4c4d8
)

## Keywords and Terminology
@MainActor: is a Swift attribute used to indicate that a type or function must be executed on the main thread.
Global Actors: Singleton actors which can be used to provide synchronization and ensure correct data access in concurrent contexts
Singleton: A way of instantiation that guarantees that only one instance of a class is created

# Is a global actor the same as a main actor?
Not quite.

`@MainActor` is a predefined global actor in Swift and represents the main dispatch queue. `@Mainactor` is predefined, and represents the main dispatch queue. Because of this, `@MainActor` will usually be used for UI tasks that need to be run on the main queue.

We can create our own global actors. 

```swift
@globalActor
struct CustomGlobalActor {
  actor ActorType { }

  static let shared: ActorType = ActorType()
}

class MyClass {
    @MainActor
    var uiProperty: String = "Hello, UI!"

    @CustomGlobalActor
    var customProperty: String = "Hello, Custom!"

    @MainActor
    func updateUIProperty(value: String) {
        uiProperty = value
    }

    @CustomGlobalActor
    func updateCustomProperty(value: String) {
        customProperty = value
    }
}

let myClass = MyClass()
await print(myClass.customProperty)
```

# Why Use Global Actor?
## Shared Resources
If you have shared mutable state that many parts of your code need to access, instead of creating multiple individual actors, a globalActor can ensure exclusive access to that state across different parts of your application.

## Specific Queues
 If you are designing a library or API where you want to expose certain functionality that's guaranteed to run on a specific queue (like the main queue for UI updates), you can use globalActor to make these guarantees explicit.

# Conclusion

Swift's concurrency model, introduced in Swift 5.5, presents a paradigm shift, enabling developers to write more efficient and safer concurrent code. Among the features of this model, global actors stand out as a powerful tool to synchronize access to shared resources, ensuring data consistency in a concurrent environment. Whether you're dealing with UI tasks using the predefined `@MainActor` or defining your own custom global actors for shared resources, the flexibility and safety afforded by these constructs make them indispensable in modern Swift programming.

Thank you for reading.

Anyway, happy coding!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 

