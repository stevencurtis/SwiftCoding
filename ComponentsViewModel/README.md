# Create Flexible Components in Swift
## These can Update with a ViewModel

You know what, I want to create components that are reusable. You know, wherever in your production App you use them you are going to use a `UIButton` subclass that has a few states, and is reliable.

But how am I going to *structure* the component before I get knee-deep in a particular implementation?

What if I create a `UILabel` as a great example.

You're reading the output of that investigation!

Difficulty: Beginner | Easy | Normal | **Challenging**<br>
This article has been developed using Xcode 12.5, and Swift 5.4

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* Familiarity with the following concepts are required: [typealias](https://medium.com/macoclock/type-alias-for-readability-in-swift-b5d60de4aee1), some [combine](https://stevenpcurtis.medium.com/core-concepts-of-combine-71d6b13d43e2), [extensions](https://stevenpcurtis.medium.com/extensions-in-swift-68cfb635688e), [intrinsicContentSize ](https://stevenpcurtis.medium.com/what-is-intrinsiccontentsize-anyway-c77f2bcd30d7), [getters and setters](https://stevenpcurtis.medium.com/public-getters-and-private-setters-in-swift-4f90d90bb05f), [clickable link](https://medium.com/swlh/clickable-link-on-a-swift-label-or-textview-98bbb067451d)

## Keywords and Terminology
Model: Where data, and logic that manipulates the data is stored. Perhaps model objects, or networking code is stored here.Think of this as the what of the App.

# The overall view
I'm going to have a Model for my `Label`, which will provide the information that my `Label` uses to display the, well in this case - text. Much like model objects in the application this provides the data that is required for the view to display. 

The view itself will be surfaced in the viewController (which is lucky since the viewController should control the view)

```swift
viewModel.$labelModel
    .withUnretained(label)
    .sink {_ in } receiveValue: { (label, model) in
        label.update(with: model)
    }
    .store(in: &subscriptions)
```

so we are surfacing both the label and the label model into the view controller (which will actually be in the viewDidLoad function in the ViewController), so we can use the previous ViewModel in a way that will allow us to update it without having to retain the viewmodel in the view controller - which will be nice!

Can we achieve this? Well, let us realise that I wouldn't have published this if I wasn't aware this was already gonig to work!

# The implementation
That model is going to be surfaced, along with the view in our view controller. 

The **model** is reproduced here, as well as in full below to help you out:

```swift
extension Label {
    public final class Model {
        public typealias View = Label
        
        public var text: String?

        public init(
            text: String? = nil
        ) {
            self.text = text
        }
    }
}
```

The label itself is a subclass of `UILabel`, and perhaps the most important part is that we have a function to update the `Label` with a model:

```swift
override public var text: String? {
    get { super.text }
    set { super.text = newValue }
}

public func update(with model: Label.Model) {
    text = model.text
}
```

Now there is some detail there with a [clickable link](https://medium.com/swlh/clickable-link-on-a-swift-label-or-textview-98bbb067451d) which you can skip (it's all in an extension anyway) and still gain full understanding of this code. However, I've also overridden intrinsicContentSize to set the natural size for the receiving view. 

```swift
public override var intrinsicContentSize: CGSize {
    guard let text = text, !text.isEmpty else { return .zero }
    let size = super.intrinsicContentSize
    return .init(
        width: size.width,
        height: size.height
    )
}
```

Effectively we are passing on the size to the superclass, and if there is no text we return a bounding box of zero.

When should we initialize this viewmodel, and where? We should do that in our ViewModel, and initialize our labelModel when the viewcontroller is ready for it after `viewDidLoad()` has been hit from the ViewController.

Therefore I'm going to need therefore to know the LifecycleState of the `UIViewController`. I can write this as an extension on `UIViewController`. 

```swift
public extension UIViewController {
    enum LifecycleState: CaseIterable {
        case didLoad
        case willAppear
        case didAppear
        case willDisappear
        case didDisappear
    }
}
```

We are going to need to listen to the changes in the Label, and we can do that using Combine's [`@Published`](https://stevenpcurtis.medium.com/core-concepts-of-combine-71d6b13d43e2) which is then added in the ViewModel with the following:

```swift
class ViewModel {
    
    @Published private(set) var labelModel: Label.Model = .init()
    
    func didChange(state: UIViewController.LifecycleState) {
        switch state {
        case .didLoad:
            labelModel = .init(text: "test")
            break
        default: break
        }
    }
}
```

# So...
Phew. That's quite a great deal of stuff. Let's look at the code in full!

# The Code
## Label
```swift
final class Label: UILabel {
    public override var intrinsicContentSize: CGSize {
        guard let text = text, !text.isEmpty else { return .zero }
        let size = super.intrinsicContentSize
        return .init(
            width: size.width,
            height: size.height
        )
    }
    
    override public var text: String? {
        get { super.text }
        set { super.text = newValue }
    }
    
    public func update(with model: Label.Model) {
        text = model.text
    }
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(handleLinkTapOnLabel))
    
    public var linkHandler: ((Int, NSRange) -> Void)? {
        didSet {
            if linkHandler != nil {
                isUserInteractionEnabled = true
                addGestureRecognizer(tap)
            } else {
                isUserInteractionEnabled = false
                removeGestureRecognizer(tap)
            }
        }
    }
}

private extension Label {
    @objc func handleLinkTapOnLabel(tapGesture: UITapGestureRecognizer) {
        guard let linkHandler = linkHandler,
            let attributedText = attributedText,
            let font = font else {
            return
        }

        // Configure NSTextContainer
        let textContainer = NSTextContainer(size: CGSize.zero)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
        let labelSize = bounds.size
        textContainer.size = labelSize
        
        // Configure NSLayoutManager and add the text container
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)

        // Configure NSTextStorage and apply the layout manager
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))
        textStorage.addLayoutManager(layoutManager)

        // get the tapped character location
        let locationOfTouchInLabel = tapGesture.location(in: self)

        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x,
            y: locationOfTouchInLabel.y
        )
        
        let characterIndex = layoutManager.characterIndex(
            for: locationOfTouchInTextContainer,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )

        attributedText.enumerateAttribute(
            .link,
            in: NSRange(location: 0, length: attributedText.length),
            options: NSAttributedString.EnumerationOptions(rawValue: UInt(0)),
            using: { (attrs: Any?, range: NSRange, _) in
                if NSLocationInRange(characterIndex, range) {
                    linkHandler(characterIndex, range)
                }
            }
        )
    }
}
```


## Label Model
```swift
extension Label {
    public final class Model {
        public typealias View = Label
        
        public var text: String?

        public init(
            text: String? = nil
        ) {
            self.text = text
        }
    }
}
```

## The Publisher extension

```swift
extension Publisher {
    func withUnretained<Object: AnyObject>(_ obj: Object) -> AnyPublisher<(Object, Output), Error> {
        return tryMap { [weak obj] element -> (Object, Output) in
            guard let obj = obj else { throw UnretainedError.failedRetaining }
            return (obj, element)
        }
        .eraseToAnyPublisher()
    }
}

enum UnretainedError: Swift.Error {
    case failedRetaining
}
```

## The Lifecycle state extension on UIViewController

```swift
public extension UIViewController {
    enum LifecycleState: CaseIterable {
        case didLoad
        case willAppear
        case didAppear
        case willDisappear
        case didDisappear
    }
}
```

# The Repo
I'd love for you to take a look at the repo in full.

# The conclusion

This is one way you might want to consider creating components in your project. Is it the only way? It isn't, but it is certainly one method of doing so, and I'd love to hear your thoughts about this, preferably on [Twitter](https://twitter.com/stevenpcurtis) as you can guarantee I'll see it there.
