# Implement a Service-Oriented Architecture in Swift 5
## Make sure your App Delegate can take care of it too!


[Photo by Lefteris kallergis on Unsplash](Images/0*twIMMcS8a1utDkst.jpeg)

A Service Oriented Architecture (SOA) is an architecture pattern that consolidates functionality and business logic in such a way that services can be injected into view controllers for use.

This type of architecture can leverage [dependency injection](https://stevenpcurtis.medium.com/learning-dependency-injection-using-swift-c94183742187) as a means to achieve a clear separation of concerns.

# Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) or a Playground to run Swift code
* This article avoids [Dependency Injection](https://stevenpcurtis.medium.com/learning-dependency-injection-using-swift-c94183742187), but you should be aware of what that is

# Terminology:
* AppDelegate: Effectively the root object of an iOS App, working in conjunction with UIApplication to manage interactions with the system.


# The basics:
[](Images/Diagram.png)
This diagram shows three possible services, one for crash reporting, one for analytics and one for persisance and of course the classic one for [networking](https://github.com/stevencurtis/NetworkManager).

# The Basic Implementation
## App Delegate
Within the App Delegate we can set up the services

```swift
var services: [UIApplicationDelegate] = [
    PersistenceService(),
    AnalyticsService(),
    CrashReporterService()
]
```

## The AnalyticsService
```swift
class AnalyticsService: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if ALPHA
        //register with one id
        #else
        //Register with another one
        #endif
        //Analytics manager starttracking
        return true
    }
}
```

## The CrashReporterService
```swift
class CrashReporterService: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
```

## PersistenceService
```swift
class CrashReporterService: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
```

But this gives us a real issue. How are we going to *test* this? The `AppDelegate` approach is not something we should really be even thinking about doing (well, it's fine for the analytics service which might need to be run when the app starts, and OK the crash reporter and persistence service makes sense) - so what about the network?

# The Layered Implementation
What we really want to achieve is an **abstraction**. The application layer ideally is separated from the Service Layer and the Data Access Layer. The basic example above does at least separate the code between the services and the application layer, however we have not considered how the detail might work. Moreover, we want a way to access the Data without resorting to spaghetti code.

[Diagram.png](Images/Diagram.png)

*No problem*

## The network manager
I've implemented by own Network Manager from `https://github.com/stevencurtis/NetworkManager`, and I'd love to have the option to mock this out. It turns out I can do just that with the following initializer and property combination:

```swift
private var anyNetworkManager: AnyNetworkManager<URLSession>?

init() {
    self.anyNetworkManager = AnyNetworkManager()
}

init<T: NetworkManagerProtocol>(
    networkManager: T
) {
    self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
}
```

Where we can choose whether to user the general network manager, or choose whether to inject a network manager that conforms to the following protocol:

```swift
public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }
    func cancel()
    func fetch(url: URL, method: HTTPMethod, completionBlock: @escaping (Result<Data, Error>) -> Void)
}

public extension NetworkManagerProtocol {
    func fetch(url: URL, method: HTTPMethod, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetch(url: url, method: method, completionBlock: completionBlock)
    }
}
```

Now we can initialize our network manager from a suitable viewmodel (and, indeed, there is one in the Repo attached to this article):

```swift
import Foundation
import NetworkLibrary

protocol ViewModelProtocol {
    func download()
    var dataClosure: ((Users?) -> Void)? { get set }
}

class ViewModel: ViewModelProtocol {
    
    private var anyNetworkManager: AnyNetworkManager<URLSession>?
    var dataClosure: ((Users?) -> Void)?
    
    init() {
        self.anyNetworkManager = AnyNetworkManager()
    }

    init<T: NetworkManagerProtocol>(
        networkManager: T
    ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
    }
    
    func download() {
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}
        anyNetworkManager?.fetch(url: url, method: .get(headers: [:], token: nil), completionBlock: {result in
            print(result)
            switch result {
            case .failure: break
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try? decoder.decode(Users.self, from: data)
                self.dataClosure?(decoded)
            }
        })
    }
}
```

which does of course need to be instantiated from the ViewController, requiring the reasonably ugly dance around initializers:

```swift
class InjectedViewController: UIViewController {
    var viewModel: ViewModelProtocol
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        viewModel.dataClosure = { data in
            DispatchQueue.main.async {
                self.textView.text = data?.data.map{ $0.email }.joined(separator: "\n")
            }
        }
    }
    
    required init?(coder: NSCoder, viewModel: ViewModelProtocol) {
      self.viewModel = viewModel
      super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
      fatalError("A view model is required")
    }
    @IBAction func downloadAction(_ sender: UIButton) {
        print("download")
        viewModel.download()
    }
}
```

and in order to elegantly instantitate the initial view controller I used the following in the `SceneDelegate`:

```swift
var window: UIWindow?

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScreen = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScreen)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(identifier: "first", creator: { coder in
        return InjectedViewController(coder: coder, viewModel: ViewModel())
    })

    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
}
```

you might like the following [article](https://stevenpcurtis.medium.com/dependency-injection-using-storyboards-a13c2e11abc7) that goes into this process in more detail (using storyboards) and the essence of dependency injection in the [following article](https://stevenpcurtis.medium.com/learning-dependency-injection-using-swift-c94183742187)

# Conclusion
Architectures should be scalable and flexible. 

Rather than thinking in terms of the best or most correct way of designing a framework we should look at the requirements of the same, and produce a structure that will help meet a need for both programmers and the end user of the App.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
