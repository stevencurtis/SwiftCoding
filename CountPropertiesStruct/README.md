# Count the Number of Properties in a Struct  
## Yes! It is possible

![Photo by Mirko Blicke on Unsplash](Images/photo-1511351817482-e0d6127f20bb.jpeg)<br/>
<sub>Photo by 
Mirko Blicke on Unsplash<sub>

Difficulty: Beginner | Easy | *Normal* | Challenging
This article has been developed using Xcode 12.0.1, and Swift 5.3

# Terminology:
Property: An association of a value with a class, structure or enumeration
Struct: An object defined in Swift, using pass by value semantics

# Prerequisites
- Be able to [create a basic Swift application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)

There are plenty of reasons why we might want to know the number of properties within a given `struct`.

## The real example (for those interested)
I wanted to insert fields into an SQL table. I could read the columns from the table using `PRAGMA table_info`, and then I want to insert the data a client would like into that table from a generic struct - with the idea that our code can work with any SQL table and any client providing any struct. Phew!

## The example code
There can be a simple `struct` that stores an animal
```swift 
struct Animal {
    var name: String
    var species: String
    var owner: String
}
```

which can then be set up as an instance of (in this case) an `Animal`. 

```swift
var derek = Animal(name: "Derek", species: "Dog", owner: "Kim")
```

We can then set up a `Mirror` 

```swift
var mirror = Mirror(reflecting: derek)
```

and then the values can be printed to the console

```swift
print (mirror.children.map{ $0.value })
// ["Derek", "Dog", "Kim"]
```

also going further we can count the number of children, and therefore the number of properties

```swift
print (mirror.children.count)
// 3
```

this also works with a `struct`, which is excellent!

```swift
var ahmed = Person(name: "Ahmed", age: 21)
print (mirror.children.count)
```

## The optional question
Optional properties are still properties, and therefore still count (for want of a better word) for this count.

So an optional does indeed contribute to the `mirror.children.count`

# Conclusion
You can read more about [reflection in Swift](https://stevenpcurtis.medium.com/reflection-in-swift-e8dd5afa777f).

This is a feature of Swift that has helped me to produce code to solve a specific problem that I had. For you? This is a great feature of Swift that you should have in your coding toolkit.

Stay safe, stay coding.

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 