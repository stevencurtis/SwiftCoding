# Swift's Type annotations
## They can be inferred

Let's take a look.
Difficulty: **Beginner** | Easy | Normal | Challenging

This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites
None

# type annotation

There are times where we would want to explicitly declare the type of a property. Something like this:

```swift
var count: Int = 0
```

The type is optional, and the following is more than acceptable in Swift.

```swift
var count = 0
```

where the type can be inferred as an integer.

So why would we ever want to explicitly declare a type?

I would say generally for clarity. Or to clear up an ambiguity.

When Swift infers the type it might not do quite what we want. Consider the following code

```swift
var number = 0 // inferred Int
var numberFloat: Float = 0 // explicit Float
```

If we want `number` to be a `Float` we would need to explicitly define that (as in the `numberFloat` example).

Type inference may not always be straightforwards, so type annotation can be used alongside various Swift construct including variables, constants, function parameters and return types.

It's just that good!

# Conclusion
I usually let Swift infer the type.

You?
