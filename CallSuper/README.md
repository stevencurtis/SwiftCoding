# Why Do We Call Super When Making iPhone Apps?
## Is it that super?

I've just set up a new project. I've made it work by selecting the template.

The first thing that appears? 

There is a `UIViewController` with the following code.

```swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
```

What is that `super.viewDidLoad()` doing there?

## The Rule
This is about overriding and inheritance. `viewDidLoad` is called after the view is loaded into memory and the outlets are set. 

Since we override `viewDidLoad`, we should call super. The reason for this is the `UIViewController` is not in our control and there could be some setup performed there, and this is really important.

## The Rule Doesn't Matter
It seems that in the `UIViewController` the function `viewDidLoad` does nothing.

`super.viewDidLoad` does nothing in this case. 

In [Apple's documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload) overriding is mentioned, but calling super isn't mentioned. When we should do something on overriding, Apple state it.

Not only does this do nothing, Apple don't even recommend it.

## You Should Follow The Rule
The are a number of arguments about this. One is that we should call super in any case. 

Habit is very important, and in coding habit means that you don't forget to code can mean that you might fail that code review.

But there is something else. 

You might subclass from a BaseViewController that does some setup in the `viewDidLoad` function.

If you don't call super, this code will not be run. This is a real disadvantage. 

# Conclusion
This article is meant to clear up that little problem.

Are you super? That is, I mean you should call super. That's it. Thx bye.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
