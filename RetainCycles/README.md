# Practical Reference Cycles in Swift
## Don't let this stop you!

![Photo by Mitchel Lensink on Unsplash](Images/photo-1486645725491-57c86b563b91.jpeg)<br/>
<sub>Photo by Mitchel Lensink on Unsplash<sub>

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 12.0, and Swift 5.3

There are plenty of guides about reference cycles in Swift, and [many of them](https://medium.com/swlh/using-capture-lists-in-swift-19f408f986d) will recommend you using `[weak self]` to get out of trouble. 

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), or a [Playground](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to run Swift code
* [Optional chaining](https://medium.com/swlh/swifts-optional-chaining-b7d2a7e18b86) is referred to within the article

## Terminology:
Capture lists: The list of values that you want to remain unchanged at the time the closure is created
Capturing values: If you use external values inside your closure, Swift stores them alongside the closure. This way they persist even when the external part of the code no longer exists
Closure: A self-contained block of functionality that can be passed around

## The project
Reference cycles are something that every iOS developer should be aware of, as they can cause memory leaks (which are memory allocations that are never released). 

Theoretically this seems easy - but where are examples that you can play with and see whether a memory leak might be caused?

# The setup
I tend to use programmatic interfaces (I hope that doesn't offend you!) and what I'm going to do is instantiate a ViewController into a `UINavigationController` - called `ViewController` (what a name!) which pushes a second view controller `SecondViewController` onto the stack - and this one tracks when it is released through 
```swift
deinit {
      print ("deinit Second View Controller")
}
```
so *deinit Second View Controller* will only be printed when memory is released.

There's nothing earth-shattering about this implementation (I hope!) - yes it does use [loadView](https://medium.com/@stevenpcurtis.sc/write-clean-code-by-overriding-loadview-ac4f172163d0)

**Setting up the scene in SceneDelegate**
```swift
guard let windowScene = (scene as? UIWindowScene) else { return }
window = UIWindow(frame: windowScene.coordinateSpace.bounds)
window?.windowScene = windowScene
let rootNC = UINavigationController(rootViewController: ViewController())
self.window?.rootViewController = rootNC
window?.makeKeyAndVisible()
```

**ViewController**
```swift
class ViewController: UIViewController {    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let second = SecondViewController()
        self.navigationController?.pushViewController(second, animated: true)
    }
}
```

**SecondViewController with a DataManager at the end**
```swift
class SecondViewController: UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .blue
        self.view = view
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var articles = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataManagerClass = DataManagerClass()
        dataManagerClass.articlesDidChange = {result in
            self.articles = result
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
         print ("deinit Second View Controller")
    }
}

class DataManagerClass {
    var articlesDidChange: ((Int)->())?
}
```

# The example
This is useful because you might want to simulate having a data manager class that captures a reference to self.

If the message "deinit Second View Controller" is displayed the Second View Controller is released from memory, and everything is happy. Without that message - we are trouble since the Second View Controller will be allocated for the entire lifecycle of the App (potentially).

**Can Deinit** 
We place the dataManagerClass within our calling function (in this case `viewDidLoad`), and this means that when the view controller is released, the locally scoped dataManagerClass is also present.
```swift
    var articles = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataManagerClass = DataManagerClass()
                
        dataManagerClass.articlesDidChange = {result in
            self.articles = result
        }
    }
```

In the example above, `dataManagerClass` is declared in the general view controller. So when the view controller is deinit (disappears from memory) everything is fine - the closure will not outlive the lifecycle of the enclosing view controller.

**Cannot Deinit**
Oh no! You might have (normally) declared your `dataManagerClass` within the class of the view controller. 
```swift
    var articles = 0
    let dataManagerClass = DataManagerClass()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManagerClass.articlesDidChange = {result in
            self.articles = result
        }
    }
```

When the view controller is released, we have a strong reference to articles within the closure. This keeps the closure around until the async closure returns - but what if this *never* returns? This would be an unmitigated disaster (or at least a memory leak). 

**Can deinit - weak self edition**
```swift
    var articles = 0
    let dataManagerClass = DataManagerClass()

    override func viewDidLoad() {
        super.viewDidLoad()
        // let dataManagerClass = DataManagerClass()
        dataManagerClass.articlesDidChange = { [weak self] result in
            self?.articles = result
        }
        
        self.navigationController?.popViewController(animated: true)
    }
```

We now have a *weak reference* to self - meaning that the retain count is not increased and we can release self and avoid a memory cycle - when the view controller is released it can be removed from memory - and of course `self?.articles` will resolve to nil through the magic of [optional chaining](https://medium.com/swlh/swifts-optional-chaining-b7d2a7e18b86).

You are free to play with the files in the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/RetainCycles)

# Conclusion

It's always great to see how things might just work in practice - and having this code from the repo will hopefully allow you to play with retain cycles and how they might work for you. 

I've found it useful - I hope you do too!
 
 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
