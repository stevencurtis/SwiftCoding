# Understanding Any and Opaque Types in Swift
## Choosing the Right Tool for Abstraction

Swift has tools to abstract types, and this lets developers write reusable code in their projects.
Two of these features are `Any` and opaque types, that provide ways to work with types. It's important to disambiguate the two and know when to use each one.
So here is my latest article, examining these two types and their differences, best practices and how to use them.

# A Short Comparison

[Images/table.png](Images/table.png)<br>

# Any in Swift
Any is a type-erased placeholder that can represent any Swift data type including class, struct, functions and more.
This enables an array to store values of different types, for example:

```swift
let items: [Any] = [42, "Hello, world!", 12.34, true, CGFloat.pi]
```

It should be noted that to access the original element you will need to type cast (for example with as?).
I've already written an article on this exact topic: https://medium.com/@stevenpcurtis/the-ultimate-type-eraser-swifts-any-f7d34036d6ad

# Opaque Types in Swift
Opaque types provide a type-safe abstraction to represent a specific but hidden type. Opaque types keep type information hidden from the consumer while ensuring the actual type information is preserved for type safety.

So opaque types are useful when you want to return a type, and is commonly used when returning protocol-conforming types from functions without specifying the concrete type.

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

func makeBand() -> some Band {
    let lead = Piano()
    let rhythm = Drum()
    let band = RockBand(lead: lead, rhythm: rhythm)
    return band
}

let myBand: some Band = makeBand()
```

A type like `RockBand<Detuned<Piano>, Drum>, Drum>` is unwieldy, so using the makeBand factory returning `SomeBand` is rather convenient.

I've already written an article on this exact topic: https://github.com/stevencurtis/SwiftCoding/tree/master/OpaqueTypes

# When to Use Any vs. Opaque Types
## Use Any When
- You need to work with collections that contain multiple unrelated types.
- Type flexibility is a priority over type safety, such as working with data sources from Objective-C or JSON.
- You're handling cases where type information is not essential, like logging or debugging scenarios.

## Use Opaque Types When
- You want to keep the underlying type hidden but ensure it conforms to a specific protocol or set of constraints.
- You're designing APIs where you need to enforce a protocol's interface without exposing the concrete type, which is useful for encapsulation.
- You want to avoid type casting and maintain Swift's strict type safety within the bounds of the known protocols.

# Conclusion
`Any` and opaque types (`some`) offer distinct approaches to abstraction. `Any` allows for flexibility and mixed types but sacrifices readability. Opaque types provide strong type guarantees, making them ideal for controlled API exposure and encapsulation.

I certainly hope this article has helped you out!
