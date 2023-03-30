# Using and Testing User Defaults in Swift
## Knowing when to use it is important!

![Photo by Wonderlane on Unsplash](Images/photo-1568226940395-d125946a2bb5.jpeg)<br/>
<sub>Photo by Wonderlane on Unsplash<sub>

User defaults are an important way to store small pieces of data  in your application.

# The implementation of UserDefaults
Remember that `UserDefaults` is called defaults since they usually refer to the App's default state at startup or the default behaviour of the Application. Wonderfully `UserDefaults` is thread safe!

iOS stores `NSUserDefaults` into a plist file. This means that there is no real benefit to using a plist file over `UserDefaults` (with some wonderful cache in place), and yet also provides a simple warning.

Never store information in `UserDefaults` that should be private, and it should be assumed that the file is completely insecure.

The limitations don't stop there! We can only store key-value pairs and you can write both basic types and even collections or `Data` values (but be careful when you use `object(forKey:)` since it returns Any?).

`UserDefaults` stores it's magic in the `Library/Preferences` folder.

# Usage: Previously Launched
You can detect whether an app has previously been launched by using `UserDefaults` which stores a boolean (if nothing is stored it will default to false)

```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red

        let previouslyLaunched = UserDefaults.standard.bool(forKey: "previouslyLaunched")
        if previouslyLaunched {
            print ("Previously Launched")
        } else {
            print ("Not Previously Launched")
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
        }
    }
}
```

This is all very nice, but how are we going to *test* this? You might well be aware of [Dependency Injection](https://medium.com/@stevenpcurtis.sc/learning-dependency-injection-using-swift-c94183742187) and think that might be the solution, and it turns out (spoiler) that is indeed is.

# A testable view controller - with tests!
This would allow us to inject the dependency if the view controller is instantiated through a segue:

```swift
@IBSegueAction func segueAction(_ coder: NSCoder) -> InjectedViewController? {
    return InjectedViewController(coder: coder, UserDefaults())
}
```

with the view controller:

```swift
class InjectedViewController: UIViewController {
    var userDefaults: UserDefaults!
    var isPreviouslyLaunched = false
    
    @IBSegueAction func segueAction(_ coder: NSCoder) -> InjectedMockViewController? {
        return InjectedMockViewController(coder: coder, userDefaults: UserDefaults())
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder, userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue

        let previouslyLaunched = userDefaults.bool(forKey: "previouslyLaunched")
        if previouslyLaunched {
            print ("Previously Launched in InjectedViewController")
            isPreviouslyLaunched = true
        } else {
            print ("Not Previously Launched in InjectedViewController")
            isPreviouslyLaunched = false
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
        }
    }
}
```

Note that I wouldn't usually have a boolean to check to see whether something is set, but needs must for a short article.

Anyway this is fine, but we still need to use user defaults to make our tests

```swift
func testUserFalseDefault() {
    let databaseName = "testing"
    let userDefaults = UserDefaults(suiteName: databaseName)!
    userDefaults.removePersistentDomain(forName: "testing")
    
    let viewController = InjectedViewController(userDefaults: userDefaults)
    let _ = viewController.view
    
    XCTAssertEqual(viewController.isPreviouslyLaunched, false)
}

func testUserTrueDefault() {
    let databaseName = "testing"
    let userDefaults = UserDefaults(suiteName: databaseName)!
    userDefaults.removePersistentDomain(forName: "testing")
    userDefaults.setValue(true, forKey: "previouslyLaunched")
    
    let viewController = InjectedViewController(userDefaults: userDefaults)
    let _ = viewController.view
    
    XCTAssertEqual(viewController.isPreviouslyLaunched, true)
}
```

# Create a mock that can be injected
In order to this we can set up a `protocol` and make the standard UserDefaults conform to that protocol - in this case I'll simply implement the `Boolean` function for this:

```swift
protocol UserDefaultsProtocol {
    func bool(forKey defaultName: String) -> Bool
}

extension UserDefaults: UserDefaultsProtocol {}
```

in order to access this once again we can implement the `segueAction`

```swift
@IBSegueAction func segueAction(_ coder: NSCoder) -> InjectedMockViewController? {
    return InjectedMockViewController(coder: coder, userDefaults: UserDefaults())
}
```

which works on the `InjectedMockViewController`:

```swift
class InjectedMockViewController: UIViewController {
    var userDefaults: UserDefaultsProtocol!
    var isPreviouslyLaunched = false

    init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder, userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange

        let previouslyLaunched = userDefaults.bool(forKey: "previouslyLaunched")
        if previouslyLaunched {
            print ("Previously Launched in InjectedMockViewController")
            isPreviouslyLaunched = true
        } else {
            print ("Not Previously Launched in InjectedMockViewController")
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
            isPreviouslyLaunched = false
        }
    }
}
```

This can then be tested with the following Mock

```swift
class MockUserDefaults: UserDefaultsProtocol {
    var shouldReturnBool = false
    func bool(forKey defaultName: String) -> Bool {
        return shouldReturnBool
    }
}
```

of course this is tested with the same rather awful property check:
```swift
func testUserTrueDefault() {
    let userDefaults = MockUserDefaults()
    userDefaults.shouldReturnBool = true
    let viewController = InjectedMockViewController(userDefaults: userDefaults)
    let _ = viewController.view
    
    XCTAssertEqual(viewController.isPreviouslyLaunched, true)
}

func testUserFalseDefault() {
    let userDefaults = MockUserDefaults()
    userDefaults.shouldReturnBool = false
    let viewController = InjectedMockViewController(userDefaults: userDefaults)
    let _ = viewController.view
    
    XCTAssertEqual(viewController.isPreviouslyLaunched, false)
}
```

This works better, since we are not reliant on the standard implementation of `UserDefault` at all.

That's awesome!

# Conclusion
I hope this article has been of help to you, and perhaps I'll see you in the next article?

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
