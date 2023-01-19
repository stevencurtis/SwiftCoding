# The Visitor Design Pattern in Swift
## Add new behaviour


![Photo by Christian Buehner](Images/photo-1568602471122-7832951cc4c5.jpeg)<br/>
<sub>Photo by Christian Buehner<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.5, and Swift 5.2.4

This is a rather uncommon design pattern, but is one worth studying in any case. The idea here is to separate out the algorithm from the objects that that algorithm operates on,

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

# Terminology:
Design Pattern: a general, reusable solution to a commonly occurring problem

# The Visitor Design Pattern in Swift: The issue
Take the following example:

```swift
protocol Animal {
    func makeSound()
}
class Dog: Animal {
    func makeSound() {
        print ("Woof")
    }
}
class Cat: Animal {
    func makeSound() {
        print ("Meow")
    }
}
```

Now if we wish to add a new operation to our animals (something like a `func move()`) we must modify the interface to every single class in the hierarchy: the result could be something like the following

```swift
protocol Animal {
    func makeSound()
    func move()
}
class Dog: Animal {
    func makeSound() {
        print ("Woof")
    }
    func move() {
    	print ("Run")
    }
}
class Cat: Animal {
    func makeSound() {
        print ("Meow")
    }
	func move() {
    	print ("Jump")
    }
}
```

of course I've not implemented move, but still - you should get the idea of this.

# The Visitor Design Pattern in Swift: The solution
Take the following example:
```swift
protocol Animal {
    func accept(_ visitor: Visitor)
}

// concrete component A
class Dog: Animal {
    func accept(_ visitor: Visitor) {
        visitor.hereIsADog(d: self)
    }
}

// concrete component B
class Cat: Animal {
    func accept(_ visitor: Visitor) {
        visitor.hereIsACat(c: self)
    }
}


// abstract Visitor class (Operation)
protocol Visitor {
    func hereIsADog(d: Dog)
    func hereIsACat(c: Cat)
}

class Sound: Visitor {
    func hereIsADog(d: Dog) {
        print ("Woof")
    }
    
    func hereIsACat(c: Cat) {
        print ("Miow")
    }
}

let animals: [Animal] = [Cat()]

let visitor1 = Sound()

let _ = animals.map{ animal in
    let theSound = Sound()
    animal.accept(theSound)
}
```

Which gives the result (as there is just a cat in the example) of 

```swift
Miow
```

Now to implement something like Move we can create a new class called `Move`

```swift
class Move: Visitor {
    func hereIsADog(d: Dog) {
        print ("Run")

    }

    func hereIsACat(c: Cat) {
        print ("Jump")
    }
}
```

which would then require us to create map the movement in a similar style to the above:

```swift
let _ = animals.map{ animal in
    let theMovement = Move()
    animal.accept(theMovement)
}
```

Giving the result as

```swift
Miow
Jump
```

# Conclusion
There are other advantages, in that you can have collections of mismanaged objects and can perform operations on them. 

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
