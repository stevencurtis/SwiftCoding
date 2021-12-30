# KVO vs Notification Center
## One-to-Many or One-to-One

![Photo by Mario Gogh on Unsplash](Images/photo-1541746972996-4e0b0f43e02a.jpeg)<br/>
<sub>Photo by Mario Gogh on Unsplash<sub>

I've previously covered the [Observer Pattern](https://medium.com/swift-coding/the-observer-pattern-in-swift-97a0e6fafa58) in Swift, but there seems to be two implementations in the iOS SDK - 
* NotificationCenter
* KVO
So which is what, and what might be the best approach for your application?

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift, or be able to code in [Swift Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089).

## Terminology:
NotificationCenter: A notification dispatch mechanism that enables the broadcast of information to registered observers
Dynamic property: An interface for a stored variable that updates an external property of a view

# NotificationCenter
Notification Center enables the broadcast of information to any registered observers. This means that a single event can broadcast to many observers - a one-to-many relationship. 

A classic example of this may be using dynamic type: when the user changes their preferred font size, you would want to be informed of this change. To do so in `viewDidLoad()` we can register for changes in the preferredContentSizeChanged:

```swift
NotificationCenter.default.addObserver(self, selector: #selector(preferredContentSizeChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
```

which then hooks up to the following:
```swift
@objc func preferredContentSizeChanged(_ notification: Notification) {
    dynamicTextLabelObserver.font = UIFont.preferredFont(forTextStyle: .headline)
}
```
where if we have set up a `UILabel` with the name `dynamicTextLabelObserver` we can expect the font to nicely change.

This sounds so nice. But if we want to communicate information through our App we might want to add our own "post" (that is, post a notification). `NSNotificationCenter` has us covered!

We will need to add the observer to listen to any events

```swift
NotificationCenter.default.addObserver(self, selector: #selector( notificationReceived(withNotification:) ), name: NSNotification.Name(rawValue: "NamedataModelDidUpdateNotification"), object: nil)
``` 

I've then set up a function that sends a notification when you press a button 

```swift
@IBAction func sendNotification(_ sender: UIButton) {
    let dict = ["sent": "data"]
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NamedataModelDidUpdateNotification"), object: self, userInfo: dict)
}
```

which will then, well, just print to the console when the notification is received:

```swift
@objc func notificationReceived (withNotification notification: NSNotification) {
    if let prog = notification.userInfo?["sent"] as? String {
        print (prog)
    }
}
```

Removing the observer is no longer necessary, take a look at the documentation:

```swift
If your app targets iOS 9.0 and later or macOS 10.11 and later, and you used addObserver(_:selector:name:object:) to create your observer, you do not need to unregister the observer. If you forget or are unable to remove the observer, the system cleans up the next time it would have posted to it.
```

Phew! That code is rather horribly split up: you might need to look at the accompanying [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/KVOvsNotificationCenter)

# KVO
This is a possible approach in order to bind a viewModel:

It only works on classes that inherit from `NSObject` - and the property that you observe should be marked as `dynamic`, which tells `Swift` to always refer to Objective-C dynamic dispatch (that is to process this at runtime), and changes how Swift interacts with Objective-C.

So we can have a `ViewModel` that updates a property marked as `dynamic`, and of course inherits from `NSObject` as follows:

```swift
class ViewModel: NSObject {
    @objc dynamic var myDate = NSDate(timeIntervalSince1970: 0)
    func updateDate() {
        myDate = NSDate()
    }
}
```

this can then be accessed from your `ViewController`:

```swift
@objc var objectToObserve: ViewModel?
var observation: NSKeyValueObservation?

let observed = ViewModel()
objectToObserve = observed

observation = observe(
    \.objectToObserve!.myDate,
    options: [.old, .new]
) { object, change in
    print("myDate changed from: \(change.oldValue!), updated to: \(change.newValue!)")
}

observed.updateDate()
```
Of course we are only calling `observed.updateDate()` to update the date, and we are using a [KeyPath](https://medium.com/@stevenpcurtis.sc/what-are-swifts-keypaths-e8c829bc97d3) in order to observe the attractively-named `objectToObserve`.

To stop observing you can call `invalidate`, but of course Apple have us covered from iOS11 onwards and once we go out of scope this is fine without the explicit call.
If you wish to stop observing - you can simply do the following:

```swift
observation?.invalidate()
```

# NotificationCenter vs. KVO
NotificationCenter broadcasts to many observers, out of the box (awesome), and represents loose coupling of your objects. Since NotificationCenter is a singleton we don't need to worry about dependency injection, and can just create a mock of the singleton "from the outside".
People are sometimes down on the Singleton pattern, and unfortunately NotificationCenter relies quite heavily on this pattern (anti-pattern? I disagree but there we go). It is rather horrible to pass data with a dictionary (and type safety doesn't help us much here!), and it can be tricky for readers to follow the control flow of programs that utilise NotificationCenter. You can't even control who might send notifications around your App - which would create some obvious issues in larger organisations and Apps. 

You can only use key-value observing with classes that inherit from `NSObject`, but inheriting from `NSObject` isn't too tricky and allows us to (also) broadcast to many observers! However, people do hate the way Swift uses [KeyPaths](https://medium.com/@stevenpcurtis.sc/what-are-swifts-keypaths-e8c829bc97d3).
It's rather annoying that we have to deal with this syntax to use any particular 'KeyPath' - and worse than that `KVO` using this method is extremely slow!

# Conclusion
 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
