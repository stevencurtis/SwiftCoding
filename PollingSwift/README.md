# Implement Polling in Swift
## Must we poll?

This article relies upon perform(_:with:afterDelay:) which (looking at that documentation) invokes a method on the current thread. This is rather nice, since we often want to be on the main thread to perform background tasks. 
Wait though, why are we polling?

# Reasons for polling
You might want to poll and check that your endpoint is responding. You may have an old backend which performs in such a way that you are required to poll it (and there is nothing that you can do about that). 
However, polling is of course something which is rather up to the developer whether they will use it or not. There is nothing inherently wrong with polling, and perhaps this article will help out a user.

Of course, I've not used polling for the reasons detailed above.

So what have I used polling for in production? 
In on context I used at a previous gig we had an API endpoint. The reason for this was to give the ability of the UI to display the App status (so it could be shown if the application would be under maintenance). Essentially the endpoint formed part of the availability strategy of the business, and provided a (at least reasonable) user experience. It is worth considering whether it is worth improving the user experience through having maintenance downtime like this, or developing a strategy to avoid such downtime.

**Disadvantages of such a strategy**
While we are thinking about using polling for an API, we might want to think about the following
- Network traffic as there is clearly an implication for both the user and the endpoint
- If the polling is infrequent (perhaps to avoid creating too much network traffic) the API might not work as intended (there might be a lag due to infrequent posting)
- Polling can sometimes generate false positive alerts if the API endpoint experiences a temporary issue  or if the request is blocked by a network issue or firewall

# Implement Polling in Swift
As ever, this isn't the only way you might do something like this. However, I have set up a playground that works:

```swift
import Foundation
import PlaygroundSupport

class Poller {
    private var timer: Timer?
    private var stop: (() -> Bool)?
    func startPolling(stop: @escaping () -> Bool) {
        self.stop = stop
        timer = Timer.scheduledTimer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true
        )
        guard let timer = self.timer else { return }

        RunLoop.main.add(timer, forMode: RunLoop.Mode.default)
    }
    
    @objc private func fireTimer() {
        print("Make API call")
        if stop?() == true {
            timer?.invalidate()
        }
    }
    
    func stopPolling() {
        timer?.invalidate()
    }
}
let end = Date() + 6
let poller = Poller()
poller.startPolling() { Date() >= end }

PlaygroundPage.current.needsIndefiniteExecution = true
```

Yes, you probably should be injecting that timer and if you want more details about that please do [take a look at my article on that topic](https://medium.com/@stevenpcurtis/how-i-would-mock-a-swift-timer-8779e4a0ce06).
So would I use that code in production? Probably not.
However, it is fun to think about these things and take a look at how you might implement something.

# Conclusion
I hope that this article has been in some way useful to you. Any questions, please do get in touch.
