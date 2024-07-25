# Implementing iOS Feature Flags Using Firebase
## A tutorial

I've been coding iOS Swift apps for a while. I've been writing articles for a long time. I just realised that I've ignored  feature flags (also known as feature toggles).
So I've used Firebase to implement them in a sample project. They work great and mean that you'd be able to turn features on or off without code deployment or releases. That's something you'd probably want in a production app, so let us get on with the proof of concept!

# Feature Flags? What's That?
Feature flags are also known as feature toggles.

Using feature flags enables continuous integration and delivery, so code can be merged into the main branch without immediately being avaliable to users. That is, new code is behind a feature flag so will only be made available to users when we are ready to release.

This facilitates A/B testing and gradual rollouts. Experiments can be run to decide whether one version of an app is truly better than another. If a feature is broken for some reason we also have the safety net of being able to disable features.

Of course most of this is only true if the feature flag can be controlled remotely, that is from outside the target app. That's where Firebase comes in.

Firebase enables controlling these feature flags from a friendly-looking Google console. So let's setup the feature flags and then get coding!

# Setup Firebase
You need to setup an account on [https://firebase.google.com](https://firebase.google.com), and don't worry - I'll wait while you do so.

[Images/addproject.png](Images/addproject.png)<br>

Click through and give it a name, just get this up and running! Google might make you wait while they set up the project.
We are going to setup Remote Config.

[Images/remoteconfig.png](Images/remoteconfig.png)<br>

Then we can use the button to know how to get the files for the Firebase setup. Clicking iOS will help us here:

[Images/addfirebase.png](Images/addfirebase.png)<br>

We really need the config file. So after step 1, go to step 2.

[Images/addpackage.png](Images/addpackage.png]<br>

As it says we need to add the plist file into all targets.
We also need to add in Firebase. I'm using Swift Package Manager for this as an example. Here are a couple of steps to put this into your project. Add Swift Package https://github.com/firebase/firebase-ios-sdk

[Images/addpackage2.png](Images/addpackage2.png]<br>

And add to targets.

[Images/firebaseanalytics.png](Images/firebaseanalytics.png]<br>

I then setup a parameter in the Firebase console. Here is my particular parameter, sure it doesn't do all that much, but this is a proof of concept demo right! Don't expect too much!

[Images/remoteconfigparam.png](Images/remoteconfigparam.png)<br>

## Config Code
In the AppDelegate we need to configure Firebase. Here is the code to do just that:

```swift
import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
      [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
```

# Basic version

```swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        fetchFeatureFlags()
        return true
    }
    
    func fetchFeatureFlags() {
        let config = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0  // During testing
        // settings.isDeveloperModeEnabled = true  // Depreciated but useful for immediate effects
        config.configSettings = settings
        // Configure minimum fetch interval
        config.fetchAndActivate { status, error in
            if let error = error {
                print("Error during Remote Config fetch: \(error.localizedDescription)")
            } else {
                print("Remote Config fetched and activated \(status)")
                
                let testValue = RemoteConfig.remoteConfig().configValue(forKey: "test").boolValue
                     print("Test Value: \(String(describing: testValue))")
            }
        }
    }
```

This can be accessed within the View Controller.
Something like this will do:

```swift
final class ViewController: UIViewController {

    @IBOutlet private var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let testValue = RemoteConfig.remoteConfig().configValue(forKey: "test").boolValue
        if testValue {
            testLabel.text = "value true"
        } else {
            testLabel.text = "value false"
        }
        print("Test Values: \(String(describing: testValue))")
    }
}
```

Which isn't great. Each time we want to use a flag we need to import the Firebase module, and we need to know the `configvalue`. And there is boilerplate code. It all isn't great.

# Moving to the View Model
Using storyboards is a bit of a pain for this, but we will persist. Let's use a closure for updating the view controller too to try to make this simple.

ViewController:
```swift
final class ViewController: UIViewController {
    var viewModel = ViewModel()

    @IBOutlet private var testLabel: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateHandler = { [weak self] testValue in
            DispatchQueue.main.async {
                self?.testLabel.text = testValue ? "value true" : "value false"
            }
        }
        
        viewModel.fetchFeatureFlag()
    }
}
```

ViewModel:

```swift
final class ViewModel {
    var updateHandler: ((Bool) -> Void)?
    var testValue: Bool = false {
        didSet {
            updateHandler?(testValue)
        }
    }
    
    func fetchFeatureFlag() {
        let config = RemoteConfig.remoteConfig()
        config.fetchAndActivate { [weak self] status, error in
            if let error = error {
                print("Error fetching config: \(error.localizedDescription)")
            } else {
                print("Config fetched and activated")
                self?.testValue = config.configValue(forKey: "test").boolValue
            }
        }
    }
}
```

But...there is still too much boilerplate code, and we can do better!

# Doing Better
We can create a property wrapper `RemoteFeatureSwitch` that manages feature toggles fetched from the Firebase Remote Config. This creates a reusable and type-safe way to access feature flags:

```swift
@propertyWrapper
public struct RemoteFeatureSwitch<T: Hashable> {
    public let key: String
    public let description: String
    private let defaultValue: T

    public var wrappedValue: T {
        let value = RemoteConfig.remoteConfig().configValue(forKey: key)
        switch T.self {
        case is Bool.Type:
            return (value.boolValue as? T) ?? defaultValue
        case is Int.Type:
            return (value.numberValue.intValue as? T) ?? defaultValue
        case is String.Type:
            return (value.stringValue as? T) ?? defaultValue
        default:
            return defaultValue
        }
    }

    public var projectedValue: RemoteFeatureSwitch<T> {
        return self
    }

    public init(key: String, description: String = "", defaultValue: T) {
        self.key = key
        self.description = description
        self.defaultValue = defaultValue
    }
}

extension RemoteFeatureSwitch where T == Bool {
    static func boolFeatureSwitch(key: String, description: String, defaultValue: Bool) -> RemoteFeatureSwitch<Bool> {
        return RemoteFeatureSwitch<Bool>(
            key: key,
            description: description,
            defaultValue: defaultValue
        )
    }
}
``` 

Using a property wrapper here maximises code reusability and separation of concerns. 

```swift
@propertyWrapper
public struct RemoteFeatureSwitch<T: Hashable> {
    public let key: String
    public let description: String
    private let defaultValue: T
```

The generic type `T` conforms to `Hashable` meaning the values can be effectively used and stored.

The wrapped value determines how the value is fetch and returned, attempting to use the configuration value from Firebase using the key.

```swift
public var wrappedValue: T {
    let value = RemoteConfig.remoteConfig().configValue(forKey: key)
    switch T.self {
    case is Bool.Type:
        return (value.boolValue as? T) ?? defaultValue
    case is Int.Type:
        return (value.numberValue.intValue as? T) ?? defaultValue
    case is String.Type:
        return (value.stringValue as? T) ?? defaultValue
    default:
        return defaultValue
    }
}
```

It switches on the type of the Firebase value, and if the cast fails it falls back to the default value.

The projected value - 

```swift
public var projectedValue: RemoteFeatureSwitch<T> {
    return self
}
```

allows direct access to the instance of `RemoteFeatureSwitch` through a `$` prefix when accessing a wrapped property.

I then set up a struct for all of the feature flags (which is just one at this point!):

```swift
struct Features {
    @RemoteFeatureSwitch(key: "test", defaultValue: false)
    static var isNewFeatureEnabled: Bool
}
```

this can then be used in the view model - however you want to!

```swift
        Features.isNewFeatureEnabled
```

# Conclusion
Phew! Got those working. I hope this article has helped someone out. See you soon!
