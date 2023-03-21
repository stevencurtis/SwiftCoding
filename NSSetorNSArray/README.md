# Battle of the Data Structures: A Comparison of Set and Array in Swift
## It's about complexity

Difficulty: *Beginner* | Easy | Normal | Challenging

This article has been developed using Xcode 14.2, and Swift 5.7.2

# Before we begin
## Prerequisites:
None

## Terminology:
Data structures: A way of formatting data

# Which is what?
Where you put your data really matters. Two commonly used data structures in Swift are Set and Array. So how might you choose between the two?

## Set
A set is an unordered collection of objects. These objects are unique within the set, meaning that we do not have duplicates. 
An example of a set with String elements might be visualized as something like:
[Images/set.png](Images/set.png)
The Set type is bridged to NSSet which itself inherits from NSObject. From the documentation, checking membership is an operation bounded by O(n) and is amortized as O(1), while the bridging itself is an O(1) operation.

## Arrays
An array is an ordered collection of objects. These objects can be repeated.
An example of an array with String elements might be visualized as something like:

[Images/array.png](Images/array.png)

The Array type is zero-indexed. In general an array is slower than a set because we may have to shuffle elements in order to add or remove elements.
However, when we check membership we are sure that the operation is O(1).

## Performance is tricky?
Well, yes. If you are looking for performant data access or updates (and have data which does not contain duplicates) it really depends on what you want to do.
Do you wish to access the data? What is the context for it? It's worth understanding the difference between Set and Array in Swift and thinking about what is better for your needs.

# Conclusion
The conclusion here is "it depends". Because of course it is.
What do You think?
I've a more in-depth article about [Arrays](https://stevenpcurtis.medium.com/arrays-an-essential-programming-data-structure-56b0798c861b), and one about [Sets](https://medium.com/swlh/sets-in-swift-94cea4dd7c9f) if you wish to read further.
