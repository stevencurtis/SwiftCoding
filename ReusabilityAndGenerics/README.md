# Don't be Confused Between Reusable and Generic as a Swift Coder!
## Not that hard!

I've recently noticed some confusion between reusability and generics in Swift.

That is, the terms have been used interchangeably with some. The problem? They don't mean the same thing.

Let's take a look.

# Before we start
Difficulty: **Beginner** | Easy | Normal | Challenging

This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites
- none

## Terminology
Reusable: Code or components that can be used with different input, in multiple places or contexts without needing to be rewritten
Generic: A feature of the Swift language which allows functions, methods and types to be written in a flexible way that works with different types

# Examples
It is possible to have similar functions which are context-specific, reusable and generic.

I think one of the most simple examples are "Hello, World". 

## Context-specific
The following function will always print "Hello, world!" no matter where this is called (the context). It just prints the greeting message to the console. Because it doesn't take any parameters (or rely on any state in an enclosing class) to modify the message or customize the behaviour of the function you would need to rewrite the function. It's simply not reusable.

```swift
func printGreeting() {
    print("Hello, world!")
}
```

## Reusable
A reusable implementation of `printGreeting()` could take in a parameter so the function could print an appropriate greeting for a anyone who uses the function. The parameter makes the function reusable because the function can be used for any name rather than a specific name.

```swift
func printGreeting(name: String) {
    print("Hello, \(name)!")
}
```

This can be called for a variety of different names. Here are two examples of calling `printGreeting(name:)`:

```swift
printGreeting(name: "James") // James
printGreeting(name: "Maria") // Maria
```

## Generic
We can rewrite `printGreeting` as a generic function. This means that the function has a generic parameter that can take any type. 

```swift
func printGreeting<T>(name: T) {
    print("Hello, \(name)!")
}
```

This can then be called using the following (or calls like it):

```swift
printGreeting(name: "John") // "Hello, John!"
printGreeting(name: 42) // "Hello, 42!"
printGreeting(name: ["John", "Jane"]) // "Hello, ["John", "Jane"]!"
```

Yet there is a potential issue. The behaviour for the function may not be well-defined for some types that do not have a description.

```swift
printGreeting(name: {}) // "Hello, (Function)!"
```

Although the code compiles and runs, `Hello, (Function)!` may not be the desired or expected result.
Here is one way we can limit the generic type to only accept parameters that conform to `CustomStringConvertible` and make sense to be used in our greeting: 

 ```swift
func printGreeting<T: CustomStringConvertible>(name: T) {
    print("Hello, \(name)!")
}

printGreeting(name: "John") // "Hello, John!"

// The following now causes a compiler error
//printGreeting(name: {}) // "Hello, (Function)!"
```
# Conclusion
It can be tricky to understand the difference between reusable and generic when using Swift (or in fact any other programming language). I hope this article has been of some help!

