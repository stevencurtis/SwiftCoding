# The Prototype Pattern in Swift
## Clone it!

![Photo by 
Arseny Togulev](Images/photo-1555255707-c07966088b7b.jpeg)<br/>
<sub>Photo by Arseny Togulev<sub>

When you copy Swift objects you would need to be careful that all of the constituent layers of the class are all copied. Don't worry - we can do that in Swift using `NSCopy()`, and to do so let us look at the article below. 

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

# Terminology:
Design Pattern: a general, reusable solution to a commonly occurring problem
The prototype pattern: a creational pattern that deals with object creation mechanisms, aiming to create objects in a manner suitable to the situation.

# The prototype pattern
When you use the prototype pattern you don't need to subclass, and can configure clones individually.

# NSCopying
Many tutorials about the prototype pattern choose not to use the [`NSCopying` Protocol](https://stevenpcurtis.medium.com/nscopy-to-duplicate-objects-in-swift-ec5a52556bbb) possibly because the protocol returns `Any` rather than the specific type. However there is a clear advantage to using `NSCopying` as other developers will be familiar with the protocol. In any case please don't make your own `clone` function where `copy` is the ordinary way to incorporate this functionality in your code.

# The example

```swift
class PersonClass: Equatable, NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let newElement = PersonClass(name: name, age: age)
        return newElement
    }
    
    static func == (lhs: PersonClass, rhs: PersonClass) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let pClass = PersonClass(name: "Arnold", age: 84)
let bClass: PersonClass = pClass.copy() as! PersonClass

print (pClass.name)
print (bClass.name)
```

When a `PersonClass` instance using `copy(with:)` the current instance's properties are duplicated. It is this duplication which is at the heart of the prototype pattern.
`bClass` is a new object, created as a "clone" of `pClass`. 

They are separate instances, but bClass was created by copying pClass and not by initializing a completely new instance, which is the essence of the Prototype Pattern. 

## Why use NSCopying?
The NSCopying protocol provides a standard way to make exact copies or clones of existing objects in Swift. Using NSCopying can be advantageous over simply creating a new instance in a few scenarios:

Prototyping: If you want to create a new object based on an existing object's state (as in the Prototype Pattern), NSCopying allows you to do this elegantly without manually copying over each individual property.
Performance: For complex objects, creating a new instance and setting its properties can be computationally expensive. In these cases, copying an existing object can be more performant.
Immutability: If an object is mutable (i.e., its properties can be changed), and you want to pass around a snapshot of its current state that won't be affected by future changes, you can create a copy.
Safety: If you want to ensure that an object you're passing to other parts of your program isn't modified unexpectedly (because Swift classes are reference types), you can pass a copy instead.

# Warning
`NSCopying` performs a shallow copy rather than a deep copy. If the object being copied contains other complex objects or collections, only the references to those objects will be copied, not the actual objects themselves. If you need a deep copy you're going to need to implement suitable logic yourself.

 In some cases, you might want changes to an original object to be reflected in its copies (in which case a shallow copy is appropriate). In other cases, you might want the copy to be independent of the original (in which case a deep copy is appropriate).
 
 Example:
 
 ```swift
 class Item {
    var name: String

    init(name: String) {
        self.name = name
    }

    func copy() -> Item {
        let copy = Item(name: name)
        return copy
    }
}

class Person {
    var name: String
    var favoriteItem: Item

    init(name: String, favoriteItem: Item) {
        self.name = name
        self.favoriteItem = favoriteItem
    }

    func copy() -> Person {
        let copiedItem = favoriteItem.copy()
        let copy = Person(name: name, favoriteItem: copiedItem)
        return copy
    }
}

let myItem = Item(name: "Book")
let person1 = Person(name: "John", favoriteItem: myItem)
let person2 = person1.copy()
let person3 = Person(name: person1.name, favoriteItem: myItem)

// Modify myItem
myItem.name = "Bicycle"

print(person1.favoriteItem.name) // Prints "Bicycle"
print(person2.favoriteItem.name) // Prints "Book"
print(person3.favoriteItem.name) // Prints "Bicycle"
 ```

So person 1 is changed, but since person2 is created with a shallow copy the item name is not changed. Person 3 has the logic for a deep copy, so the item name is changed!

Nice!

# Conclusion
I hope this article has been of use. Implementing `NSCopying` means we can create new instances of a class with identical properties, but we need to be mindful of shallow and deep copying when we do so.

Thanks for reading!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
