# That One Method Dispatch Pitfall
## Can you avoid this?


Difficulty: Beginner | **Easy** | Normal | Challenging<br/>

Before tackling this article, you might want to look at my [Method Dispatch Article](https://stevenpcurtis.medium.com/method-dispatch-in-swift-protocols-and-inheritance-548743a6be1f)

# That tricky case
Any method defined inside a `protocol` is dynamically dispatched. This makes sense, since we do not know which method implementation will be used until runtime. 

Both `Mammal` and `Pig` are `Animal` (stop me if this is too tricky!). Each makes a noise, which differs if they are in pain. 

The code looks something like the following:

```swift
protocol Animal {
    func animalSound(pain: Bool) -> String
}

class Mammal: Animal {
    func animalSound(pain: Bool = false) -> String {
        return "Indeterminate grunt \(pain ? "ttttt" : "")"
    }
}

class Pig: Mammal {
    override func animalSound(pain: Bool = true) -> String {
        return "Oink \(pain ? "kkkk" : "")"
    }
}
```

Those default arguments? They give a curious side-effect.

```swift
let mammal = Mammal()
mammal.animalSound() // "Indeterminate grunt" [not in pain]
```

The mammal isn't in pain. That's a good thing. However, we have simply created a mammal class which itself has the function animalSound and since our mammal isn't in pain, it produces an indeterminate grunt (no "grunttttt" here!

Now let us look at the "confusing" case.

```swift
let jessie: Mammal = Pig()
```

Now jessie is a `Pig`. That's nice. But notice that we are treating them as a `Mammal` not a pig as we define the instance.

So what animal sound will jessie make?

Think about it for a minute (or two, I'll wait).

Let me give you a clue. If jessie is a pig, we'll see the following:

```swift
let jessie: Pig = Pig()
jessie.animalSound() // "Oink kkkk" [in pain]
```

jessie is in pain. This is expected because at runtime the `Pig` uses the method from, well `Pig`. That's it.

Now what happens if jessie is treated as a `Mammal` as in the question above they won't be in pain

```swift
let jessie: Mammal = Pig()
jessie.animalSound() // "Oink" [not in pain]
```

jessie is in pain. Did you get it? It's because we use the method of the `Mammal` and use that default value (false) but still dynamically dispatch the *implementation* of the Pig.

A pig is a `Mammal` but still sounds like a pig. That makes sense (right?), and we dynamically dispatch the **implementation** of the function rather than it's method definition.

Interesting, right?

# Conclusion
I hope this article is interesting, love you and enjoy coding.

Let me know what you think.

I hope this article has been of help to you.

Happy coding!

If you've any questions, comments, or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
