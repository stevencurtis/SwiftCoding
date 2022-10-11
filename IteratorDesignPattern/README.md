# The Iterator Design Pattern in Swift
## Move over it!

![Photo by Juan Encalada](Images/photo-1544620347-c4fd4a3d5957.jpeg)<br/>
<sub>Photo by Juan Encalada<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.5, and Swift 5.2.4

## Prerequisites: 
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* We use the [defer](https://medium.com/@stevenpcurtis.sc/using-the-defer-keyword-in-swift-b7916fa40f26) keyword in this article

# Terminology:
Design Pattern: a general, reusable solution to a commonly occurring problem
Iterator: In Swift, a protocol that allows you to loop through a sequence. That is, the protocol supplies values one at a time
IteratorProtocol: A protocol that provides the values of a sequence one at a time
Sequence: A Protocol that provides sequenced, iterative access to elements of the sequence


I've previously published a rather nice article covering the [IteratorProtocol](https://stevenpcurtis.medium.com/iterate-through-a-linked-list-in-swift-c1bc7ef14e07) and their use in Linked Lists. If you've knowledge of [Linked Lists](https://medium.com/@stevenpcurtis.sc/linked-lists-in-swift-a65354f77f5f) I'd recommend you read [that article now](https://stevenpcurtis.medium.com/iterate-through-a-linked-list-in-swift-c1bc7ef14e07), if not let us press on with this article!

# The Iterator Design Pattern in Swift
The iterator pattern solves the problem of how we might sequentially traverse a [collection](https://medium.com/@stevenpcurtis.sc/swifts-collections-the-collected-works-772538c3107a) of objects.

## Sequences
Swift helps us out by containing the `Sequence` protocol. In Swift [collections](https://stevenpcurtis.medium.com/swifts-collections-the-collected-works-772538c3107a) conform to the `Sequence` protocol, meaning that we can traverse the elements of the collection.


## Under the hood
We may well be familiar with traversing through a collection. In this example, an array of Strings can be traversed with a for...in a loop

```swift
let capitals = ["London", "New Delhi", "Naypyitaw", "Kathmandu"]

for capital in capitals {
    print (capital)
}
```

which outputs the following:
```swift
London
New Delhi
Naypyitaw
Kathmandu
```

what is actually happening is `makeIterator()` is called, that is the following:

```swift
var capitalIterator = capitals.makeIterator()
for capital in capitalIterator {
    print (capital)
}
```

Which gives the same output as before. 

**Adding Sequence**
To add sequence conformance to a type, `makeIterator()` needs to return an iterator. 

We can step through [Apple's example](https://developer.apple.com/documentation/swift/sequence) to get a grip on what is happening here.

We create a `CountDown` struct that, well, counts down.

```swift
struct CountDownIterator: IteratorProtocol {
    var current: Int
    mutating func next() -> Int? {
        if current == 0 {
            return nil
        } else {
            defer { current -= 1 }
            return current
        }
    }
}


struct CountDown: Sequence {
    var count: Int
    
    func makeIterator() -> some IteratorProtocol {
        return CountDownIterator(current: count)
    }
}
```
Which is called by:
```swift
let threeToGo = CountDown(count: 3)
for i in threeToGo {
    print (i)
}
```

Which then displays the countdown to the console:

```swift
3
2
1
```

Now in order to understand the code we need to accept that `defer` runs after the leave the current scope of the running function, for an explanation of this look [here](https://medium.com/@stevenpcurtis.sc/using-the-defer-keyword-in-swift-b7916fa40f26).

The `Sequence` protocol requires that we implement `func makeIterator() -> some IteratorProtocol`, and in turn that required we produce an object that conforms to `IteratorProtocol` (which itself requires that we implement `mutating func next() -> Int?`

Yet we can do better!

We can choose to make `CountDown` conform to both the `Sequence` and `IteratorProtocol`, making the sequence serve as its own iterator and giving the following result:

```swift
struct Countdown: Sequence, IteratorProtocol {
    var count: Int

    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}

let threeToGo = Countdown(count: 3)
for i in threeToGo {
    print(i)
}
```

which of course writes out the same result to the console:

```swift
3
2
1
```

## Technical note
Using an iterator may be less efficient than going through the elements directly, although a sequence should provide an iterator in O(1), and traversing usually takes place in O(n).

# Conclusion
A protocol that allows you to move through a sequence? That sounds like [IteratorProtocol](https://developer.apple.com/documentation/swift/iteratorprotocol), and this article has gone some way to explain the use of such iterators in Swift.
I hope this has been of some help to you.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
