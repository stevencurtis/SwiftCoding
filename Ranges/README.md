# Using Swift's Ranges
## Open and half-open?

[photo-1559827260-dc66d52bef19](Images/photo-1559827260-dc66d52bef19.png)
<sub>Image by Silas Baisch @silasbaisch</sub>

# Before we start
Ranges are extremely useful when you produce Swift applications as they allow you to select a range (that is, a subset of an existing) type.

Difficulty: **Beginner** | Easy | Normal | Challenging
This article has been developed using Xcode 12.1, and Swift 5.3

## Prerequisites
* You will be expected to be aware how to either make a [Single View Application in Swift](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) or use a [Playground](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)
* [Ranges](https://medium.com/swlh/zero-indexed-arrays-f752a47abf65) are zero-indexed in a similar fashion to Arrays
* The [Integer](https://medium.com/@stevenpcurtis.sc/what-is-an-integer-1a26cdd18d68) type is referred to in this article, as are [String](https://medium.com/@stevenpcurtis.sc/what-is-a-string-232ef38d21d6) types, so familiarity with these would be useful
* This article assumes some familiarity with [collectiontypes](https://medium.com/@stevenpcurtis.sc/swifts-collections-the-collected-works-772538c3107a) in Swift

## Keywords and Terminology
Range: The elements between the highest and lowest values

# Swift Ranges
## The Closed Range Operator
A `ClosedRange` is declared by using the `...` operator between two `Int` Integer types, where we can think of the first `Int` as the lowerBound, and the second as the upperBound. The range **includes** the upper bound.

```swift
let range : ClosedRange = 0...5
print (range) // 0...5
print(range.first) // Optional(0)
print(range.last) // Optional(10)

for index in range {
    print (index) // prints, in turn, the values from 0 to 5 inclusive
}
```

This can be used to see whether a value is contained within this particular range of values

```swift
range.contains(4) // true
range.contains(8) // false
```

This range can then be used to iterate over a collection, for example a collection of `Strings` (in this case an `Array`, which is storying the names of some people

```Swift
let people = ["Arjun", "Tisha", "Zaara","Bob", "Kasia", "Natalia", "Colin"]
print (people[range])
```

** Note**
Because a closed range includes its upper bound, a closed range whose lower bound is equal to the upper bound contains that value so by definition so the following is true

```swift
let basicRange: ClosedRange = 0...0
basicRange.isEmpty // false
basicRange.contains(0) // true
```

## The Half Open Range Operator
This is similar to the Closed Range Operator, as a half-open range. The range **excludes** the upper bound.
```swift
let halfRange: Range = 0..<4
let animals = ["Cat", "Dog", "Rabbit", "Fox", "Elephant", "Donkey"]
print (animals[halfRange]) // ["Cat", "Dog", "Rabbit", "Fox"]
```

## The one-sided operator
A one-sided operator only has the lower  bound. Effectively this means "move as far as possible in the direction of the operator".

```swift
let oneSidedRange: PartialRangeThrough = ...3
var cities = ["London", "Tokyo", "Delhi", "Shanghai", "Mexico City", "São Paulo", "Mumbai", "Cairo"]
print (cities[oneSidedRange]) // ["London", "Tokyo", "Delhi", "Shanghai"]
```


# Conclusion
I hope you have enjoyed reading this tutorial. 

It has covered The Closed Range Operator, The Half Open Range Operator and The one-sided operator. This is useful when we write our code for all sorts of uses! I hope it certainly has been useful for you..!

The [Repo](https://github.com/stevencurtis/SwiftCoding/tree/master/Ranges) has some files that you might find useful to download at your leisure.
