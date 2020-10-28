# That little Swift Bug: Protocol Customization Points
## It all went wrong!

![Photo by Gavin Allanwood](Images/photo-1518796745738-41048802f99a.jpeg)<br/>
<sub>Photo by Gavin Allanwood<sub>

Difficulty: Beginner | Easy | Normal | **Challenging**<br/>

When you are looking through the use of [Protocols](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18) in Swift, you'll come across [Dynamic Dispatch].


# Statically dispatching protocol methods at compile time
When a type adopts a `protocol` and an instance of the type is inferred to be a concrete type, all of the protocol methods are statically dispatched at compile time.

So a concrete instance of a `Dog` can conform to a protocol `Animal`, and here `fluffy` is inferred to be of concrete type `Dog`. Since this is using Swift's type inference, both the property `name` and the method `func animalSound() -> String` are statically dispatched at runtime.

The code:

```swift
protocol Animal {
    func animalSound() -> String
}

extension Animal {
    var name: String {"Doggy"}
    func animalSound() -> String {
        return "Woof"
    }
}

final class Dog: Animal { }

let fluffy = Dog()

fluffy.name
fluffy.animalSound()
```

# The issue 
Let us first take the code. If we accept that tents can be a type of building, and that dome tents and tunnel tents are indeed tents, this will help us to understand the following example:

```swift
protocol Building {
}

extension Building {
    var walls: Int { return 4 }
}

protocol Residential: Building { }

struct Tent: Residential {
    var walls: Int {return 0}
}

let dome = Tent()
print (dome.walls) // 0
let tunnel: Residential = Tent()
print (tunnel.walls) // 4
```

the result is that a `Tent` is a customized implementation of then `walls` property. 

Because the tunnel has a declared protocol type at compile time (and the fact it has been assigned as a `Tent` instance is irrelevant here, as we see it does not receive the customization and returns 4 walls (and don't be silly - a tent does not have any walls). 

The customization point, that is

```swift
struct Tent: Residential {
    var walls: Int { return 0 }
}
```

is not received by the protocol type. This is **not** the behaviour that I would like in this particular example.

# The solution 
The building protocol can define a Method Requirement within the `Building` protocol.

```swift
protocol Building {
    var walls: Int { get }
}

extension Building {
    var walls: Int { return 4 }
}

protocol Residential: Building { }

struct Tent: Residential {
    var walls: Int { return 0 }
}

let dome = Tent()
print (dome.walls) // 0
let tunnel: Residential = Tent()
print (tunnel.walls) // 0
```

Here the customization point (given, as before as):

```swift
struct Tent: Residential {
    var walls: Int {return 0}
}
```

is now included in the `tunnel` instance even when this is declared as a protocol type.

# The Theory 
What is happening behind the scenes is the difference between Static Dispatch and Dynamic Dispatch.

Concrete types (that is the dome) are statically dispatched and therefore resolved at compile time. If the property is defined in the protocol, then static dispatch is used and if it isn't then dynamic dispatch is used - and it is in the final case where dynamic dispatch would not use the customization point at runtime (since Swift doesn't "know" at that point that the `tunnel` is a tent as it wholly conforms to the protocol).

# Conclusion
Static and dynamic types can be a little tricky when we are coding in Swift! This should be considered far from Apple communicating this as a language feature (or not), but rather is informed by the inner working of static and dynamic dispatch.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 