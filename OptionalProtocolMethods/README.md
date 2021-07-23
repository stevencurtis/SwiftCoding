# Implementing Optional Protocol Methods in Swift
## We might not always want to implement them!

Difficulty: Beginner | Easy | **Normal**| Challenging
This article has been developed using Xcode 11.5, and Swift 5.2.4

## Keywords and Terminology
Protocol: A blueprint on methods, properties and requirements to suit a piece of functionality

# The problem
Protocols are great in Swift! Absolutely fantastic!

However you may want to use a protocol which has *optional* requirements - when you conform to a protocol only **some** of the functionality is required. 

This would be great, as you should probably make more use of protocols than you currently are as they are a great way of providing an interface to your code.

Wait. *What*?

# The Introduction
## The Interface Segregation Principe (ISP)
If you aren't that familiar with the [SOILD](https://stevenpcurtis.medium.com/the-solid-principle-applied-to-swift-974e29b94d23) principles you might want to investigate that whole article.

But, for this particular article, I'm happy with saying that using small `protocols` means that code clients only depend on the interfaces that they use. By using these interfaces you can abstract complex code behind a simple(r) interface  which also allows you to prove loose coup;ing between code.

![Images/interface.png](Images/interface.png)

Yeah, looking at the article might make this a little bit easier.

## Protocols
So a `protocol` in Swift acts as an interface for your code. When coding in Swift, we conform to `protocols`. In our code we can make `struct`, `enum` and `classes` conform to the requirements specified within the protocol.

Protocols are flexible, I've previously written about [type erasure](https://github.com/stevencurtis/SwiftCoding/tree/master/MVVMDependencyInjection) because we can leverage the power of generics in our protocol code. Now that is nice, indeed!

# The Solution(s) - with advantages and disadvantages
The theory above has been included so we have some hook in order to explain the advantages and disadvantages, and think about the cases we might encounter as developers during our coding journeys.

## Optional Protocol Methods

**The Advantages and Disadvantages**
There isn't anything special about these protocols. We can still use generics and we won't get a nasty crash in any case - we will always either use the default implementation or specific concrete implementation of our methods. No worries, no problems.

However, we may struggle to think about creating sensible default implementations, it suddenly becomes like mocking and we may see this as a new rather large task that takes our focus away from other coding tasks - but in this case you are not able to distinguish between a default implementation and a concrete implementation at runtime.

## Leverage the Objective-C runtime interface

**The Advantages and Disadvantages**
This is rather more a solution I expected when I wanted an optional implementation of a protocol method. What I didn't necessarily expect is how ugly it is! However, using the `@objc` attribute allows us to interact with the Objective-C runtime means that only classes that inherit from `NSObject` can conform to the protocol (that is, not `struct` or `enum` types).

# The artificial example
## Not optional: The router
Generally we produce a protocol that `class` or `struct` may conform to. What if we wanted to have a protocol that marked ViewControllers as to where they can route the user to?

We might come up with the following solution:

```swift
protocol Route {
    func moveToHomeScreen()
    func moveToSettings()
}

class IntroViewController: Route {
    func moveToHomeScreen() {
        // implementation
    }
    
    func moveToSettings() {
        // implementation
    }
}

class HomeViewController: Route {
    // not required in this case
    func moveToHomeScreen() {
        // implementation
    }
    
    func moveToSettings() {
        // implementation
    }
}
```

The issue with this is that `HomeViewController` would need to route to itself, which would be pretty poor. 

We are thinking of having optional requirements for our protocol in this case. 

## Default implementation: The router
We can set up default implementations in an extension for our `protocol` (in this case, `Route`)
```swift
protocol Route {
    func moveToHomeScreen()
    func moveToSettings()
}

extension Route {
    func moveToHomeScreen() {
        // implementation
    }
}

class IntroViewController: Route {
    func moveToHomeScreen() {
        // implementation
    }
    
    func moveToSettings() {
        // implementation
    }
}

class HomeViewController: Route {
    func moveToSettings() {
        // implementation
    }
}
```

## @objc implementation: The router
We can expose the protocol to objective c, and then enable our protocol methods to be optional. Wouldn't that be nice?

```swift
@objc protocol Route {
    @objc optional func moveToHomeScreen()
    func moveToSettings()
}

class IntroViewController: Route {
    func moveToHomeScreen() {
        // implementation
    }
    
    func moveToSettings() {
        // implementation
    }
}

class HomeViewController: Route {
    func moveToSettings() {
        // implementation
    }
}
```

## The better solution: The router
Why can't we use a protocol for each type of route? Ok, we can!

The advantage here is that we only implement the methods that we need to - we are not taking on extra implementation burden which is not required.

```swift
protocol HomeRoute {
    func moveToHomeScreen()
}

protocol SettingsRoute {
    func moveToSettings()
}

class IntroViewController: HomeRoute, SettingsRoute {
    func moveToHomeScreen() {
        // implementation
    }
    
    func moveToSettings() {
        // implementation
    }
}

class HomeViewController: SettingsRoute {
    func moveToSettings() {
        // implementation
    }
}
```

# But aren't we doing it wrong?
An optional requirement is an oxymoron, it just doesn't make any sense. You'd be so much better off breaking your interface into several protocol abstractions. Is this always the case? No, of course not. It is your decision what you would do as the developer in order to solve the problem that you are attempting to solve.

# Conclusion
Yeah. You may well be better off separating your protocol into a set of protocols, so we use the minimum interface when solving any particular problem. 

You (and this is actually me, I'm thinking of a problem right now!), really should be doing that. So let's go and do that. Bye!


If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
