# Instruct Your View With A ViewModel: Should It Be A Class or a Struct?  
## Another choice?

![Photo by Johann Siemens on Unsplash](Images/bOvf94dPRxWu0u3QsPjF_tree.jpg)<br/>
<sub>Photo by Johann Siemens on Unsplash<sub>

Difficulty: Beginner | Easy | *Normal* | Challenging
This article has been developed using Xcode 12.0.1, and Swift 5.3

# Terminology:
struct: An object defined in Swift, using pass by value semantics
class: An object that defines properties and methods in common

# Prerequisites
- Be able to [create a basic Swift application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)
- You might also like to see the following video to help you out with the differences between Structs and Classes - https://youtu.be/xhfXJ7a2LG8

There are a couple of different ways you can create your ViewModel if you implement the [MVVM architecture](https://medium.com/@stevenpcurtis.sc/mvvm-in-swift-19ba3f87ed45).

If you'd prefer a video, don't worry - I've got you covered: https://youtu.be/xhfXJ7a2LG8

# A comparison project
I've created a simple project that has one view using a `class` for the view model, and one using a `struct` for the view model.

We can see the two view models (see the rather rubbish function that can print to the console).

```swift
struct ViewModel {
    func testFunction() {
        print ("ViewModel function")
    }
}
```

and
```swift
class SecondViewModel {
    func testFunction() {
        print ("SecondViewModel function")
    }
}
```

which is then used in turn from the view controllers:

```swift
final class ViewController: UIViewController {
    private var viewModel: ViewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.testFunction()
    }
}
```

and 

```swift
final class SecondViewController: UIViewController {
    private var viewModel: SecondViewModel = SecondViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.testFunction()
    }
}
```

this is...interesting.

In this example it seems to make *no differences*

But THERE ARE DIFFERENCES: But what is relevant?

## Choosing between a class and a struct
I've already got an article that can help you choose between `classes` and `structs` [class or struct](https://medium.com/swift-coding/when-to-use-class-or-struct-in-swift-e6037147c1d) and without going into details, we should usually choose a struct unless we specifically need one of the features of a class.

Which feature do we need? Well the fact is we need to think about how we are accessing the view model.

In both of the cases we create an instance of the view model. 

Now the issue I return to is that if you have a ViewModel and assign it to multiple ViewControllers, if you use a `struct` each version of the ViewModel will be a copy: bad times. If you use a `class` we are in pass by reference semantics and would therefore be able to use multiple ViewControllers for a ViewModel.

Other reasons? 

You might want to subclass a base ViewModel, and this is only possible using the features of a `class`.

In any case, you should really use a class for a ViewModel. Really. Believe me.

# Conclusion
Making sure that you have the right tool for each job is really important in your journey as a software developer. You need to make sure that you know the difference between the two: [this article](https://medium.com/swift-coding/when-to-use-class-or-struct-in-swift-e6037147c1d) will help

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
