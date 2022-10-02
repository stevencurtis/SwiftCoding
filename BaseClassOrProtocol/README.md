# Use a Base Class or a Protocol?
## One of those old questions

Difficulty: **Beginner** | Easy | Normal | Challenging<br/>
This article has been developed using Xcode 12.5, and Swift 5.4

# Prerequisites:
* You will be expected to be aware how of how make a [Single View Application in Swift](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)

# Terminology
Base Class: A class, in an object-oriented programming language, from which other classes are derived
Protocol: A blueprint on methods, properties and requirements to suit a piece of functionality
Value types: Where a value is stored as the actual value of the item
Class: An object that defines properties and methods in common
Reference type: A pointer to a variable or object

# The Project
You are designing an Instagram - like social media Application. The user is able to post audio, video or text messages to their timeline.

## The Base Class implementation
As part of this project, we have friends that are represented by the following User class:

```swift
class User {
    let id: String
    init(id: String) {
        self.id = id
    }
}
```

depending on the type of friends we have

```swift
class Family {
    let name: String
    init(name: String) {
        self.name = name
    }
}
```

Who we can create posts to contact and become better friends. 

So one way of tackling the posts is to create a `Post` base class, and subclasses for Image, Text and Video which are each subclass of `Post`:

```swift
class Post {
    let userID: String
    init(userID: String) {
        self.userID = userID
    }
}

class Image: Post {
    let photo: String
    init(userID: String, photo: String) {
        self.photo = photo
        super.init(userID: userID)
    }
}

class Text: Post {
    let text: String
    init(userID: String, text: String) {
        self.text = text
        super.init(userID: userID)
    }
}

class Video: Post {
    let video: String
    init(userID: String, video: String) {
        self.video = video
        super.init(userID: userID)
    }
}
```

Each of these posts are displayed in a `UICollectionView` (or similar).

**The change**
Now if the specification changes, and we wish to be able to post Users as part of their timeline. 

Your friends would potentially be a subclass of `User`, rather than `Post`.

This is going to be much pain-me-do and involve much refactoring. The reason for this?

The following is NOT allowed by the compiler

```swift
class Family: User, Post {
    let name: String
    init(name: String) {
        self.name = name
    }
}
```

In Swift, Multiple inheritance from classes isn't allowed! Yes, this might be a standard feature in languages like C++, but here Swift has another solution for us.

`protocol`

Much better than that, value types like `struct` can also conform to protocols (subclassing unfortunately is restricted to classes, the clue is in the name in this case!). 

## The Protocol implementation
We can decide to implement a protocol for our posts, which adds methods and properties to add the behaviour that a `Post` would require.

```swift
protocol PostProtocol {
    var userID: String { get }
}
```

Which then our posts can conform to 

```swift
class Post: PostProtocol {
    let userID: String
    init(userID: String) {
        self.userID = userID
    }
}
```

which means when we have the change described above, we make `Family` conform to `PostProtocol`

```swift
class Family: PostProtocol {
    var userID: String
    let name: String
    init(name: String, userID: String) {
        self.name = name
        self.userID = userID
    }
}
```

## The Explanation
When we define a protocol we can define the behaviour that conforming objects have to have, and this prevents us from having to adopt unnecessary behaviour that having a base class may well indicate.

## So which should we use?
It really depends on your situation. Look at the examples and think about which is better for the particular problem we are going to solve. Which is usually protocol in Swift.

# Conclusion
This article is meant to help out with the differences between protocol and base class implementations.

It has given examples of both, and this should help Swift programmers who have been a little confused about these concepts.

I hope that this helps everyone reading in any case!

Thanks!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
