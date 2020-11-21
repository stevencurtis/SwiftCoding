# Property Observers in Swift
## Seeing changes

![photo-1601758003839-512c0f4159e5](Images/photo-1601758003839-512c0f4159e5.png)
<sub>Images by Chewy Pets Bringing us Together<sub>
# Before we start
Difficulty: **Beginner** | Easy | Normal | Challenging<br>
This article has been developed using Xcode 12.2, and Swift 5.3

## Prerequisites
* You will be expected to be aware how to either make a [Single View Application in Swift](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) or use a [Playground](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)

## Keywords and Terminology
Property Observers: Change and respond to changes in a property value. In Swift this is through didSet and willSet.

# This article
## Background
I've previously written an article about [properties in Swift](https://stevenpcurtis.medium.com/properties-in-swift-47a8868c2297), which covers **stored**, **computed** and **lazy** properties.

This article on the other hand covers Property Observers, and it is about time that I did just that.

## The Repo
I've prepared a [Repo](https://github.com/stevencurtis/SwiftCoding/tree/master/SwiftUI/PublishedPropertyWrapper) that can help you see the code that is avaliable in this article. I've created a guide on how to [download the repo from GitHub](https://medium.com/@stevenpcurtis.sc/downloading-repos-from-github-13a017951450) and I think that should assist some out there!

## What is a Property Observer anyway?
Property observers observe and respond to changes in a property's value. This can happen just before a value is changed with `willSet`, or immediately after a value is set with `didSet`. These property observers work on both `class` and `struct` instances ([no matter which you choose](https://medium.com/@stevenpcurtis.sc/classes-enums-or-structures-how-to-choose-your-swift-type-f33b4b76230e)).

## The use of Property Observers
If you are expecting a value to change, one might take the approach of requesting the current state of the value. 

This would involve (perhaps) the use of a timer and perhaps a [closure](https://medium.com/swift-coding/swift-closures-c14cb7aa2170), and this is not a good approach for a well-coded App. 

Much better would to be observe when changes are made, and then react accordingly. In steps Property Observers.

## An example
Imagine a game where we can score with a friend. Both Player 1 and Player 2 have a score and we want to log it with a program. This program 

```swift
import UIKit

class Game {
    var playerOneScore: Int = 0 {
        willSet(score) {
            print ("Player one's score will be \(score)")
        }
        
        didSet(oldScore) {
            print ("Player one's score was \(oldScore)")
            print ("Player one's score is now \(playerOneScore)")
        }
    }
    
    var playerTwoScore: Int = 0 {
        willSet(score) {
            print ("Player two's score will be \(score)")
        }
        
        didSet(oldScore) {
            print ("Player two's score was \(oldScore)")
            print ("Player two's score is now \(playerTwoScore)")
        }
    }
}
```

This is then kicked off with an instance of the `Game` class, and playerOne won the first game! This means that we will set the score to be 1, and then print out the score. We will do that by using the following three lines:

```swift
let initialGame = Game()
initialGame.playerOneScore = 1
print (initialGame.playerOneScore)
```

The answer
```swift
Player one's score will be 1 // printed by playerOneScore willSet
Player one's score was 0 // printed by playerOneScore didSet
Player one's score is now 1 // printed by playerOneScore didSet
1 // printed by the line print (initialGame.playerOneScore)
```

## What if the property is changed to the same value?
The value of the property has been changed - even though it is to the same value. This means that both `willSet` and `didSet` are called when the property is changed.

Let us write out this line:
```swift
initialGame.playerOneScore = 1
```

So we have three lines that are then written to the console

```swift
Player one's score will be 1 // printed by playerOneScore willSet
Player one's score was 1 // printed by playerOneScore didSet
Player one's score is now 1 // printed by playerOneScore didSet
```

# Conclusion
I hope this article has been of help to you. I certainly use property observers all the time within my own code, and they are a brilliant tool for you to have avaliable in your quest to solve coding problems. 

The [Repo](https://github.com/stevencurtis/SwiftCoding/tree/master/SwiftUI/PublishedPropertyWrapper) makes things rather easier to follow in this project, and I do recommend you download this project.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 