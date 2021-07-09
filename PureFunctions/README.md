# Can you write Pure Functions in Swift?
## You bet you can!

# Before we start
If you are writing functions, you might be asked whether the code is a pure function or not. You'll need to know, and you'll need to be able to describe what it is. In steps this guide to help you out.

Difficulty: Beginner | **Easy** | Normal | Challenging<br>
This article has been developed using Xcode 12.2, and Swift 5.3

## Keywords and Terminology
Idempotent: An operation that produces the same results if executed multiple times
Pure Function: A function where the return value is only determined by its input values, without observable side effects

## The theory
A pure function does not produce any side effects. This means:
* The function always returns the same value for the same inputs
* The function produces no side effects. That is, the function will not change the global state

Therefore a pure function should be run and the output is based wholly upon it's inputs and doesn't have the potential to mess up any other code. 

# Examples
## Mutate an input
If you mutate an input parameter, you increase the mutable state that your code will need to deal with.
```swift
func joinStrings(addme: String, to str: inout String){
    str.append(addme)
}

var addToThis = "test"
joinStrings(addme: "me", to: &addToThis)

print (addToThis) // testme
```

## Depending on a global (or even local) property
This can be a global property, like a simple increment function that counts the number of times the function has been run.

```swift
var counter = 0
func inc(num: Int) -> Int {
    counter += 1
    return num + 1
}
```

## Depending on a random factor
If there is something random about your function it is difficult to test. In fact, having a pure function makes your code easier to test. The most simple example is perhaps too simple:

```swift
func giveNumber() -> Int {
    return Int.random(in: 1..<100)
}
```

How can you test that? By that, I mean adequately unit test (not by the standards of your personal project with 0% coverage).

# The benefits
Pure functions are generally easier to read, and since they do not have side-effects are easy to reason about. Where we have clearly defined parameters we can be sure that our output is wholly dependent on those input parameters only

Since our function is only dependent on the input parameters our code is portable, and that means that a function can be used in another part of our code or in another App entirely.

It is always important to test code. If we know that code has a predictable result from a series of inputs, we can test for that. With complex shared mutable state it is difficult to test a single function or class without testing everything, and this goes against the idea of having independent and repeatable tests.

By definition pure functions have referential transparency, and this means that an expression may be replaced by it's value without changing the result of the program. Since referential transparency makes each subprogram independent, refactoring should be helped along as well as helping the compiler to reason about program behaviour (and therefore enhance compiler optimisations).  

Pure functions have the advantage of (by definition) returning the same output for any discrete set of inputs - and that sounds like caching. In fact, it does and therefore we can cache in a dictionary or similar to help prevent running some code repeatedly.

# Conclusion
Value types such as structs give us a clear indication when we are mutating state - that is a function will need to have the `mutating` keyword when the state is mutated. That is useful because it can help indicate to us that pure functions are important in writing good, testable code.

It should be remembered that there is no golden bullet for anything in programming, and that there are plenty of ways of processing data in your App and it is up to you to decide how to encapsulate logic in a way that best makes your code cool.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
