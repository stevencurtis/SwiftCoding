# Create A Working UIScrollView Programmatically
## 2 solutions: A UIStackView and a UIView

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed over some time, since I've found using `UIScrollView` instances can be quite tricky, and needed a reference to work from. This article is this reference!

# Prerequisites:
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)

# Terminology
UIScrollView: A view that allows the scrolling and zooming of its contained views

# Implement
There are two different implementations here, one with a `UIStackView` and one with a container `UIView`. In this particular article they are basically the same implementation - but rather than letting the container `UIView` know the height of it's contents we can pin it's bottom to the bottom of the bottommost subview.

That's a mouthful, which is why the code really really helps here.

## The UIStackView version
Let's take a look at this. I recommend looking at the code as you read through this explanation (although the code itself is quite self-explanatory. 

**The Code**
I didn't use lazy instantiation of the views or subviews here, I find it easier to read this stuff sequentially as it's set out here. 

So what we're going to do is, as follows.

I've set the background to purple so we can see it.

Create a `UIScrollView` and we're going to take care of the constraints `translatesAutoresizingMaskIntoConstraints` is false. Add it to the view and pin constraints around equal to the viewcontroller's view.

Create a `UIStackView` which will house our content. We'll take care of the contraints, and setup the axis to vertical with spacing of 10.

We can then create a simple view, make it `500` high with a red background. Whack it into the stackView.
Do the same for a greenview (although give this one a height of `1200`).

Add the stackView to the scrollView.

Now the constraints for the container. Pin the edges tot he scrollView (easy, right?). However, you need to set the width of the stackView to the width of the scrollView. 

That last part - it won't work without it! 

```swift
import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        let container =  UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 10
        
        let redView = UIView()
        redView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        redView.backgroundColor = .red
        
        container.addArrangedSubview(redView)
        
        let greenView = UIView()
        greenView.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        greenView.backgroundColor = .green
        
        container.addArrangedSubview(greenView)
        
        scrollView.addSubview(container)

        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}
```

## The UIView version
Let's do the same (effectively) with a container `UIView`. There's a little more work to do with the constraints as we don't have a `UIStackView` taking card of that stuff for us but I'm sure that we'll get through.

I've set the background to purple so we can see it.

Create a `UIScrollView` and we're going to take care of the constraints `translatesAutoresizingMaskIntoConstraints` is false. Add it to the view and pin constraints around equal to the viewcontroller's view.

We create a `UIView` with the background colour of blue (we should never see this!), and we'll take care of the constraints.

We create a red `UIView` that we will take care of the constrains, and it will have a height of `500` and the same width as the container. The top of this view will be at the top of the container.

We create a green `UIView` that we will take care of the constraints, and it will have a height of `1200` and the same width as the container. The top of this view will be at the bottom of the red view.

We add the `UIView` container to the scrollview.

The container is then pinned to the edges of the scrollview.

Now we need to set the height of the container. Since there is a redView and a greenView with a height of `500 + 1200` respectively, we can set the height of the container to `1700`. This can be done as follows:

```swift
let heightConstraint = container.heightAnchor.constraint(equalToConstant: 1700)
heightConstraint.priority = UILayoutPriority(250)
heightConstraint.isActive = true
```

This is a little wrinkle with this. We need to know the height of the subViews in order to make this work. It's not ideal. A better way is to pin the bottom of the container to the bottom of the green view.

However, you still  need to set the width of the stackView to the width of the scrollView. 

That last part - it won't work without it! 


```swift
import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let container = UIView()
        container.backgroundColor = .blue
        container.translatesAutoresizingMaskIntoConstraints = false

        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = .red

        container.addSubview(redView)
        redView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        redView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        
        let greenView = UIView()
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.backgroundColor = .green
        container.addSubview(greenView)

        greenView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        greenView.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        greenView.topAnchor.constraint(equalTo: redView.bottomAnchor).isActive = true

        scrollView.addSubview(container)

        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        container.bottomAnchor.constraint(equalTo: greenView.bottomAnchor).isActive = true

        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}
```

## The two versions

There might be two versions of this code, the one with the `UIView` and the one with the `UIStackView` but I'm not going to tell you which one to use. That's your decision and your idea of what is best for your project. It's just here to help you see there are two ways of doing this.

# Conclusion

I hope this article has been of help to you. I've been using this code for some time, and I really do hope that it helps someone out!

Subscribing to Medium using [this link](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fmembership) shares some revenue with me.
You might even like to give me a hand by [buying me a coffee] (https://www.buymeacoffee.com/stevenpcuri).
If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
