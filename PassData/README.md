# Pass Data in iOS Apps
## Notifications vs Delegates vs Closures vs Key-Value Observation

![Photo by Peter Jan Rijpkema on Unsplash](Images/photo-1534530236704-33735c0dd55b.jpeg)<br/>
<sub>Photo by Peter Jan Rijpkema on Unsplash<sub>

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift, or be able to code in [Swift Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)

## Terminology:
Closures: A combination of functions and references to the surrounding context
Delegation: A pattern that enables a class to delegate responsibility for some actions to an instance of another class
NotificationCenter: A notification dispatch mechanism that enables the broadcast of information to registered observers
KVO: (Key-Value Observing), is one of the techniques for observing the program state changes available in Objective-C and Swift

# Delegation
I've previously written an article on [delegation](https://medium.com/@stevenpcurtis.sc/delegation-in-swift-6b416bc0277c) which shows that delegates are a great way of passing information between two loosely-coupled objects. 

Pros
- All objects conforming to the protocol must implement those methods
- Easy to understand the program flow
- You can have multiple protocols defined by a single object, each with different delegates
- Values can be passed from the view controller using a suitable protocol method
- Delegate needs to be connected as "weak" to make sure that there isn't a memory leak

Cons
- Lots of boilerplate code!
- Tricky to have multiple delegates on the same protocol on the same object
- If you have multiple delegates for the same object how do you know which one is calling?

# NotificationCenter
Pros
- Easy to implement, with a few lines of code
-  Easy to have multiple objects react to a notification
- A Dictionary can be used to pass data
- If you don't implement the whole protocol you get a rather nice warning 

Cons
- Using a dictionary to pass data is less than ideal from a type-safety point of view
- Can be very difficult to follow the program flow
- The same keys need to be used by both the observer and the listener - and these are often implemented as...Strings(!)
- Any programmer can set up a notification from anywhere in the App - i.e. Juniors can destroy a whole app

For more detail look at [this article](https://github.com/stevencurtis/SwiftCoding/tree/master/KVOvsNotificationCenter)


#Key-Value Observation (KVO)
Pros
- Allows us to respond to state changes in code that we haven't written
- Can provide us with the new value and previous value of the property we are observing
- Can use key paths to observe properties, and therefore nested objects can be observed
- Abstraction of the object being observed

Cons
- The syntax is rather horrible using keypaths
-- The same keys for the keypaths are implemented as Strings (no type-checking)
- KVO is very slow
- You need to inherit from `NSObject`

For more detail look at [this article](https://github.com/stevencurtis/SwiftCoding/tree/master/KVOvsNotificationCenter)

# Closures
Pros
- Multiple closures for one object makes it very clear which callback is being called at any particular time
- Simple to use, simple to understand

Cons
- Memory leaks! You need to make sure you've chosen weak or string links as appropriate
- You don't know that you haven't completed a full contact for a situation where you have many clusres - no warning like for delegation

[Closures](https://medium.com/swift-coding/swift-closures-c14cb7aa2170) can be used to pass information between two objects in a 1-to-1 relationship.


# When to use what
If every view controller needs to know something, use notifications.
KVO is often used for property-level events used in UIKit (i.e. where you didn't write them)
Delegation can be used for communication between a view controller and it's model.

Here are some situations, and a suggestion of what solution to use.

**Situation 1**
If something requires one function as it's interface, a callback is usually a good solution. This closure can be optional or non-optional.

**Situation 2**
More than one function is required, especially when they're required for the basic function of an object, a Delegate is probably a better solution

**Situation 3**
Delegate to multiple instances we can use delegation or KVO. Depends on the speed and syntax that you require.

**Situation 4**
The delegate is a datasource. Use a protocol, it enforces a stronger contract between the two types, and the compiler can help you find bugs.

**Situation 5**
Many parts to a pubic interface.
Use a protocol. If you forget to implement new methods in the future, the compiler will tell you rather than your users. A protocol ensures that you fulfil the contract.

# Conclusion
I hope this article has been of help, and maybe I'll see you next time?

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
