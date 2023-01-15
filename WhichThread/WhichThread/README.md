# Which Thread Are You Using in Swift? 
## You surely should know!

Yeah, after [writing about that threads](https://stevenpcurtis.medium.com/swift-views-shouldnt-know-about-threads-3de632cccd47) should be handled by the view model in MVVM and writing about [GDC in Swift](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2) I've still got one question.

**How do you know which thread you're using in your Swift  code.*

There's a simple extension for that. I've written such a thing.

## The extension

For once I don't think that it is necessary to provide you with the code for this (although it is right in the [repo](https://github.com/stevencurtis/SwiftCoding).

Effectively we can return the `OperationQueue`, `DispatchQueue` or current thread. 

I'm returning the result to the console, of course you could do anything you wanted with the resultant String
```swift
extension Thread {
    var threadName: String {
        if let currentOperationQueue = OperationQueue.current?.name {
            return "OperationQueue: \(currentOperationQueue)"
        } else if let underlyingDispatchQueue = OperationQueue.current?.underlyingQueue?.label {
            return "DispatchQueue: \(underlyingDispatchQueue)"
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
}
```

I then decided to use this particular extension in a simple `UIViewController` because why not.

I'll even give the whole extension right here:

```swift
final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Thread().threadName)
        DispatchQueue.global(qos: .background).async {
            print(Thread().threadName)
        }
    }
}
```

# Conclusion
I hope this article is interesting, I love you and enjoy coding.

Let me know what you think, and whether this code sample has been of help to you in any way,

I hope this article has been of help to you.

Happy coding!

If you've any questions, comments, or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
