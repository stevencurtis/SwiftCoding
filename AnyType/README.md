# The Ultimate Type Eraser: Swift's Any
## Anything is great

Swift is a type-safe language, meaning the compiler will validate types while compiling.

So what happens when you need to handle values when you don't know their type at compile type (and neither does the compiler) you need to think carefully about your approach.

One tool we have is the `Any` type. However with great power comes great responsibility, `Any` needs to be used carefully and with thought.

With that in mind, this article will go into how `Any` works, and when to use it (with an example here and there).

# What is Any?
Any feels like a magical type for developers. It can represent an instance of any type.

When you use `Any` Swift erases the type information (type erasure) of the stored values, so they are all treated as `Any`. When the value is used it would usually need to be cast back to it's original type using `?` or `!`.

# An Array Example
The use of `Any` gives us many options in handling types.

```swift
let array: [Any] = [42, "Hello, world!", 12.34, true, CGFloat.pi]

for item in array {
    print(item)
}
```

In the `array` the types (`Int`, `String`, `Double`, `Bool` and `CGFloat`) can be stored together. Typically arrays store a single type, and a mixed type array would not be possible.

# Limitations
It is important to understand that while `Any` offers flexibility that flexibility comes at a cost as you lose the benefits of Swift's type system.

This means that code featuring `Any` can be hard to read and difficult to maintain because it isn't clear which underlying type is being handled.

**Casting**
If we force cast using `as!` to use the underlying type we risk a runtime crash, but if we use `as?` we risk handling errors that may never happen. Consider the following:

```swift
let value: Any = 3

guard let intValue = value as? Int else {
    // handle error
}

// use intValue
```

Failing the cast in the code block above is simply impossible. Yet in our code we still need to handle the potential error, and this is obviously sub optimal.

**Protocol constraints**
You might have the following code, and unfortunately there is an error. We cannot compare `Any` and `Int`, because the two types are not directly comparable.

```swift
let items: [Any] = [42, "Hello, world!", 12.34, true, CGFloat.pi]
for item in items {
    if item == 42 { // Error
        print("Found 42!")
    }
}
```

Since `Any` can represent any type, Swift cannot simply assume that any given item conforms to `Equatable` (in this case) or indeed any other protocol.

# Best Practices for Using Any
## Don't Use It
The title of this best practice is a joke. But the truth is `Any` should not be used wherever a more specific type can do the job.

If working with mixed data types, consider an `enum` with associated values in order to use Swift's type safety.

```swift
enum Item {
    case wholeNumber(Int)
    case word(String)
    case number(Double)
}
```

And if you need to enforce constraints use generics.

`Any` also introduces performance overhead, which isn't cool.

## Use It With Care
If you cannot use anything other than Any you might well do it, on these cases:
- You need to handle mixed-type collections
- You're working with dynamic or deserialized data
- The type cannot be known at compile time

## Type Check Carefully
If you need to cast `Any` to a type us conditional casting (`as?`) to prevent runtime crashes.

# Examples
## Working with JSON

When decoding JSON without `Codable` `Any` might well play a role.

```swift
let jsonResponse: [String: Any] = [
    "user": [
        "id": 101,
        "name": "Alice"
    ],
    "isActive": true
]

if let user = jsonResponse["user"] as? [String: Any],
   let name = user["name"] as? String {
    print("User's name is \(name)")
}
```

# Conclusion
`Any` is a tool that can be used by developers. However developers need to consider the trade-offs in using it. Just because you can doesn't mean it should!
