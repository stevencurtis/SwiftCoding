# Idempotence: What is it, and why should you care?
## Just do it once

I've already mentioned Idempotence in my [HTTP Methods article](https://stevenpcurtis.medium.com/http-methods-for-restful-services-50f4c41c383f)

# Idempotence: A changeable definition
I've [previously](https://stevenpcurtis.medium.com/http-methods-for-restful-services-50f4c41c383f) defined Idempotent as "An operation that produces the same results if executed multiple times"

In [imperative](https://medium.com/macoclock/imperative-vs-declarative-programming-swift-fa538e01a7ba) programming, an idempotent function will produce the same state with one or many calls
In functional programming, a pure function is idempotent [so you might be better off looking at the pure function article]()

#  A basic example
[Sets in Swift](https://medium.com/@stevenpcurtis.sc/sets-in-swift-94cea4dd7c9f) have the property that the same item cannot appear twice within the set. This means that the following:

```swift
var set: Set<Int> = []
set.insert(1) // actually inserts 1
set.insert(1) // does not actually insert
```

leaves us with a set - containing just the Integer 1. Once we have run `set.insert(1)` we are guarenteeing that the Integer 1 appears in the resultant set  - no matter how many times (more than 0, that is 1 or more) we run the function.

If an operation is idempotent then it can be run multiple times without any potential problem happening. 

#  A basic theoretical example
Not precisely theoretically perfect, but there you go. You can multiply something by 1 (that is 7 * 1, or any Integer in place of 7) as many times as you like and there is no extra effect or side-effect to doing so - you'll end up with the same result each time.

#  Why it might be important: 1 - databases
If you are appending a field to a database you don't want multiple records. An Idempotence  operation ensures that no disasters will happen.

# Why it might be important: 2 - network calls
A `PUT` method should be Idempotence so if there are multiple calls no damage is done, much like the example of (1).

# An example for your mother
If you ignore the fact that some are Placebo buttons, some pedestrian crossings have buttons and it does not matter how many times you press them - the same result will happen (so long as you press the button at least once).

Have fun on the crossing, man.

# Conclusion

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis). It doesn't matter how many times you do so, the result will be the same.
