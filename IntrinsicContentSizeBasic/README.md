# What is intrinsicContentSize Anyway?
## Make it fit the content

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>

## Keywords and Terminology:
Auto Layout: A constraint-based layout system
intrinsicContentSize: The natural size for the receiving view, considering only properties of the view itself

## Prerequisites:
There aren't any, although you will need to [set up a project](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), although you might like to read through [subclassing a UIView](https://stevenpcurtis.medium.com/subclassing-uiview-in-swift-d372c67b7f3)

# What is this about?
Each view should have an idea amount of space that will display it's content. For example a `UILabel` has a width and height that is based on the size of the text it contains. This simplifies layouts, as rather than specifying the width and height of a component we can tell Auto Layout where to display the component and Auto Layout.

## The Theory
Components often display content, and therefore have an instance property that allows it to communicate to the layout system what size it would like to be, based upon the content which it contains:

```swift
var intrinsicContentSize: CGSize { get }
```

For any given dimension a view may have no intrinsic size, and in this case `noIntrinsicMetric` can be used for that dimension. 

Let us move onto the example.

# A Simple UILabel
A `UILabel` instance will have an `intrinsicContentSize` that is calculated according to the text which it contains. For this example I'm going to set up the views programatically, and use a lazy property for the component:

```swift
lazy var simpleLabel: UILabel = {
   let lab = UILabel()
    lab.text = "Hello, World!"
    lab.translatesAutoresizingMaskIntoConstraints = false
    return lab
}()
```

which is then constrained to the middle-top of the parent view:

```swift
NSLayoutConstraint.activate([
    simpleLabel.topAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.topAnchor,
        constant: 20
    ),
    simpleLabel.centerXAnchor.constraint(
        equalTo: self.view.centerXAnchor
    )
])
```

print the `intrinsicContentSize` and frame of the simpleLabel:
```swift
simpleLabel frame: (111.5, 40.0, 97.5, 20.5)
simpleLabel intrinsicContentSize: (97.5, 20.5)
```

Now it would be tempting to think that all `UIView` subclasses have their size defined by the `intrinsicContentSize`, however that is not true. If we print out the frame and intrinsicContentSize of the view we get another couple of facts"

```swift
view frame: (0.0, 0.0, 320.0, 568.0)
view intrinsicContentSize: (-1.0, -1.0)
```

# Avoiding Hard Coding Width and Height For A UIView Subclass
In order to create a `UIView` subclass, we can avoid having a hardcoded height and width.

We can add the view much as before:

```swift
    lazy var containerView: ContainerView = {
        let container = ContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    // add to setupViews
    self.view.addSubview(containerView)
    
    // add to setupConstraints
	    containerView.topAnchor.constraint(
	    equalTo: self.simpleLabel.bottomAnchor,
	    constant: 20
	),
	containerView.centerXAnchor.constraint(
	    equalTo: self.view.centerXAnchor
	)
```

and then create our `UIView` subclass, and this particular one will not do much, other than setting the background colour.

```swift
final class ContainerView: UIView {
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    // init from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    // common setup code
    private func setupView() {
      backgroundColor = .blue
    }
}
```

Now if you run this, the view will not appear on screen. Logging the frame and `intrinsicContentSize` we can see the problem:

```swift
containerView frame: (160.0, 80.5, 0.0, 0.0)
containerView intrinsicContentSize: (-1.0, -1.0)
```

a natural solution to this would be to hardcode (in this instance at least) some constraints for the width and height of the view. Unfortunately this isn't an article about constraints, so we are going to override the `intrinsicContentSize` property. That is, we are going to add the following variable to the ContainerView code:

```swift
override var intrinsicContentSize: CGSize {
   return CGSize(width: 200, height: 300)
}
```

which then sets us up with the following frame and `intrinsicContentSize`:

```swift
containerView frame: (60.0, 80.5, 200.0, 300.0)
containerView intrinsicContentSize: (200.0, 300.0)
```

(so incidently if you se the constraints on the view you will get the same frame, but `intrinsicContentSize` would then be (-1.0, -1.0)).


# What about the clash?
Auto Layout can calculate the space that a component might need based on the intrinsicContentSize property, however in some circumstances a component may have more or less height than that specified and in this case Auto Layout will use the content compression resistance property and content hugging property to resolve the layout issues appropriately.

# What about changes to the content
If the content size changes we can call from the outside of the class, so something like:

```swift
containerView.invalidateIntrinsicContentSize()
```

Marks the `instrinsicContentSize` as changed and that the frame should be updated. 


# Conclusion
`instrinsicContentSize` allows you to set a size for a view accorrding to their layout. Now it does go slightly deeper than this article has covered (and that might well be an article for the future), but I hope that this article has given you some idea of this important feature of the iOS SDK.

That is: I hope this helps!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
