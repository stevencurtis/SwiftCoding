# Swift's Sendable and @Sendable closures
## Why you mess me up so bad?

Ah, Swift 5.7. I knew you'd have something to make me think about. The `@Sendable` protocol ultimately has meant that I've written a new network client for myself!

*So what is Sendable, @Sendable and why should we care*

Sendable types are safe to share concurrently.

Many different kinds of types are `Sendable`:
 - Value types (because each copy is independent)
 - Actor types (because they synchronise access to their mutable state)
 - Immutable classes
 - Internally-synchronized classes (for example with a lock)
 - @Sendable function types
 
 `Sendable` describes a common but not universal property of types.
 
 # The background
 I had an old network library that I used to use. Suddenly it stopped working right around the time that Swift 5.7 got released. Didn't seem to be a coincidence and it's the fact that the dataTask function now has @Sendable it it's signature+. [Here]( https://github.com/stevencurtis/NetworkManager/commit/cf943fd02fd46b17f20cc359de4734680e25a880) is the commit where I fixed that!
 
 Now, this is the article that explains @Sendable 
 
+I know, I shouldn't have been mocking URLSession and I've a much [superior new version](https://github.com/stevencurtis/NetworkClient) if you would like to look at that.

 # Back to sendable
Swift will prevent non-`Sendable` types from being shared.

Since `Sendable` is a protocol we declare conformance like any other property. If a type has `Sendable` properties, the enclosing type can be declared as `Sendable`.

Generic types can be `Sendable`, for example a Pair type when both of it's properties are sendable

```swift
struct Pair<T, U> {
    var first: T
    var second: U
}

extension Pair: Sendable where T: Sendable, U: Sendable {
}
```

@Sendable function types conform to the `Sendable` protocol

@Sendable places restrictions on closures
- No mutable captures
- Captures must be of `Sendable` type
- Cannot be both synchronous and actor-isolated

Anything a closure captures must be `Sendable` to make sure that the closure cannot be used to move non-`Sendable` types across actor boundaries.

A synchronous `Sendable` closure cannot be actor-isolated because that would allow code to be run on the actor from the outside.

https://developer.apple.com/videos/play/wwdc2021/10133/

```swift
static func detached(operation((@Sendable () async -> Success) -> Task<Success, Never>
```

`Sendable` types in closures help maintain actor isolation by checking mutable state isn't shared across actors, and cannot be modified concurrently.


# Apple's documentation
Apple has, of course, provided us with some [documentation](https://developer.apple.com/documentation/swift/sendable).

What does it say...we can now safely pass values of a sendable type from one concurrency domain to another. This means we can mark the following as `Sendable`:

```swift
- Value types
- Reference types with no mutable storage
- Reference types that internally manage access to their state
- Functions and closures (by marking them with @Sendable)
```

Then we have `@unchecked Sendable` to declare conformance without compiler enforcement.

So here is what it means.

# Sendable Making Sense (probably)
Swift has type-safety which means that it helps us to write safe code.

We have probably all heard of Swift's [type-safety](https://stevenpcurtis.medium.com/why-type-safety-is-essential-in-swift-363a5fd2a795), so what if we could make race conditions also safe. 

I remember a bug I solved at work a couple of years ago. We used an image downloader that meant we didn't redownload images that we already had in a cache. Wonderful! We kept a property with running requests: here it is! `private var runningRequests = [UUID: URLSessionDataTask]()`.

Before downloading an image we'd log it as a running request `self.runningRequests[uuid] = task`.

After downloading an image we'd remove the key from running requests `self?.runningRequests.removeValue(forKey: uuid)`.

Since this code would be attached to `UITableViewCell` instances they could be reused. 

Guess what happened - a race condition. Several processes were accessing the class at the same time. Don't worry, the fix was actually easy. Run the dictionary operations on the same queue. 

I know what you're thinking. Make a potential `ImageDownloader` class an actor instead. This way only one thread can access it at any given time. Now this would force the actor to load only a single image at a time, but...it might lead to performance issues.

**In steps Sendable**
The `Sendable` protocol and `@Sendable` annotation communicate a thread-safety requirement to the compiler. This means that by definition `actor` objects are `Sendable` by default. 

All value types are `Sendable` if their members are also sendable, meaning `struct` instances are implicitly `Sendable` (if all their properties are `Sendable`). 

## To put it another way
Sending (in the parlance) objects across threads in safe for some objects. These include
- Value types like `String`, `Int` and `Bool` (including when they are an optional or part of a collection)
- Exclusively value type tuples
- `Int.self`, `Bool.self` and other metatypes
- Actors automatically conform to `Sendable`
- `struct`, `class` and `enum` instances will conform to `Sendable` if their properties all conform. `class` instances should be final.

# Conclusion
@Sendable is a step to ensuring concurrent programming is safe in Swift. That is that it makes sense to stop those pesky race conditions and bugs that have plagued us all for years.

That has to be a good thing, right?
