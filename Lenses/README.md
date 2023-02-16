# Using Lenses in Swift
## Change parts of immutable objects

# Before we start
Difficulty: Beginner | Easy | Normal | **Challenging**<br/>

## Keywords and Terminology:
Lenses: A lens consists of a getter and a setter, and are often described as functional getters and setters

## Prerequisites:
* It would be really useful if you has a good idea about both [getters and setters and their use in Swift](https://medium.com/swlh/property-getters-and-setters-in-swift-8157d5d027c7)
* It would be helpful if you had a good grasp of [generics in Swift](https://medium.com/better-programming/generics-in-swift-aa111f1c549)

# What is this about?
This is about Lenses. This is a guide to something that might well help out your functional programming, and help you to become a better programmer.

Now there are two parts to lenses, you might be looking through it to access part of an object (this is the getter). Alternatively we can choose to use a lens to change part of an object which acts like a setter - but crucially we are referring to immutable objects here so a new object will be returned when a change is made.

# What?
You can think of lenses as the functional equivalent of a reference.
Let us think of this in a Swifty way: we might be using Core Data and might use an object (PersonDB) which would be view on the data. You then might create a view on a specific Person, and then update that person from the view (and then update the original Person).

# Why?
We want to make sure that a small change in requirements only result in a small change in code. Lenses can help us to do just that.

# Examples
There is, inevitably a repo attached to this article. However, I will endeavour to reproduce some of this code right here.

So let us take this Person:

```swift
struct Person {
    let name: String
    let address : Address
}

struct Address {
    let houseNumber: Int? = nil
    let street: String
    let city: String
}

let person = Person(name: "Ronald McDonald", address: Address(street: "West Loop", city: "Chicago"))
```

we can easily access the name of a Person

```swift
print(person.name)
```

however to change the name is tricky. Person is a let constant, and that can be changed, but the name is also a let constant.

Now both of these **can** be changed as follows

```swift
struct Person {
    var name: String
    let address : Address
}

struct Address {
    let houseNumber: Int? = nil
    let street: String
    let city: String
}

var person = Person(name: "Ronald McDonald", address: Address(street: "West Loop", city: "Chicago"))
person.name = "The King"
```

however we are then making parts of the code rewritable when they should be immutable. This is NOT how our code should look.

Therefore in order to do this, we can use a lens:

```swift
struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}
```

The `struct` has two type parameters, `Whole` and `Part`. The get property is a function which takes an object if type `Whole` and returns a value `Part`. Likewise, set takes a value `Part` and an object `Whole` and returns the resultant `Whole`.

which can then be used:

```swift
let personName = Lens<Person, String>(
    get: { $0.name },
    set: { (newName, person) in
        Person(name: newName,
               address: person.address)
    }
)

let theRealKing = personName.set("The Burger King", person)
```

So an instance of the Lens struct is created using the Person and the `Whole` and `String` as the `Part`. The `get` property simply returns the name of the person (so we do not return the address of the person in this case). The set property is a closure that takes a `newName` and a `Person` object and creates a brand-new Person object with the new name.

now the realKing has the name `The Burger King` with the same address as before.

The getter of the lens above returns a specific part of it, while the setter changes a value and returns a new object (a whole) that contains the new modified value. There is no need to mess around with immutable objects here!

# An alternative
Now some might prefer the Lens to look something like the following:

```swift
struct Lens<A, B> {
    let from: (A) -> B
    let to: (B, A) -> A
}
```

this is since there are Generic parameters that can be named as (well) anything. Note that also the lens here is using to and from, which is something else that might be used in your place of work or suit your style.

# Advantages of Lenses
Lenses allow you to abstract behind Getters and Setters. Rather than using rather deep (and long lines!) to integrate one or more properties you can import a lens - and if need to change the object you can do so in the lens decoupling these functions from the main code.
In essence a small change in the requirement would result in a small change in the code (known as an OOP principle).

Although there is some extra code, we can consider the lens itself to be library code (write once, test and forget) so there aren't too many issues with it.

Also did I mention that Lenses are composable? Indeed they are, and this helps us to enjoy further complexity in our code.

# Disadvantages of Lenses
Lenses mean that you are adding more code into your Swift project, and this of course can obfuscation your meaning and make your work harder to understand and maintain.

# Conclusion

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
