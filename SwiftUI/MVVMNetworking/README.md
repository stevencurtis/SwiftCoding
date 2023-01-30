# SwiftUI MVVM with networking
## It can't be that hard!


Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 12.1, and Swift 5.3

If you want to develop any sort of `SwiftUI` application you 

## Prerequisites: 
* You will be expected to make a [Single View SwiftUI Application](https://medium.com/@stevenpcurtis.sc/hello-world-swiftui-92bcf48a62d3) in Swift.

## Terminology
SwiftUI: A simple way to build user interfaces Across Apple platforms

# The motivation
You will need to create nicely featured Apps. They are going to (probably) make network calls. This means that you need to develop an architecture that is going to support this in your development. 

Let's go `MVVM`!

## The basic architecture
The Main view (which I've creatively called `ContentView`) is instantiated with a view model which is creatively called `ContentViewModel`.

Therefore in the `SceneDelegate` contentView is created with `let contentView = ContentView(viewModel: ContentViewModel())`.

My `ContentView` isn't going to do anything in this case, apart from creating a reference to the view model

```swift
struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users, id: \.self) {
                    user in
                    
                    Text("\(user.title)")
                }
            }
            .navigationBarTitle("User")
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
```

We are going to have the following view model

```swift
class ContentViewModel: ObservableObject {
    @Published var users: [User] = []
    var res: AnyCancellable?
    private var networkManager: AnyNetworkManager<URLSession>?
    
    init() {
        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
        
        res = networkManager?.fetch(url: URL(string: "https://jsonplaceholder.typicode.com/posts/1")!, method: .get)
            .sink(receiveCompletion: {comp in
                print (comp)},
                  receiveValue: {
                    val in
                    let decode = JSONDecoder()
                    let decoded = try? decode.decode(User.self, from: val)
                    self.users = [decoded!]
            })
    }
}
```

Yes! This is all very basic and not production-ready. But that isn't the point of this article rally though (is it?)

Oh yes, we are decoding a basic user:
```swift
public struct User: Codable, Hashable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
```

## The network call
This is using a rather nifty network manager, which uses Type Erasure to wrap the `Network Manager` which unfortunately has a associated type requirement which (if we want to store the Network Manager) means the owning class would need to be generic - and we are risking having generic classes everywhere within our code. 

To avoid that we  structure our `Network Manager` covers the following

**AnyNetworkManager**
```swift
public class AnyNetworkManager<U: URLSessionProtocol>: NetworkManagerProtocol {
    public let session: U
    
    let fetchClosure: (URL, HTTPMethod, [String : String], String?, [String : Any]?) -> AnyPublisher<Data, NetworkError>
    
    public init<T: NetworkManagerProtocol>(manager: T) {
        fetchClosure = manager.fetch
        session = manager.session as! U
    }
        
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, data: [String: Any]? = nil) -> AnyPublisher<Data, NetworkError> {
        fetchClosure(url, method, headers, token, data)
    }
}
```

**NetworkManager**
(Also containing a couple of `enum`)
```swift
public enum NetworkError: Error, Equatable {
    case bodyInGet
    case invalidURL
    case noInternet
    case invalidResponse(Data?, URLResponse?)
    case accessForbidden
    case unknown
    case httpError(Int)
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public class NetworkManager<T: URLSessionProtocol> {
    public let session: T
    
    public required init(session: T) {
        self.session = session
    }
    
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, data: [String: Any]? = nil) -> AnyPublisher<Data, NetworkError> {
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        if let bearerToken = token {
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        }
        if let data = data {
            var serializedData: Data?
            do {
                serializedData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            } catch {
                return Fail(error: NetworkError.bodyInGet)
                    .eraseToAnyPublisher()
            }
            request.httpBody = serializedData
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<Data, NetworkError> in
                if let response = response as? HTTPURLResponse {
                    /// successful responses
                    if (200..<300).contains(response.statusCode) {
                        return Just(data)
                            .mapError {_ in
                                // no matter the error return our NetworkError
                                .unknown}
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: NetworkError.httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: NetworkError.httpError( (response as? HTTPURLResponse)?.statusCode ?? 0 ))
                    .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
```

**NetworkManagerProtocol**
```swift
public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }

    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String: Any]?) -> AnyPublisher<Data, NetworkError>
}

extension NetworkManagerProtocol {
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String?, data: [String: Any]?) -> AnyPublisher<Data, NetworkError> {
        return fetch(url: url, method: method, headers: headers, token: token, data: data)
    }
}
```

**URLSessionDataTaskProtocol**
```swift
public protocol URLSessionDataTaskProtocol {
    func resume()
}
```

**URLSessionProtocol**
```swift
public protocol URLSessionProtocol {
    associatedtype dataTaskProtocolType: URLSessionDataTaskProtocol
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
    func dataTaskPublisher(for: URLRequest) -> URLSession.DataTaskPublisher
    func dataTaskPublisher(for: URL) -> URLSession.DataTaskPublisher
}
```

**With the following extensions**
```swift
extension URLSession: URLSessionProtocol {}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension NetworkManager: NetworkManagerProtocol {}
```


# Conclusion

This is an interesting experiment that has led us to having a working network call from a view model.

Good stuff indeed!

Well done to all involved etc.

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
