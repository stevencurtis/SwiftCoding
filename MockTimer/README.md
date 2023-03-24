# How I Would Mock A Swift Timer
## In Swift

# Before we start
Let's take a look.

Difficulty: Beginner | **Easy** | Normal | Challenging
This article has been developed using Xcode 14.2 and Swift 5.7.2

## Prerequisites:
You will be expected to be aware how to make a Single View Application in Swift
You might want to understand something about dependency injection before reading this article

# The Context
In terms of dependency injection, one thing that always got me thinking was how to deal with timers.
Sure, I'd create a protocol so I'd be able to swap out implementations and be able to suggest the surrounding code.

```swift
protocol TimerProtocol {
    func register(callback: @escaping () -> Void)
    func createScheduledTimer(withInterval interval: TimeInterval)
    func invalidate()
}
```

The timer itself? I wrote this one:

```swift
final class ExchangeTimer: TimerProtocol {
    private var callback: (() -> Void)?

    func invalidate() {
        timer?.invalidate()
    }

    private var timer: Timer?

    func createScheduledTimer(withInterval interval: TimeInterval) {
        timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(timerCallback),
            userInfo: nil,
            repeats: true)
    }

    func register(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    @objc func timerCallback() {
        callback?()
    }
}
```

Which all seems reasonable. But what to do with that TimerInterval parameter?

# In steps my mock
I'm not going to worry about the `TimerInterval` at all. I can expose a property (yeah, it's for testing so come at me!) on the mock which can then be updated from outside of the class.

We can also expose `invalidated` so we can check if the boolean is set. Oh, and register a call back from our tests to see if it's been called.

Something like this should do the trick!

```swift
class MockTimer: TimerProtocol {
    var callback: (() -> Void)?
    var invalidated: Bool = false
    var repeats = 5
    func createScheduledTimer(withInterval interval: TimeInterval) {
        for _ in 0..<repeats {
            if let callback = callback {
                callback()
            }
        }
    }

    func register(callback: @escaping () -> Void) {
        self.callback = callback
    }

    func createScheduledTimer() { }

    func invalidate() {
        invalidated = true
    }
}
```

And that's it!

# Conclusion

I hope that this article has been in some way useful to you. Any questions, please do get in touch.
Anyway, happy coding!
