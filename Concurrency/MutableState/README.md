# Mutable State In Swift
## It makes code harder to reason about

Difficulty: Beginner | Easy | **Normal** | Challenging
This article has been developed using Xcode 14.2, and Swift 5.7.2

# Prerequisites:
You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), or a [Playground](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to run Swift code

## Keywords and Terminology:
Mutable State: values or variables that can be modified or changed after being declared. These changes can have side effects on the behaviour of the program.

# Mutable state
Mutable state is necessary in cases where you need to keep track and modify state over time.

A classic example is the following:

```swift
class Counter {
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

The `count` property of the `Counter` class is mutable state, which is modified by the `inc()` function. This counter App relies on mutable state.

# Avoiding Mutable state
If you choose to avoid mutable state you get several benefits, which overall lead to more robust and easier to understand code. Of course, some code requires mutable state, and it is down to the programmer to weigh up advantages and disadvantages of any particular coding approach.

The advantages of avoiding mutable state are:

Easier to reason about: By eliminating the possibility of state changes at arbitrary times, it becomes easier to understand how the code works and identify potential bugs.
Easier to test: Code that uses immutable state can be tested more easily, as the test input/output is more predictable.
Concurrency and parallelism: Immutable data structures can be safely shared among multiple threads and processes, without the need for locks or other synchronization mechanisms, as there is no risk of concurrent state changes.
Performance: Immutable data structures can be more efficient in some scenarios, particularly for complex or large data structures, as they can be shared more easily, avoid costly copying, and enable more sophisticated optimizations.
Avoiding accidental changes: Immutable state can help prevent accidental changes to data that should not be modified, which can be particularly important for security or safety-critical systems.

# Mutable state and pure functions
[Pure functions](https://stevenpcurtis.medium.com/can-you-write-pure-functions-in-swift-8920f7ac0705
) don't modify any external state and only depend on inputs. Effectively pure functions are unable to modify mutable state outside of their scope. An example of a pure function is as follows

```swift
func helloWorld(name: String) -> String {
    "Hello, world \(name)"
}
```

On the other hand, since mutable state can be modified (or indeed accessed) from outside it's scope it can be difficult to reason about.

A not pure function might access mutable state, a global or even local property. Something like

```swift
var counter = 0
func inc(num: Int) -> Int {
    counter += 1
    return counter
}
```

Such code risks issues such as race conditions and deadlocks.

# Mutable state and immutable data
Mutable state can be avoided by using immutable data structures. With `struct` and `enum` by default they are immutable.

For example once a `struct` is initialized properties cannot be changed.

Let's look at an example:

```swift
struct Person {
    let name: String
    let age: Int
}

let person1 = Person(name: "Alice", age: 30)
let person2 = Person(name: "Bob", age: person1.age)
```

In order to update the name of a person we have to create a new instance with the desired changes.

This prevents unexpected side effects in your code. If you wish to change immutable objects (what?) you might like to read my article about [lenses in Swift](https://medium.com/p/49ca251f6c6)

# Conclusion
Thank you for reading.

Remember, like anything in coding mutable state isn't all bad. It's suitable for some situations and not others. It's down to the programmer in a 'it depends' style to decide what is and what isn't appropriate for any given situation.

Anyway, happy coding!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
