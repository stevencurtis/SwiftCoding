# Understanding Swift's Opaque Types
## Useful for SwiftUI

![photo-1571775300229-7e84bff45eae](Images/photo-1571775300229-7e84bff45eae.png)
<sub>Photo by Qijin Xu</sub>

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br>
This article has been developed using Xcode 12.2, and Swift 5.3

## Prerequisites
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift, or be able to use [Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to be able to code in Swift
* This article does refer to SwiftUI, but is not a SwiftUI article. I have a number of SwiftUI articles, [Basic SwiftUI]()
* I lean rather heavily on [Generics](https://medium.com/better-programming/generics-in-swift-aa111f1c549)
* [Access Control](https://medium.com/swift-coding/access-control-in-swift-71228704654a) is briefly touched upon
* Some knowledge of [Protocols would be useful](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18)
* [Equatable](https://medium.com/@stevenpcurtis.sc/swifts-equatable-and-comparable-protocols-54811114a5cf) is used later in the article

## Keywords and Terminology
Opaque Types: A data type whose concrete data structure is not defined in an interface

# This project
## Background
SwiftUI makes use of the `some` keyword, as 

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: someView {
		ContentView()
	}
}
```

The (rather simplistic) explanation is that the `some` keyword indicates that the `body` property has an `opaque type`, that is obstruficating type information contained in the `body` (we can think of the type information as being private). `body` represents a class that implements `View`. You need a concrete object for the `View`, but it doesn't matter which `View` is used rather the capabilities of `some View` are needed.

# The Idea of a Reverse Generic type
Generic types let the code that calls a function type for that function's parameters and return a value in a way this is abstracted from the function implementation.

Let us look at the following `Generic` 

```swift
func printAnArray<T>(arr:[T]) {
    print ("Your Array is:")
    arr.forEach({ element in
        print (element)
    })
}

printAnArray(arr: [1,2,3])
```

which of course prints the following to the console:
```swift
Your Array is:
1
2
3
```

The code for the function `printAnArray` is written in a way that the code can work for `Integer` (as in the example), `String` or any other type that can be in the array. Essentially the the function uses the `T` type.

Opaque return types lets the function implementation pick the value it returns in a way that is abstracted from the code that calls the function.

**This means that we can return a type that conforms to a `protocol` without specifying any particular concrete type**. This means that we are further obstruficating the implementation details away from client code.

# The obstruficating example
Perhaps you wish to have the capabilities of a concrete type, without exposing that type to users. 

Let us look at an abstract example, using plain `struct` instances. In the example [type inference](https://medium.com/@stevenpcurtis.sc/literals-and-type-inference-in-swift-af9c49f035fc) could be used to avoid explicity declaring the types used, however for clarity these have been added in the code below.

Let us say all bands need to have instruments that can be tuned, and that a band only has one lead instrument and one rhythm instrument.

```swift
protocol Band { }

protocol Instrument {
    func tune() -> String?
}

struct Drum: Instrument {
    func tune() -> String? {
        return "Tune the drum through banging it"
    }
}

struct Piano: Instrument {
    func tune() -> String? {
        return "Tune the Piano through specialist equipment"
    }
}

struct Detuned<T: Instrument>: Instrument {
    func tune() -> String? {
        return nil
    }
}

struct RockBand<T: Instrument, U: Instrument>: Band {
    func tune() -> String? {
        return "Play together"
    }
    
    let lead: T
    let rhythm: U
    init(lead: T, rhythm: U) {
        self.lead = lead
        self.rhythm = rhythm
    }
}

let honkeyTonk: Detuned<Piano> = Detuned<Piano>()

let band: RockBand<Detuned<Piano>, Drum> = RockBand(lead: honkeyTonk, rhythm: Drum())
```

It should be noted that the band at the end has a rather **painful** type. This type of `RockBand<Detuned<Piano>, Drum>, Drum>` is really unfriendly to developers. Surely we can do better? In this case

```swift
func makeBand() -> some Band {
    let lead = Piano()
    let rhythm = Drum()
    let band = RockBand(lead: lead, rhythm: rhythm)
    return band
}

let myBand: some Band = makeBand()
```

Essentially we are wrapping the components that make the `Band` into a function, so in a sense the internal components are kept internal. 

However, Swift will still understand something about the internal types that make up `some Band`, as we will see below in the example to make clear some of the features of opaque types.

# The Example
Some dogs are happier than others, depending on the breed. In this rather simplistic implementation we have dogs that conform to a `Dog` `protocol`. I understand that I have later in this article called Pugs ugly, this is meant in fun as of course all animals are wonderful in every way. Onto the code:

```swift
protocol Dog {
    func isHappy() -> Bool
}

final class Labrador: Dog {
    func isHappy() -> Bool {
        return true
    }
}

final class Pug: Dog {
    func isHappy() -> Bool {
        return false
    }
}

// Generic function to show how generics work
func isDoggyHappy<T: Dog>(doggy: T){
    print (doggy.isHappy())
}

let dug = Pug()
print (isDoggyHappy(doggy: dug))

let lab = Labrador()
print (isDoggyHappy(doggy: lab))
```

we can even store an `Array` of `Dog`, which is the protocol.

```swift
var doggies: [Dog] = [dug, lab]
```

**The possible error**
However, if we modify the Dog Protocol to make dogs `Equatable` we introduce type/Self requirements

```swift
protocol Dog: Equatable {
    func isHappy() -> Bool
}
```

we get a [familiar error message](https://medium.com/@stevenpcurtis.sc/protocols-with-associated-types-in-swift-eec850af3c02) that Dog can only be used as a generic constraint - this is because although we are comparing two `Dog` instances there is no way for Swift to compare the concrete `Pug` and `Labrador` instances (if they had a name, is Tilly the Labrador the same as Tilly the Pug? Swift wouldn't know).

Further, if our client code isn't interested in the `type` of the `Dog` we are leaking the full return type of the `class`. 

That is, 

```swift
let dug: Pug = Pug() // dug is a Pug
let lab: Labrador = Labrador() // lab is a Labrador
```

So let us investigate the type `some` as a solution to this problem.

**The solution**
By using the `some` keyword we can return a placeholder for the type we return 

```swift
func makeGreatDog() -> some Dog {
    return Labrador()
}

let greatDog = makeGreatDog() // some Dog
let anotherDog = makeGreatDog() // some Dog
```

or 

```swift
func makeUglyDog() -> some Dog {
    return Pug()
}

let uglyDog = makeUglyDog()

```
and type casting still works

```swift
let greatDog = createLab() as! Labrador
```

Which we can now store in an Array of `Dog` instances

```swift
var doggies: [Dog] = [greatDog, greatDog]
```

However they are only Heterogeneous if the underlying type is the same, therefore:

```swift
var doggies: [Dog] = [greatDog, greatDog, uglyDog]
```

is illegal. Swift knows something about the underlying type and enforces this - we see the `protocol` as being used, but the Swift compiler knows how the `protocol` resolves.

It is for this reason that returning a random dog can be a problem, as the internally determined type is required. That means that the following will not compile:

```swift
func getRandomDog() -> some Dog {
    if Int.random(in: 0..<2) == 0 {
        return Labrador()
    }
    return Pug()
}
let doggy = getRandomDog()
```

Giving the error error: `Function declares an opaque return type, but the return statements in its body do not have matching underlying types.`, since `some Dog` will return a value of a single concrete type that conforms to `Dog` - the generic placeholder cannot be satisfied by multiple types.

# Key Things about opaque types
* An Opaque type is defined by the function implementation rather than by the caller, and can be created from a "make" function as in the start of this article
* A function must be consistent in it's use of an Opaque type and return the same one every time because Swift ultimately knows the underlying types
* Opaque types use associated types and self-requirements

# Conclusion
This is quite a heavyweight topic. However, I hope this article can help you in understanding this quite tricky part of Swift.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
