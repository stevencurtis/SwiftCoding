# What Is A Property Wrapper in Swift?
## They are SO useful

o!

Difficulty: Beginner | **Easy** | Normal | Challenging

# Prerequisites:
None

# Terminology:
Property Wrapper: A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property

# The Context
We can calculate the area of a square. It's not too tricky, so we can use the multiplication operator to calculate an area and the `sqrt` function to return an edge from an area.

[area](images/area.png)<br>

Nothing too tricky here!

# The Idea
[wrapped](images/wrapped.png)<br>

We can wrap a property or value into a context. In the case of the example below, the value we enter into the property wrapped does not have to be identical to the value that comes out of the property wrapper as a transformation can take place (that is the point in the example below). 
Speaking of that example, let's dive in!

# The Code
Here is some relatively simple code that I might produce in order to calculate the area of a square.

```swift
struct Squared {
    private var edge: Double
    
    var area: Double {
        get {
            edge * edge
        }
        set{
            edge = sqrt(newValue)
        }
    }
    
    init(edge: Double) {
        self.edge = edge
    }
}

let sq = Squared(edge: 10)
print(sq.area) // 100
```

which prints out the area to the console. This is nice, but there is some boilerplate code there. We are doing some calculations in our `Squared` struct - and if we need to reuse that logic we'd be out of luck.

Isn't there a Swifty solution for this? There certainly is. They're called Property Wrappers. 

# Implementing Property Wrappers
We can implement a Property Wrapper to abstract this code away. In this example, I've called the code `Square`:

```swift
@propertyWrapper
struct Square {
    private var value: Double

    var wrappedValue: Double {
        get {
            value * value
        }
        set {
            value = sqrt(newValue)
        }
    }
    
    init(wrappedValue: Double) {
        value = wrappedValue
    }
}
```

Note that the `@propertyWrapper` attribute tells Swift how we wish to use `Square`, while the propertyWrapper itself can contain it's own properties (in this case, a `Double` called value). 

We can use this new property wrapper syntax in order to have easily readable code. 

```swift
struct Squares {
    private var _edge: Square
    
    var area: Double {
        get {
            _edge.wrappedValue
        }
        set{
            _edge.wrappedValue = newValue
        }
    }
    
    init(edge: Double) {
        _edge = Square(wrappedValue: edge)
    }
}
```

This is all in the cause of writing more easily readable code, and I hope this has helped you out in some form.

# Conclusion

In any case I certainly hope this article has helped you out!

I'd love to hear from you if you have questions

Subscribing to Medium using this link shares some revenue with me.

