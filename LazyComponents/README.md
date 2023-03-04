# Avoid Swift's Optionals Through Laziness
## Programming should make things easier!

![photo-1533743983669-94fa5c4338ec](Images/photo-1533743983669-94fa5c4338ec.jpeg)
<sub>Photo by Kote Puerto</sub>

Difficulty: **Beginner** | Easy | Normal | Challenging<br/>
This article has been developed using Xcode 12.1, and Swift 5.3

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* This article assumes that you are coding 100% programatically, and are using loadView [for which I use this technique](https://medium.com/@stevenpcurtis.sc/write-clean-code-by-overriding-loadview-ac4f172163d0)

## Terminology
Optionals: Swift introduced optionals that handle the absence of a value, simply by declaring if there is a value or not. An optional is a type on it’s own!
Storyboard: A way to graphically layout the UI in Xcode

## Assumptions
This article assumes that you are going to create an App wholly programatically, and have therefore removed the `UIStoryboard` instance from your project.

# The ordinary solution
We are going to add a simple `UILabel` into the middle of the host view controller. But how to add the property and perform the configuration of the same? In this article, we are going to perform the configuration in `loadView()` which means that the compiler doesn't see the `UILabel` instance as complete until the loadView as finished - so the `UILabel` property is naturally an optionaL

There are a couple of ways of dealing with this - one is to make the label an optional. To solve the problem of potentially [force-unwrapping](https://medium.com/@stevenpcurtis.sc/avoiding-force-unwrapping-in-swift-6dae252e970e) in this example I've used a [guard](https://medium.com/@stevenpcurtis.sc/precondition-assert-fatal-error-or-guard-in-your-swift-code-5f9297658be0).

```swift
class OrdinaryViewController: UIViewController {
    var label: UILabel?
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view

        label = UILabel()
        label?.text = "This is a great label!"
        label?.textAlignment = .center
        label?.translatesAutoresizingMaskIntoConstraints = false
        
        guard let label = label else {return}
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
```

which really is OK. An alternative is to use an implicitly-inwrapped optional (that is, set up the `UILabel` instance as a property with `var label: UILabel!`. Some dislike this approach, but it is functionally identical to the code shown above.

```swift
class OrdinaryViewController: UIViewController {
    var label: UILabel!
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view

        label = UILabel()
        label.text = "This is a great label!"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
```

Arguably we have the same issue in both these implementations - the configuration of the `UILabel` is right in the `loadView` - so can we abstract that away somehow?

## The lazy view controller
We can make the `UILabel` instance a lazy property. This means that we can use a closure to config the instance only when it is first used. So the configuration only happens on the first load of the property.

The (similar code to those above) is shown here:

```swift
final class LazyViewController: UIViewController {
    private var label: UILabel = {
        let lab = UILabel()
        lab.text = "This is a great label!"
        lab.textAlignment = .center
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
```

In effect, rather than use the optional (or, gasp, a force-unwrapped property) we use a lazily created UILabel.

```swift
private var label: UILabel = {
    let lab = UILabel()
    lab.text = "This is a great label!"
    lab.textAlignment = .center
    lab.translatesAutoresizingMaskIntoConstraints = false
    return lab
}()
```

Note that the `var` finished with parenthesis `()` which means that the closure is immediately executed. Since this label is immediately executed and assigned to the `label` variable before anything else there is no need to use the `lazy` keyword.

You might think that the label is created multiple times. Of course this isn't true! The `var` is only instantiated (and the label created) the first time the property is accessed. After this, the property is saved and any subsequent calls access this saved property, so there isn't any waste here!


# Conclusion
These are all different techniques to essentially create a UILabel that you will probably need in `UIKit` development. Which one is right for you? This is for you to decide, but I hope this article has added a few more tools to your toolset in a small timeframe.

Oh, and notice that there is a lack of the **lazy** keyword above, but the properties are still lazy. That's the breaks!

Thank you for reading.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
