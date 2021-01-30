# Zip and Zip2Sequence in Swift
## What are they, and where should they be used?

![photo-1522926193341-e9ffd686c60f](Images/photo-1522926193341-e9ffd686c60f.png)
<sub>Photo by Jan Meeus @janmeeus</sub>

# Before we start
Difficulty: **Beginner** | Easy | Normal | Challenging<br>
This article has been developed using Xcode 12.2, and Swift 5.3

## Prerequisites
* You'll need to either be able to write [an iOS application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) or write some Swift code in [Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)
* Some knowledge of [Tuple types](https://medium.com/p/5ee9106283be) would be useful for this article

## Keywords and Terminology
Tuple: A way in Swift to allow you to store multiple values in a single variable <br>
Zip: Creates a sequence of pairs created from two underlying sequences

# This article
## Background
You may have needed to join two different Arrays into one (same ordered) collection like in the [LeetCode 211 constant](https://github.com/stevencurtis/SwiftCoding/tree/master/LeetCode/Contests/216).

This article explains what is going on!

## The simple examples
We can zip up a couple of pairs of Integer Arrays
```swift
let scores = [1,2,3]
let ages = [22,33,44]
let pairs: Zip2Sequence<[Int], [Int]> = zip(scores, ages)
print (pairs)
```
So the output to the console is given as the following:
```swift
Zip2Sequence<Array<Int>, Array<Int>>(_sequence1: [1, 2, 3], _sequence2: [22, 33, 44])
```

This is good, because it essentially iterates over the items, and produces a resulting sequence. 

Unfortunately, we are missing one important thing. Labels would be useful, and stop us having to use the Swift placeholder labels of .0 and .1.

```swift
for pair in pairs {
    print (pair)
    print (pair.0)
    print (pair.1)
}
```

## Use a typealias to add labels
If we take each element of the `Zip2Sequence` to be a game, could we create a `Game` `typealias` and cast to it?

Here is the method for doing so:

```swift
typealias Game = (score: Int, age: Int)

let pairsArray = Array(pairs) as [Game]

for game in pairsArray  {
    print (game)
}
```

which gives the output:

```swift
(score: 1, age: 22)
(score: 2, age: 33)
(score: 3, age: 44)
```

we can even go so far as to 
```swift
print (game.age)
print (game.score)
```

So what is happening?

The `zip(_:_;)` method creates the same amount of pairs as the shortest sequence of the two constituent Arrays. Each element of the resulting `Zip2Sequence` is actually a `Zip2Sequence<[Int], [Int]>.Element`which doesn't have any labels. 

To make these easier to work with, a tuple type is created which just those labels required, and then we can use Swift's casting to actually use these types! 

Awesome! 

# Conclusion
By casting `Zip2Sequence` there is a chance to use the rather wonderful feature of `tuple` types, labels. The idea is that this makes it easier for both an active programmer and a user who would need to read and understand the code as a client (that is, possibly another programmer).

I hope this helps you on your coding journey.

Thanks for reading!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
