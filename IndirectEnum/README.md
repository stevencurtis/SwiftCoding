# Understanding Indirect Enums in Swift
## Recursive types

# Terminology
enum: A user-defined type in Swift that groups related values in a type-safe way.
indirect: A keyword in Swift used to indicate that an enum case (or all enum cases when applied to an enum) enabling recursive data structures.
struct: A value type in Swift that encapsulates related data and behaviours, and uses value semantics.
class: A reference type in Swift that encapsulates related properties and methods. Supports inheritance and dynamic dispatch.
type-safety: A feature of Swift that ensures variables are used in a way consistent with their declared types, preventing compile time errors.

# Introduction
Enums in Swift provide access to related groups of values in a type-safe manner, and use value semantics. While in some sense they are similar to the use of struct, they embody their own complexity.

This article is about the use of the `indirect` keyword that allows recursively defined cases, something disallowed in Swift for structs.

I want to explain what indirect enums are and how to implement them.

# What are Indirect Enums?
Indirect enums are useful because we can define recursive data structures.

This means that an enum case can refer to another instance of the same enum.

This is all a little abstract, so let us see when you might use a recursive data structure.

# Uses of Indirect Enums
Classic uses of indirect enums are
## Binary Tree structures
Each Node has child nodes (in a binary tree left and right nodes). If we wish to use value semantics while using an enum we can use an indirect enum.

```swift
indirect enum Node<T> {
    case node(
        value: T,
        leftChild: Node?,
        rightChild: Node?
    )
    case empty
}
```
## Linked List
Each Node in a linked list points to the next element, again providing a recursive data structure.

```swift
indirect enum Node<T> {
    case node(value: T, next: Node?)
    case empty
}
```

# When to Use Indirect Enums
indirect enum are useful where you want to uses a recursive data structure and require value semantics.

When using indirect enums you can leverage pattern matching to traverse and easily manipulate recursive structures, making the code more readable and maintainable.

Since we are using value types we avoid retain cycles and memory leaks that are difficult to handle when using reference types. These value types can also be optimized by the Swift compiler, potentially improving performance.

# A Real Example
I'm going to create a simple text editor that features an undo function. Pretty exciting! That means we can start with "Hello", append ", world!" and we will get "Hello, world!". If we then append " typo" we can undo that action by calling undo.

*how difficult can it be?*

## Without enum
We are going to store the history of our text.

We can embed this in our `TextEditor` and store the history as an array. This works fine!

```swift
struct TextEditor {
    private(set) var text: String
    private var history: [String]

    init(text: String) {
        self.text = text
        self.history = []
    }

    mutating func append(_ newText: String) {
        history.append(text)
        text += newText
    }

    mutating func undo() {
        if let previousHistory = history.popLast() {
            text = previousHistory
        }
    }
}
```

This isn't great because the `TextEditor` struct is doing too much. So we should separate out the functionality manage the state history.

**Manage the state separately**

```swift
struct History {
    let state: String
    private (set) var previous: [String]

    init(state: String, previous: [String] = []) {
        self.state = state
        self.previous = previous
    }
    
    mutating func undoLastChange() -> String {
        previous.removeFirst()
    }
}

struct TextEditor {
    private(set) var text: String
    private var history: History

    init(text: String) {
        self.text = text
        self.history = History(state: text)
    }

    mutating func append(_ newText: String) {
        text += newText
        history = History(state: text, previous: [history.state] + history.previous)
    }

    mutating func undo() {
        let previousText = history.undoLastChange()
        text = previousText
    }
}
```
It's fine. There is some difficult logic here, lots of mutating functions in the history. It's hard as we are storing the array of changes and need to monitor the order of this, it's tricky.

Let's find a better option.

**Manage the state with a recursive stored property**

We might choose to use a struct to store our History as recursive stored property.

Unfortunately the following code gives us an error message which is "Value type 'History' cannot have a stored property that recursively contains it". This makes sense, because for a value type the compiler needs to define how much memory to assign the struct - and with a recursive property this is not possible.

```swift
struct History {
    let state: String
    let previous: History?

    init(state: String, previous: History? = nil) {
        self.state = state
        self.previous = previous
    }
}
```

**Manage the state with a recursive stored property in a class**
So we can use a class to store our state history. Everything is fine, but of course storing the history as a class means we are using referral semantics.

```swift
final class History {
    let state: String
    let previous: History?

    init(state: String, previous: History? = nil) {
        self.state = state
        self.previous = previous
    }
}

struct TextEditor {
    var text: String
    var history: History

    init(text: String) {
        self.text = text
        self.history = History(state: text)
    }

    mutating func append(_ newText: String) {
        text += newText
        history = History(state: text, previous: history)
    }

    mutating func undo() {
        if let previousHistory = history.previous {
            text = previousHistory.state
            history = previousHistory
        }
    }
}
```

If we can use a class we can easily do this. However if I want to use value semantics...we cannot use a struct.

This brings us to using an enum.

## Using an enum
This is where an indirect enum can step in. Actually I can use an indirect enum. Good thing, given the topic of this article!

```swift
enum History {
    case initial(String)
    indirect case change(String, previous: History)
}

struct TextEditor {
    var text: String
    var history: History

    init(text: String) {
        self.text = text
        self.history = .initial(text)
    }

    mutating func append(_ newText: String) {
        text += newText
        history = .change(text, previous: history)
    }

    mutating func undo() {
        switch history {
        case .initial(let initialText):
            text = initialText
        case .change(_, let previousHistory):
            switch previousHistory {
            case .initial(let previousText):
                text = previousText
            case let .change(previousText, _):
                text = previousText
            }
            history = previousHistory
        }
    }
}
```

Each History change case can hold another History, making it recursive. 

We also get value semantics for free!


# Conclusion
Indirect enums are a powerful Swift feature that enables recursive data structures. 

I hope this has added a tool into your Swift toolkit, and will help you achieve your app building dreams!
