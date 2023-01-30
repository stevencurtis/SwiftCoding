# How does Assembly work - A Swift guide
## Fun!

Assembly programming is often seen as rather a black box for Front-End developers.

This article is about using Swift to see something about assembly programming. This is going to be interesting!

Difficulty: Beginner | Easy | **Normal** | Challenging
This article has been developed using Xcode 12.0, and Swift 5.3


# Prerequisites:
- You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), or a [Playground](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to run Swift code
- Some of the functions use the  [inout parameters](https://medium.com/@stevenpcurtis.sc/inside-swifts-inout-parameters-f66fc39f3e8c)

# The challenge

Imagine that you have a programming language that has just four operations - ZERO, ASSIGN, INCR and LOOP.

The four operations are as described;
 - ZERO: Sets an input parameter (x) to zero (0)
 - ASSIGN: This function will assign the value of y to x (x = y)
 - INCR: Once this function is called it will assign x + 1 to the input parameter (x)
 - LOOP: Operations written within brackets will be executed the number specified by the parameter (x) times
 
 Now it is obvious that we have suitable functions in Swift that allow us to perform all the operations that we would ever want.  The idea is to *not* use them, and rather build them out of the four operations above.
 
## The four operations are listed here

**Inc**
This function increments and Integer, that is increases a number by one (say 2 -> 3, and 5 -> 6)
```swift
func inc(x: inout Int) {
    x = x + 1
}

var val = 2
inc(x: &val)
print (val)
```

**assign**
Assignment is familiar to most programmers, and in Swift this is represented by the equals operator =.
```swift
func assign(x: inout Int, y: inout Int) {
    let temp = y
    x = y
    y = temp
}

var firstVal = 2
var secondVal = 3
assign(x: &firstVal, y: &secondVal)
print (firstVal, secondVal)
```

**zero**
Zero assigns any number input to zero
```swift
func zero(x: inout Int) {
    x = 0
}

var preZero = 6
zero(x: &preZero)
print (preZero)
```

**loop**
A loop executes a function n times, using the following:
```swift
func loop(_ times: Int, _ function: () -> ()) {
    for _ in 0 ..< times {
        function()
    }
}

var num = 1

loop(10) {
    inc(x: &num)
    print("Hi!\(num)")
}
```

## Expand to further operations

**dec** leverages the inc operator to decrement a number using increment. This can be seen below:
```swift
func dec(x: inout Int) {
    var y = 0
    var z = 0

    loop(x) {
        y = z
        inc(x: &z)
    }
    x = y
}

var numToDec = 4
dec(x: &numToDec)
```

**sub**
We can subtract a number from another number by using the loop defined above.
```swift
func sub(x: inout Int, y: Int) {
    loop (y)
        { dec(x: &x) }
}

var numToSum = 4
sub(x: &numToSum, y: 3)
print (numToSum)
```

**isZero**
Instead of using the `Bool` type here 0 represents false, and 1 represents true.
```swift
func isZero(x: Int) -> Int {
    var y = 1
    loop (x)
        { y = 0 }
    return y
}

var isThisZero = 2
print (isZero(x: isThisZero))
```

**lessThanEqual**
Less than or equal can be calculated using `isZero` - if we subtract x and y this will return true (well 1) if the result is zero.
```swift
func lessThanEqual(x: Int, y: Int) -> Int {
    var initial = x
    sub(x: &initial, y: y)
    return isZero(x: initial)
}

print (lessThanEqual(x: 3, y: 2))
```

**greaterThanEqual**
Greater than equal can be calculated using lessThanEqual
```swift
func greaterThanEqual(x: Int, y: Int) -> Int {
    return lessThanEqual(x: y, y: x)
}
```

**not**
Not also represents true with 1 and false with 0, and can be calculated using `isZero`
```swift
func not(x: Int) -> Int {
    return isZero(x: x)
}

print (not(x: 0))
print (not(x: 1))
```

**greaterThan**
Greater than is not lessThanEqual, meaning:
```swift
func greaterThan(x: Int, y: Int) -> Int {
    let z = lessThanEqual(x: x, y: y)
    return not(x: z)
}
```

**lessThan**
Less than is `greaterThan` with x and y values transposed
```swift
func lessThan(x: Int, y: Int) -> Int {
    return greaterThan(x: y, y: x)
}
```

**add**
We can add two numbers by using a loop and the `inc` function
```swift
func add(x: Int, y: inout Int) -> Int {
    loop (x)
        { inc(x: &y) }
    return y
}
```

**and**
We add two numbers by simply multiplying, although this assumes that we only and `Bool` values (which 0 or 1 here).
```swift
func and(x: Int, y: Int) -> Int {
    return multiply(x: x, y: y)
}

print (and(x: 0, y: 0))
print (and(x: 0, y: 1))
print (and(x: 1, y: 0))
print (and(x: 1, y: 1))
```

**multiply**
We can multiply two numbers by using `add` and a loop.
```swift
func multiply(x: Int, y: Int) -> Int {
    var z = 0
    loop (x) { z = add(x: y, y: &z) }
    return z
}

print(multiply(x: 2, y: 8))
```

# Conclusion

That wasn't that hard was it? 

You can us a limited amount of operators to create other operators - who knew? All in Swift too!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
