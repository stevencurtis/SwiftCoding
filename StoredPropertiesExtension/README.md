# Stored Properties in Swift Extensions
## Are you sure that you need them?

![photo-1473957678922-1cff9a047932](Images/photo-1473957678922-1cff9a047932.jpeg)
<sub>Image by Joshua Peacock</sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12, and Swift 5.3

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* The ObjectAssociation class uses [generics](https://medium.com/better-programming/generics-in-swift-aa111f1c549) 

## Terminology
Extensions: Extensions add new functionality to a class, struct, enum or protocol
Property: An association of a value with a class, structure or enumeration
UIViewController: A view controller is an intermediary between the views it manages and the data of your app

Some time ago I wrote [an article about locking the view while loading](https://medium.com/swlh/locking-the-view-during-loading-f4554a9912a9) and deep within this I used an `ObjectAssociation` class in order to store a `UIActivityIndicatorView` as a property in an extension.

Now it never sat well with me that I didn't explain the use of this `ObjectAssociation `class, and now the time has come to put that right. Not only that, now there is "**better**" way.

So let us dive right in!

## What is this about?
In the order to [lock a view while loading](https://medium.com/swlh/locking-the-view-during-loading-f4554a9912a9) I needed to be able to access a `UIActivityIndicator` from any view, and decided to do this by creating an extension onto a `UIViewController` so it could be accessed from any view controller. 

Now Swift extensions are limited in the same way that `Objective-C` categories are, in that you simply can't add a property to a class through an extension. In the same way as `assocated objects` could be used in `Objective-C`, we can still add a computed property with `objc_getAssociatedObject` which returns the value associated with a given object for a given key, essentially allowing the use of a backing store in an extension!

## The ObjectAssociation class
The `ObjectAssociation` class in itself does use [Generics](https://medium.com/better-programming/generics-in-swift-aa111f1c549) but essentially we are using `objc_getAssociatedObject` to allow a kind of backing store to be used.

```swift
public final class ObjectAssociation<T: AnyObject> {
    private let policy: objc_AssociationPolicy
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        self.policy = policy
    }

    public subscript(index: AnyObject) -> T? {
        get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}
```

https://gist.github.com/stevencurtis/6cc695c13914b4ea33bf1ce3f11320d6

Of course this does not allow us to automatically use the class: you need to, well use the class!

For this implementation I've added my own index for a `UIButton` in an extension.

Therefore we can set the Index, and read it out with a print.

```swift
butt.index = 3
print (butt.index)
```

Which of course only works with the `ObjectAssociation` class above

```swift
class ButtonData {
    var index: Int = 0
    init(index: Int) {
        self.index = index
    }
}

extension UIButton {
    private static let association = ObjectAssociation<ButtonData>()
    var index: Int {
        set { UIButton.association[self] = ButtonData(index: newValue) }
        get {
            return UIButton.association[self]!.index
        }
    }
}
```

## A nicer solution using a static var within a struct
If you're using Swift 4 or later (an it isn't 2017 anymore, so you probably should be) you can use this rather nicer solution. 

For this example I can add a UILabel with the same index idea.

```swift 
extension UILabel {
    private struct Data {
        static var _index: Int = 0
    }
    
    var index: Int {
        get {
            return Data._index
        }
        set {
            Data._index = newValue
        }
    }
}
```

However there are issues with this, if you create multiple `UILabels` (and, in this particular example creating multiple controls is extemely likely) they will all have the same index. This is *potentially a disaster*.

## The solution
We create a `StoredProperty` class that uses `unsafeBitCast` (that is the bits of a particular instance) and use a [dictionary](https://medium.com/@stevenpcurtis.sc/dictionary-in-swift-52b14d6cfa93)

```swift
public class StoredProperty<T: Any> {
    private var propertyDictionary = [String:T]()
   
    func get(_ key: AnyObject) -> T? {
        return propertyDictionary["\(unsafeBitCast(key, to: Int.self))"] ?? nil
    }
   
    func set(_ key: AnyObject, value: T) {
        propertyDictionary["\(unsafeBitCast(key, to: Int.self))"] = value
    }
}
```

Which then I'm using in an extension for `UITextView` with the following code:

```swift
extension UITextView {
    private static var _index = StoredProperty<Int>()
    
    var index: Int {
        get {
            return UITextView._index.get(self) ?? 0
        }
        set {
            UITextView._index.set(self, value: newValue)
        }
    }
}
```

So when we create multiple instances they don't have the same index. 

```swift
        let textView = UITextView()
        textView.index = 2
        print (textView.index)
        
        let secondText = UITextView()
        print (secondText.index)
```

That's awesome!

## A quick word
Are you using properties inside extensions to solve a real problem? Because we are in the hands of the Swift team at Apple, and they have decided to **not** implement properites in extensions - why are we holding data in an extension in the first place? Why would you want to do this? You would need to have a good answer to this question, particularly if you are thinking of implementing something like this in production code.

Second, this isn't a thread-safe solution (because we are reading and writing to the backing property potentially at the same time). This could be solved by using a similar strategy to the one detailed in [thread-safe arrays](https://medium.com/@stevenpcurtis.sc/swift-thread-safe-arrays-ed1541301eb3), but that is beyond the scope of this article.  

# Conclusion
As ever, giving programmers tools to solve problems can't be a bad thing. However, we really need to think about *why* we might be adding stored properties into our Extensions in Swift.

This is another tool to put into that toolbox, and the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/StoredProperties) gives you a view into the code in-situ!

I really hope this helps you on your coding journey!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 