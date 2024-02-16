# Mastering instantiateInitialViewController: A Guide to Efficient iOS Storyboard Navigation
## Including one gotcha

It took Apple until iOS13 to allow us to use `instantiateInitialViewController()`. Here is a guide about that, but also one gotcha you might fall into.

Docs: [https://developer.apple.com/documentation/uikit/uistoryboard/1616213-instantiateinitialviewcontroller](https://developer.apple.com/documentation/uikit/uistoryboard/1616213-instantiateinitialviewcontroller)

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 15.0, and Swift 5.9

## Terminology:
Storyboard: A way to graphically layout the UI in Xcode
UINavigationController: A container that stores view controllers in a stack

# Introduction
Storyboards are a visual representation of the user interface. Personally I'd prefer to programatically instantiate view controllers yet work constrains often mean you need to work with storyboards.

 Before iOS 13, developers had to navigate a more cumbersome path to inject properties in a view controller meaning that it's difficult to understand the requirements of any particular view controller. Leveraging instantiateInitialViewController() means developers can understand the requirements for ay given view controller and make good decisions accordingly. 
 
 to achieve what instantiateInitialViewController() simplifies, marking its introduction as a significant enhancement to the developer experience. In this guide, we'll dive deep into how to leverage instantiateInitialViewController() for efficient iOS Storyboard navigation, ensuring you're equipped to make the most of this functionality.

# Understanding instantiateInitialViewController
## The problem to be solved

If you wish to inject properties using the storyboard you are likely to need to do something like the following:

```swift
final class SecondViewController: UIViewController {
    var injectedProperty: String?
```

So injectedProperty is optional - but this doesn't make much sense if we need to use that property in the construction of the view controller.

Worse still you'll need a few lines of code to get this to work.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let viewController = segue.destination as? SecondViewController {
        viewController.injectedProperty = "This will be injected."
    }
}

@IBAction func fromSBAction() {
    performSegue(withIdentifier: "next", sender: nil)
}
```

of course you also need to provide a segue in the storyboard

![sb.png](sb.png)

which means there is quite some code and work involved here. There must be a better way.

Luckily Apple came to our rescue in iOS13.

## instantiateInitialViewController as The solution
`UIKit` provides a solution to this problem. When you call this method, it returns an instance of `UIViewController`, which is your entry point to the app's user interface as defined in the Storyboard.

## How It Works
When you design your app's UI using a Storyboard, you can visually set one of the view controllers as the initial view controller. This is typically the first screen your users will see upon launching the app. In Xcode's Storyboard editor, this is done by selecting a view controller and checking the "Is Initial View Controller" option in the Attributes inspector. Internally, this sets the `initialViewController` property of the UIStoryboard to the designated view controller.

The `instantiateInitialViewController()` method looks for the view controller that has been marked as the initial one and creates an instance of it. This instance is fully configured, with all its `IBOutlet` properties and `IBAction` properties connected, ready to be presented on the screen.

# My concrete example

Let us property set up initializers in our SecondViewController

```swift
final class SecondViewController: UIViewController {
    init?(coder: NSCoder, text: String) {
        print(text)
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

So we block other developers using the code intializer which would be called from the storyboard. Detectives might note that the code I've provided in the repo allows access to this, that is simply because in the example I need to allow both property injection and initializer injection. Right!

So from the main view controller I've enabled a button to display this 

```swift
@IBAction func fromDirectAction() {
    let storyboard = UIStoryboard(name: "NextStoryboard", bundle: nil)
    guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
        let secondViewController = SecondViewController(coder: coder, text: "test")
        return secondViewController
    }) else { return }
    present(viewController, animated: true)
}
```

This now uses initialization injection and everything is happy! Yes!

# The gotcha
Sure, it can be difficult to access storyboards across modules. This isn't about that. It's about a very specific situation. 

It's this one:

[Images/vcinnav.png](Images/vcinnav.png)

So that is a different storyboard. This is a view controller wrapped in a `UINavigationController`. Similarly we can instantiate the view controller from the storyboard.

```swift
@IBAction private func fromDirectAction() {
    let storyboard = UIStoryboard(name: "NextStoryboard", bundle: nil)
    guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
        let secondViewController = SecondViewController(coder: coder, text: "test")
        return secondViewController
    }) else { return }
    present(viewController, animated: true)
}
```
Unfortunately we have a crash! 
[Images/crash.png](crash.png)

The error message is something like 

`*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Custom instantiated <StoryboardInstantiateProperties.SecondViewController: 0x105792f40> must be kind of class UINavigationController'
*** First throw call stack:
`

Hmm. It's because we are using the `UINavigationController`.

You'll need to put this programatically into a `UINavigationController`.

```swift
@IBAction func doesntCrash() {
    let storyboard = UIStoryboard(name: "NextStoryboard", bundle: nil)
    guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
        let secondViewController = SecondViewController(coder: coder, text: "test")
        return secondViewController
    }) else { return }
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true)
}
```

Which you can then edit to your heart's desire. I hope that helps you out!

# Conclusion
Thanks for reading!

Navigating the intricacies of iOS development, particularly when it comes to effectively utilizing Storyboards and understanding the dynamics of view controller presentation, is a journey marked by continuous learning and adaptation. The instantiateInitialViewController() method, a cornerstone in the seamless transition from app launch to user interface, exemplifies the elegance and efficiency that Storyboards bring to iOS app development. However, as we've explored, even such straightforward mechanisms come with their nuances and potential pitfalls, such as ensuring full-screen presentation in the era of modal sheets introduced in iOS 13.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
