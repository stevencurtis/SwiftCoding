# Swift Code Snippets
## A collection of tips that I've found to be useful in Swift
Perhaps not worthy of a full article, but useful nonetheless

## Contents

[Decode a file from the bundle](#Decode-a-file-from-the-bundle)<br>
[Decode JSON with a generic function](#Decode-JSON-with-a-generic-function)<br>
[Set status bar to light](#status-bar-light)<br>

# The Code
## Decode a file from the bundle

```swift
extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw ErrorModel(errorDescription: "\(file) missing in \(self).")
        }

        guard let data = try? Data(contentsOf: url) else {
            throw ErrorModel(errorDescription: "\(file) missing in \(self).")
        }

        let decoder = JSONDecoder()

        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw ErrorModel(errorDescription: "\(file) could not be decoded from \(self) with error: \(error).")
        }
    }
}
```

which can then be tested

```swift
func testingBundle() {
    let file = try! Bundle(for: type(of: self)).decode(MODEL.self, from: "FILE.json")
    XCTAssertEqual(model.property, "String")
}
```

## Decode JSON with a generic function
```swift
func decode<T: Decodable>(decoder: JSONDecoder, data: Data) -> T? {
    do {
        return try decoder.decode(T.self, from: data)
    } catch {
        // will silently fail and return nil
        return nil
    }
}
```

which, as it returns an optional where `Model` is the model of the response type
```swift
let ans: Model? = self.decode(data: data)
```
## Status bar light
To set the status bar light throughout the App you will need to set it in the `Deployment info` section of the Project details
![statusbar](Images/statusbarset.png)<br/>

Then we need to set the plist  
![statusbarplist](Images/statusbarsetplist.png)<br/>


## Parse JSON when you don't know the data type
```swift
do {
    let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
    if let jsonDict = jsonObject as? NSDictionary {
        print (jsonDict)
    }
    if let jsonArray = jsonObject as? NSArray {
        print (jsonArray)
    }
} catch {
    // error handling
}
```

## Storing constants
There are other ways of storing constants (using a `struct` for instance), but by using an `enum` there is no chance of accidently instantiating your constants. Which is nice. This method also ensures that your constants are unique (it is a pure namespace). More importantly, in `Combine` Apple have used `enum` for namespaces. 

```swift
enum Colorss {
    static let green = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
}
```

## An API switcher for multiple endpoints
You might well need to hit multiple endpoints within your App. 
```swift
enum API {
    case standard
    case stream
    
    var url: URL {
        var component = URLComponents()
        
        switch self {
        case .standard:
            component.scheme = "http"
            component.host = "www.host.com"
            component.path = path
        case .stream:
            component.scheme = "https"
            component.host = "www.althost.com"
        }
        return component.url!
    }
}

extension API {
    fileprivate var path: String {
        switch self {
        case .standard:
            return "/v2/standard"
        default:
            fatalError("failed API")
        }
    }
}

print (API.standard.url)
print (API.stream.url)
```
The tests for this are relatively easy. just create the urls and check the result.
```swift
func testAuthentication() {
    XCTAssertEqual(API.authentication.url, URL(string:"http://www.host.com/v2/standard"))
}
```

## Convert from Snake Case
You might want to convert `student_id` to `studentId` since the Swift [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/#general-conventions) recommends you do just this.

In use, we set a parameter on `JSONDecoder` like the following code snippet:
```swift
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
```

## Push to a view controller with storyboards
```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "traverseSegue" {
            if let detail = segue.destination as? DetailViewController {
                detail.item = "test"
            }
        }
    }

    @IBAction func buttAction(_ sender: UIButton) {
        let detailViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as UIViewController

        if let detail = detailViewController as? DetailViewController {
            detail.item = "test"
        }
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @IBAction func infoButtonAction(_ sender: UIButton) {
        traverseToInfo()
    }
    
    var viewControllerFactory: ViewControllerFactoryProtocol = ViewControllerFactory()
    
    func traverseToInfo() {
        let vc = viewControllerFactory.createInfoViewControllerWith(item: "test")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
```

with a factory
```swift
protocol ViewControllerFactoryProtocol {
    func createInfoViewControllerWith(item: String) -> UIViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    let storyboard: UIStoryboard

    func createInfoViewControllerWith(item: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InformationViewController
        vc.item = item
        return vc

    }
    
    init(storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) {
        self.storyboard = storyboard
    }
}
```
and information view controller
```swift
class InformationViewController: UIViewController {
    var item: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        print (item!)
    }
}
```

## Create an MVVM project 
SceneDelegate
```swift
guard let windowScene = (scene as? UIWindowScene) else { return }
window = UIWindow(frame: windowScene.coordinateSpace.bounds)
window?.windowScene = windowScene

let networkManager = NetworkManager(session: URLSession.shared)

let viewModel = CurrencyPairsViewModel(
    networkManager: networkManager,
    timer: ExchangeTimer(),
    dataManager: DataManager()
)
let viewController = CurrencyPairsViewController(viewModel: viewModel)
let rootNC = UINavigationController(rootViewController: viewController)

self.window?.rootViewController = rootNC

window?.makeKeyAndVisible()
```

then setup 

```swift
    init(viewModel: CurrencyPairsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```

The viewmodel than uses the following, storing the network manager as `AnyNetworkManager`
```swift
class CurrencyPairsViewModel {
    private var networkManager: AnyNetworkManager<URLSession>?
        init<T: NetworkManagerProtocol>(networkManager: T, timer: TimerProtocol, dataManager: DataManagerProtocol) {
        self.networkManager = AnyNetworkManager(manager: networkManager)
        self.dataManager = dataManager
        self.timer = timer
        
        countries = cdpairs ?? []
        
        setupTimer()
    }
}
```
