# Swift's Reduce Function
## Higher-order

I've previously written an [article](https://stevenpcurtis.medium.com/create-your-own-reduce-function-in-swift-e92b519c9659) about implementing reduce, but never an article about the higher-order function reduce in Swift. It's time to right that wrong.

Difficulty: **Beginner** | Easy | Normal | Challenging<br/>
This article has been developed using Xcode 15.0, and Swift 5.9

## Terminology:
Higher-order function: A function that takes one or more functions as arguments or returns a function as its result.
Reduce: A higher-order function that returns the result of combining the elements of a sequence using a closure

## Prerequisites:
(Be able to code Swift using Playgrounds)[https://stevenpcurtis.medium.com/coding-in-swift-playgrounds-1a5563efa089]

# The Basic Syntax

The `reduce` function takes two parameters: an initial value and a closure that defines how to combine the elements. The closure is applied sequentially to all elements of the collection along with an accumulated value (which starts as the initial value), resulting in a single final value.

```swift
let numbers = [1, 2, 3, 4, 5]
let result = numbers.reduce(0) { accumulator, element in
    // This closure (Int, Int) -> Int
    // combines accumulator and element in some way to product
    // a single Int
}
```

## The Example

The classic use of reduce is to sum an array and instead of using a while loop we can assign an initial value (0) and then the closure is applied sequentially to all element of the collection until a single final value is returned.

```swift
let sum = numbers.reduce(0, { sum, number in sum + number })
// sum is 15
```

This can be reduced (lol) using Swift's shorthand arguments.

```swift
var numbers = [1,2,3,4]
numbers.reduce(0, {$0 + $1}) //10
```

## The Power of Reduce
The beauty of reduce lies in its versatility. While it's often used to sum numbers, it can perform any operation that combines elements into a single value. This could include multiplying elements, finding the maximum or minimum, concatenating strings, or even building a custom data structure.

Here's an example that concatenates strings from an array:
```swift
let words = ["Swift", "is", "awesome"]
let sentence = words.reduce("") { partialResult, word in partialResult + " " + word }
// sentence is " Swift is awesome"
```

# The Fun of Reduce

Suppose we have a list of transactions where each transaction is represented by a tuple containing a category (like groceries, utilities, entertainment) and the amount spent. We want to use reduce(into:) to calculate the total amount spent in each category.

```swift
let transactions = [
    ("groceries", 120.0),
    ("utilities", 80.5),
    ("groceries", 30.0),
    ("entertainment", 200.0),
    ("utilities", 50.0),
    ("groceries", 70.0)
]

let totalSpentPerCategory = transactions.reduce(into: [String: Double]()) { totals, transaction in
    let (category, amount) = transaction
    totals[category, default: 0] += amount
}
```
 
## Beyond Arrays: Working with Sets and Dictionaries
Reduce is not limited to arrays; it can be applied to sets and dictionaries too. This expands its utility beyond simple lists, enabling aggregation and transformation operations on diverse data structures.

```swift
let words = Set(["apple", "banana", "cherry", "date", "apple", "banana"])
let wordLengthSum = words.reduce(0) { $0 + $1.count }
```

In this case, reduce helps in calculating the total length of all unique words in a set, illustrating how reduce works seamlessly with sets.

# Reduce with KeyPaths

Swift's powerful type system and keyPath feature can be leveraged to make reduce even more concise, particularly when dealing with objects or complex data types.

```swift
struct Product {
    let name: String
    let price: Double
}

let inventory = [
    Product(name: "Keyboard", price: 99.99),
    Product(name: "Mouse", price: 49.99),
    Product(name: "Monitor", price: 199.99)
]

let totalInventoryValue = inventory.reduce(0) { $0 + $1[keyPath: \.price] }
// totalInventoryValue is the sum of all product prices
```

By using keyPaths within the reduce function, you can succinctly traverse and aggregate property values of complex objects.

# Conclusion

I hope this article has helped someone out, and perhaps I'll see you at the next article?

The reduce function in Swift is a powerful tool that can simplify code and make solutions easier to understand. I hope you feel free to further experiment with higher-order functions and further build your Swift skills.
