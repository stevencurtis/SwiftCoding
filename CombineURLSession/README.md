# Combine and URLSession in UIKit
## Bound together, combined

![Photo by Gregory Hayes on Unsplash](Images/0*QZtk1PWOodYI2Nsi.jpeg)<br/>
<sub>Photo by Gregory Hayes on Unsplash<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.4.1, and Swift 5.2.2

This article is about using `Combine` in conjunction with `UIKit` in order to get the basics of the former down without the expectation of knowledge about [SwiftUI](https://medium.com/@stevenpcurtis.sc/hello-world-swiftui-92bcf48a62d3). This implementation calls a network manager much like a login for any particular App.

**The approach**
I'm not going to use [storyboards](https://medium.com/@stevenpcurtis.sc/avoid-storyboards-in-your-apps-8e726df43d2e), but am going to use UIKit and [MVVM](https://medium.com/@stevenpcurtis.sc/mvvm-in-swift-19ba3f87ed45) to keep things rather simple. I'm going to apply some [Dependency Injection](https://medium.com/@stevenpcurtis.sc/learning-dependency-injection-using-swift-c94183742187) skills in order to test `URLSession`, and this uses a [keychain manager](https://medium.com/@stevenpcurtis.sc/secure-user-data-with-keychain-in-swift-337684d6488c) to save the token (which is also tested). 

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* I recommend that you download the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/CombineURLSession) and read the code along with this article, although I have written the article to be a stand-alone document

## Terminology:
Combine: A framework that provides a declarative Swift API for processing values over time

# The Examples
`Combine` has many possible uses, and we are not constrained when linking `Combine` to `SwiftUI`.

The example code shows instances of:

* Setting up pipelines to lock a `UIButton` until the values entered into a `UITextField` are valid
* Create a pipeline to perform an asynchronous network call, choosing how and what to update within a view
* Create a pipeline to adjust the state of a `UIButton` dynamically according to the text in a `UITextField` updating the user interface accordingly

You know what this reminded me of? 

**Material Design!**

# The App:
![app](Movies/app.gif)<br/>

The App has a simple login and a material-design alike interface. When the username and password are entered, the view controller asks the viewmodel to make an API call.

For fun, I made the views have a `xib` file although the project has been created with a `storyboard`, using [this technique](https://medium.com/@stevenpcurtis.sc/using-a-xib-file-with-a-uiview-subclass-d2180615391f).

Each of the following sections focus on the `LoginViewController` - `LoginViewModel` - `LoginView` sections of the App enclosed in the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/CombineURLSession), but similar ideas are sprinkled through the App as a whole.

## The Detail
**The View Controller**
`LoginViewController` is not substantially different from any `UIViewController` that you might write in `UIKit`. 

Initially I left the cancellable objects `AnyCancellable` as single vars in the project class. The reason that *any* of these exist is that a transaction may be cancelled when the token is `deinitialized` 
```swift
var pwSub: AnyCancellable?
var unSub: AnyCancellable?
var loginSub: AnyCancellable?
var animSub: AnyCancellable?
var validationSub: AnyCancellable?
```
whereas a better approach is to store these subscriptions
`private var subscriptions = Set<AnyCancellable>()`
perhaps in an array as shown above, and then the binding can be stored in the array:

```swift
loginViewModel?.shouldNav
    .sink(receiveCompletion: { completion in
    // Handle the error
        print ("completion\(completion)")
}) { [weak self] _ in
    let mvc = MainMenuViewController()
    self?.navigationController?.pushViewController(mvc, animated: true)
}.store(in: &subscriptions)
```

Noting that I've left the responsibility for navigation to the view controller (which informs the `navigationController`).

I've decided to create view model instances that conform to a protocol (indeed, the `UserDataManager()` does the same thing)

```swift
init(viewModel: LoginViewModelProtocol = LoginViewModel(
    networkManager: HTTPManager(session: URLSession.shared),
    userdatamanager: UserDataManager()
    )
)
{
    super.init(nibName: nil, bundle: nil)
    loginViewModel = viewModel
}
```

on the side of the view model we can bind to a `AnyPublisher<Bool, Never>` in a view model, and the view can be attached accordingly (here updating the `loginButton`).

```swift
let validationSub = loginViewModel?.userValidation
    .receive(on: RunLoop.main)
    .assign(to: \.isEnabled, on: loginView.loginButton)
```

likewise we can bind out `UITextField` to a `@Published var username: String = ""` which is situated in the view model.

```swift
loginView.userNameTextField.addTarget(self, action: #selector(self.userNameTextFieldDidChange(_:)), for: .editingChanged)
```

which of course links ot the selector as defined:

```swift
@objc func userNameTextFieldDidChange(_ sender: UITextField) {
    loginViewModel?.username = sender.text ?? ""
}
```

**The View Model**
The view model has two `@Published var` which creates a publisher of this type, which can then be accessed through use of the `$` operator. 

```swift
@Published var password: String = ""
@Published var username: String = ""
```

Now `validLengthUsername` is defined as the following, where `debounce` is used ensuring we only receive elements when the user pauses or stops typing. `removeDuplicates` ensures that only distinct elements are used.

```swift
@Published var username: String = ""
var validLengthUsername: AnyPublisher<Bool, Never> {
    return $username.debounce(for: 0.2, scheduler: RunLoop.main)
    .removeDuplicates()
    .map{$0.count >= passwordLength ? true : false}
    .eraseToAnyPublisher()
}
```

similarly we check the password

```swift
var validLengthPassword: AnyPublisher<Bool, Never> {
    return $password.debounce(for: 0.2, scheduler: RunLoop.main)
        .removeDuplicates()
        .map{$0.count >= passwordLength ? true : false}
        .eraseToAnyPublisher()
}
```

and both of these use `eraseToAnyPublisher` to make the `publisher` visible to the downstream `publisher`.

To combine the two, `.zip` is used to combine the two operators together, and that's an awesome.

```swift
var userValidation: AnyPublisher<Bool, Never> {
    validLengthUsername
        .zip(validLengthPassword)
        .map { $0 && $1 }
        .eraseToAnyPublisher()
}
```

of course this is subscribed to in the view controller (as shown above).

Now the `API` calls are made from this view model (actually upon the pressing of a button in the view controller)

```swift
func login() {
    pst = httpmgr?.post(url: API.login.url!,
                        headers: ["Content-Type": "application/x-www-form-urlencoded"],
                        data: "email=eve.holt@reqres.in&password=cityslicka".data(using: .utf8)!)
        .receive(on: DispatchQueue.main)
    
    publisher = pst!.sink(receiveCompletion: {
        switch $0 {
        case .finished: break
        case .failure(let error):
            // error should be handled here
            print (error)
        }
    }, receiveValue: {val in
        self.userdatamanager.token = val.token
        self.shouldNavSubject.send(true)
    })
}
```

This makes use of  `sink` in order to store the token in the keychain, and then send a message back to the view controller using `shouldNavSubject`. 

Now this `shouldNavSubject` is an `AnyPublisher<Bool, Never>`  that leverages `PassthroughSubject` which is an operator sitting in between a `Publisher` and `Subscriber`. 

```swift
private let shouldNavSubject = PassthroughSubject<Bool, Never>()
var shouldNav: AnyPublisher<Bool, Never> {
    shouldNavSubject.eraseToAnyPublisher()
}
```

**The HTTPManager**
Networking is taken care of by a `HTTPManager` as defined below, but the approach that is taken is much like my [basic network manager](https://medium.com/@stevenpcurtis.sc/my-basic-httpmanager-in-swift-db2be1e340c2) in that a `protocol` is used - and the `URLSession` can be swapped out during testing so when we make API calls they aren't actually hitting the `API` (in testing, of course)

```swift
class HTTPManager<T: URLSessionProtocol> {
    /// A URLProtocol instance that is replaced by the URLSession in production code
    
    let session: T
    
    required init(session: T) {
        self.session = session
    }

    public func post<T: Decodable>(
        url: URL,
        headers: [String : String],
        data: Data
    )
        -> AnyPublisher<T, Error>
    {
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 2.0)
        
        request.httpMethod = "Post"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        return session.response(for : request)
            .map { $0.data }
            .decode(type: T.self,
                    decoder: JSONDecoder())
            .mapError{ $0 }
            .eraseToAnyPublisher()
    }
}
```

The protocol?

```swift
protocol HTTPManagerProtocol {
    associatedtype aType
    var session: aType { get }
    init(session: aType)
    
    func post<T: Decodable>(
        url: URL,
        headers: [String : String],
        data: Data
    )
        -> AnyPublisher<T, Error>
}
```

We can come onto the testing later in this article. 

Since we are using that `URLSession` that is replaceable during testing. This is quite tricky when using `dataTaskPublisher` - here is the approach to obtain the correct `Output` and `Failure` types by creating a `protocol` that we  get `URLSession`  to conform to, creating a `typealias` that can be returned by the actual class or the mocked version.

```swift
protocol URLSessionProtocol {
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    func response(for request: URLRequest) -> AnyPublisher<APIResponse, URLError>
}

extension URLSession: URLSessionProtocol {
    func response(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
```

## Testing
As has been mentioned above, we can mock `URLSession` 

```swift
class URLSessionMock: URLSessionProtocol {
    var jsonName = "RegisterSuccess.json"
    func response(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let file = Bundle(for: type(of: self)).path(forResource: jsonName, ofType: nil)!

        let url = URL(fileURLWithPath: file)
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }

    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    // data and error can be set to provide data or an error
    var data: Data?
    var error: Error?
}
```

which can then be used by a mocked `HTTPManager`

```swift
class HTTPManagerMock <T: URLSessionProtocol>: HTTPManagerProtocol {
    let session: T

    required init(session: T) {
      self.session = session
    }
    
    func post<T>(url: URL, headers: [String : String], data: Data) -> AnyPublisher<T, Error> where T: Decodable {
        
        var request = URLRequest(
            url: URL(string: "www.fakeweb.com")!,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 2.0)
        
        request.httpMethod = "Post"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        // let session = URLSessionMock()
        return session.response(for: request)
            .map { $0.data }
            .decode(type: T.self,
                    decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
```

This is then setup in the test classes themselves since we can setup 

```swift
var lvm: LoginViewModel<HTTPManagerMock<URLSessionMock>>?
let urlSession = URLSessionMock()
let nm = HTTPManagerMock(session: urlSession)
let ud = UserDataManagerMock()
lvm = LoginViewModel(networkManager: nm, userdatamanager: ud)
private var cancellables: Set<AnyCancellable> = []
```

adding a test 

```swift
let expect = expectation(description: #function)
lvm?.password = "test"
lvm?.validLengthPassword.sink(receiveValue: {res in
    XCTAssertEqual(res, false)
    expect.fulfill()
}).store(in: &cancellables)
waitForExpectations(timeout: 2.0)
```

Which means, crucially, that we don't use a real API call to get data during testing and instead we get the data from a `json` file in the test target - that's a good job all round.

# Conclusion
This article is a rather useful implementation of `Combine` using `UIKit`, we can see this in this article. 

It is rather complex in the description, but rather easy in the implementation. Take a look at the  attached [Repo](https://github.com/stevencurtis/SwiftCoding/tree/master/CombineURLSession). It is a rather wonderful thing.

People do like [Apple's documentation](https://developer.apple.com/documentation/combine) on this topic. 

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
