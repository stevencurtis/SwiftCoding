# Function Currying (and Uncurrying) in Swift
## NOT food related

Many blog article seems to think that function currying is something to do with a cooking process. Unfortunately sauce has little to do with this language feature! 

However currying can be necessary in order to compose higher-order functions and useful in a conceptual way when writing Swift code.

The currying `func` declaration has been removed from Swift (https://github.com/apple/swift-evolution/blob/main/proposals/0002-remove-currying.md). This means rather than using currying declaration syntax we can explicitly return a closure.

Let us explain this all. Let's go!

Difficulty: Beginner | Easy | Normal | **Challenging**

# Prerequisites:
None in particular! I touch on [reduce](https://stevenpcurtis.medium.com/create-your-own-reduce-function-in-swift-e92b519c9659) later in the article, as is [generics](https://betterprogramming.pub/generics-in-swift-aa111f1c549).

## The mathematical technique
Currying is a technique for converting a function that takes multiple arguments into a sequence of functions that each take a single argument.

If we take a function that has two arguments (x, y) and produces output z, by currying we have a function that takes an argument x and produces a function from y to z.

## The Swift Evolution change
This is copied from (Swift Evolution)[https://github.com/apple/swift-evolution/blob/main/proposals/0002-remove-currying.md], but here goes:

```swift
// Before:
func curried(x: Int)(y: String) -> Float {
    return Float(x) + Float(y)!
}

// After:
func curried(x: Int) -> (String) -> Float {
    return {(y: String) -> Float in
      return Float(x) + Float(y)!
    }
}
```

So this has been removed as of Swift 3, and 2016.

This (part of the explanation at least) has been done to simplify the language.

Like many language features this technique is one of style, but did come with some confusion for coders. 

If we still wish to use currying within our functions, could we use the returning of closures in the current Swift implementation? 

## Example 1: Adding two numbers in Swift
One of the simplest functions I can think of is one that calculates the sum of two numbers. That is, it adds them together.

We could create the function 

```swift
func add(_ num1: Int, num2: Int) -> Int {
    return num1 + num2
}

add(3, num2: 4) // 7
```

which does indeed sum two numbers together, with the result of adding three and four being seven.

However, back to the mathematical definition, we can change the function signature to take arguments on at a time, returning new functions at each step. 

```swift
func add(_ num: Int) -> (Int) -> Int {
    return { $0 + num }
}

let add3 = add(3)
add3(5)
```

I do apologise for the rather tricky renaming of the functions to sum. In any case, we can present a rather manual version of our curried function which takes all of the functions at once. I've mangled this into the following function:

```swift
func sum(_ num: Int) -> (Int) -> (Int) -> Int {
    return { y in
        return { z in
            return num + y + z
        }
    }
}

sum(2)(4)(8)
```

So each intermediate function takes exactly one function. This solution is quite manual this solution, and would need to be produced for every possible function.

## Automating the currying process
The sum above has a series of returned functions. This is one of those instances where we ask ourselves whether we can do better. 

Our original add function (repeated here)

```swift
func add(_ num1: Int, num2: Int) -> Int {
    return num1 + num2
}
```

deals only with `Integer`. Could we create a function that converts this to the currying declaration syntax. This would prevent us from having to recreate the function as above:

```swift
func curry(_ function: @escaping (Int, Int) -> Int) -> (Int) -> (Int) -> Int {
    { (a: Int) in
        { (b: Int) in
            return function(a, b)
        }
    }
}

let curriedAdd = curry(add)
curriedAdd(2)(3) // 5
```

This can of course work for any function that deals with `Integer` types (more of that later).

However using Swift's map function means that we can reapply this function to all elements in an array:

```swift
let xp = (1...3).map(addTwo).reduce(0, +) // 12
```

but this only works with functions that have `Integer` as parameters. What else might we do?

## Generic Currying
We can use Swift's generics to help us out here.

We can curry a function using this impressively named `curry` function

```swift
func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> ((B) -> C) {
    return { (a: A) -> ((_ b: B) -> C) in
        return { (b: B) -> C in f(a, b) }
    }
}

curry(add)(4)(5) // 9
```

which we can see is used with `curry(add)(4)(5)`, where `add` is our target function. As you can see adding 4 to 5 does indeed give us 9!

We can also develop the inverse function:

```swift
func uncurry<A, B, C>(_ f: @escaping ((A) -> ((B) -> C) )) -> (A, B) -> C {
    return { (a: A, b: B) -> C in
        return f(a)(b)
    }
}

let uncurried = uncurry(curry(add))
uncurried(4, 5) // 9
```

This does of course mean we have reversed our `curry` function, which takes us back to our initial state. 

## Is Currying Worth It?
Like [Pure functions](https://stevenpcurtis.medium.com/can-you-write-pure-functions-in-swift-8920f7ac0705) we can argue that in our day to day iOS work we do not need to know about currying functions.

However, by giving all the parameters to a function at once can give several advantages. It can make code easy to read, and mapping curried functions can make much of sense in some situations.

Will the syntax make it's way back into Swift? That's highly doubtful, but it is something we will have to keep tabs on over time and bear in mind especially if we have developers from different backgrounds within any particular team.

# Conclusion
Currying is part of functional programming, and it certainly does help to keep in touch with these concepts and understand the wider world of programming. It probably means we do not yet need to know Haskell, but studying it might (or might not) be worthwhile. There is probably benefit, but I'll leave that analysis to you!

In any case I certainly hope this article has helped you out!

I'd love to hear from you if you have questions

Subscribing to Medium using this link shares some revenue with me.
