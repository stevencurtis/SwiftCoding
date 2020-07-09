# Don't return - NEVER in Swift
## Not nil, not null

![Photo by bruce mars on Unsplash](0*ph-oIDgES2ougV7U.jpeg)<br/>
<sub>Photo by bruce mars on Unsplash<sub>

Photo by David Besh on Unsplash

# Prerequisites:
You will need to be familar with the basics of [Swift and able to start a Playground (or similar)](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)

# Terminology:
Never: a return type for a function (or closure, or method) that will never terminate

## The source of this article
I began looking at **Combine** after a voiding it for some time. Hidden in one of WWDC19's videos is the following code snippet for **Subscribers** 

```swift
extension Subscribers {
    class Assign<Root, Input>: Subscriber, Cancellable {
        typealias Failure = Never
        init(object: Root, keyPath: ReferenceWritableKeyPath<Root, Input>)
    }
}
```

Where we are told 
'Because in Swift there is no way to handle an error when you are just writing a property value, we set the failure type of assign to Never'

Wait, what are you talking about?

## The documentation
Apple's [documentation](https://developer.apple.com/documentation/swift/never) to the rescue (sort of).

They describe `Never` as a return type for a function (or closure, or method) that will never terminate.

They give the following example:

```swift
func crashAndBurn() -> Never {
    fatalError("Something very, very bad happened")
}
```
but wait a second: what happens if we return void, () or nothing at all. That is

```swift
func crashAndBurn() {
    fatalError("Something very, very bad happened")
}
```

Now the more experience of you will already know what happens. It compiles just fine. 
They run exactly the same way. So why, wait what are you talking about?

## Why `Never`?
`Never` is useful because we can ignore certain requirements. When the speaker spoke of assigning a failure type to `Never` we need to understand
* Never is a type
* We are able to return a type, without returning a type - we have to specify a return type but we won't be returning anything

So let us look at that second difficult to read bullet point once again, and tying this back into the meaning of that WWDC talk.

Bascially we need to return a `Failure` because the `Subscriber` requires that we specify a `Failure` `typealias` - and as he mentions it is going to be impossible to in actual fact ever fail.

In this case we have a great use of `Never` - from a WWDC video that isn't even the topic!

Great

# Conclusion
You don't need to be confused any longer. `Never` is there to help you (never) - if you want to return something but don't need to return anything.

Is that useful? Sure is, as it means you don't need to create any weird phantom types that you don't need in your project - Swift has done this work for you already!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)
