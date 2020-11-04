# Write a Network Layer in Swift
## Or just take mine.
![Image by C Dustin](Images/photo-1569428034239-f9565e32e224.jpeg)
<sub>Photo <sub>

I previously produced a [network manager](https://github.com/stevencurtis/NetworkManager). This article explains it. Good oh!

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.0, and Swift 5.3

## Prerequisites:
- it would be easier if you knew something about [type erasure](https://github.com/stevencurtis/SwiftCoding/tree/master/TypeErasure)
- To install the network manager to which this refers, you will need to know something about [Swift Package Manager](https://github.com/stevencurtis/SwiftCoding/tree/master/AlamofireNetworking)

## Terminology:
Type Erasure: Removing type information by wrapping a type

## The public API
There are two entry points for this network manager - both `AnyNetworkManager` and `NetworkManager` are publicly accessible.  Not only that - there is a `MockNetworkManager` that is publically avaliable for testing.

Let us first look at **NetworkManager**. Let us take a look at the exposed protocol:

```swift
public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }
    func cancel()
    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String: Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void)
}

public extension NetworkManagerProtocol {
    func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, data: [String: Any]? = nil, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetch(url: url, method: method, headers: headers, token: token, data: data, completionBlock: completionBlock)
    }
}
```

The extension allows us to have [default arguments](https://medium.com/@stevenpcurtis.sc/overcoming-default-arguments-in-a-protocol-27427b9ed275) , and the [associated type](https://medium.com/@stevenpcurtis.sc/protocols-with-associated-types-in-swift-eec850af3c02) has it's own article.

We can then access the network manager using a token, header and data:
```swift
        let urlSession = MockURLSession()
        let networkManager = NetworkManager(session: urlSession!)
        let expectation = XCTestExpectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, data: nil, completionBlock: { result in
            switch result {
            case .success(let data):
                // do something with data
            case .failure(let error):
                // do something with error
            }
        })
```

or without  those parameters

```swift
        let urlSession = MockURLSession()
        let networkManager = NetworkManager(session: urlSession!)
        let expectation = XCTestExpectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get, 
        completionBlock: { result in
            switch result {
            case .success(let data):
                // do something with data
            case .failure(let error):
                // do something with error
            }
        })
```

As we can see this is using a `MockURLSession` to ensure that we are not using the actual `URLSession` with our network manager - ensuring that we will never actually make network calls using the (well...) network - but using the following `MockURLSession` (which in turn has associated types and it's own `MockURLSessionDataTask`)

```swift
class MockURLSession: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    // data and error can be set to provide data or an error
    var data: Data?
    var error: Error?

    func dataTask(with request: URLRequest,
                  completionHandler:
        @escaping (Data?, URLResponse?, Error?) -> Void) ->
        MockURLSessionDataTask {
            let data = self.data
            let error = self.error
            let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!

            return MockURLSessionDataTask {
                completionHandler(data, response, error)
            }
    }

    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
        ) -> MockURLSessionDataTask {
        let data = self.data
        let error = self.error
        return MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
    }
}
```

Usually I would prefer to use the following `AnyNetworkManager` which it the `type erased` version - with the advantage that we can save the type in something like the following:

```swift
private var networkManager: AnyNetworkManager<URLSession>?
required init<T: NetworkManagerProtocol>(networkManager: T) {
        self.networkManager = AnyNetworkManager(manager: networkManager)
}
```

which means that we don't have to add an associated type into the containing class! This is great!

So let us look at the `AnyNetworkManager`, which of course also conforms to `NetworkManagerProtocol`.

```swift
public class AnyNetworkManager<U: URLSessionProtocol>: NetworkManagerProtocol {
    public let session: U
    let fetchClosure: (URL, HTTPMethod, [String : String], String?, [String : Any]?, @escaping (Result<Data, Error>) -> Void) -> ()
    let cancelClosure: ()
    public func cancel() {
        cancelClosure
    }
    public init<T: NetworkManagerProtocol>(manager: T) {
        fetchClosure = manager.fetch
        session = manager.session as! U
        cancelClosure = manager.cancel()
    }
    public convenience init() {
        let manager = NetworkManager<URLSession>(session: URLSession.shared)
        self.init(manager: manager)
    }
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, data: [String: Any]? = nil, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetchClosure(url, method, headers, token, data, completionBlock)
    }
}
```

We can see that `AnyNetworkManager` has an associated type which is the `URLSession` (that itself conforms to the `URLSessionProtocol`). Essentially we store the functions that the `NetworkManager` can call as closures, and then call them when we are required to.

Now when we test we can slot a `MockNetworkManager` right into the `AnyNetworkManager` which is defined as follows:

```swift
public class MockNetworkManager <T: URLSessionProtocol>: NetworkManagerProtocol {
    public func cancel() { }
    public var outputData = "".data(using: .utf8)
    public var willSucceed = true
    public var didFetch = false
    public let session: T

    public required init(session: T) {
      self.session = session
    }
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String : Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        didFetch = true
        if let dta = outputData {
            if willSucceed {
                completionBlock(.success(dta))
            } else {
                completionBlock(.failure(ErrorModel(errorDescription: "Error from Mock HTTPManager")))
            }
        }
    }
}
```

Note that we can instantiate the actual `URLSession` into the `MockNetworkManager` as we never actually try to make any network calls!

Here is what a test might look like:

```swift
func testSuccessfulGetURLResponse() {
    let urlSession = MockURLSession()
    let data = Data("TEsts12".utf8)
    let urlSession?.data = data
    let networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
    let expect = expectation(description: #function)
    let url = URL(fileURLWithPath: "http://www.google.com")
    
    networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, data: nil, completionBlock: { result in
        XCTAssertNotNil(result)
        switch result {
        case .success(let data):
            let decodedString = String(decoding: data, as: UTF8.self)
            XCTAssertEqual(decodedString, "TEsts12")
            expect.fulfill()
        case .failure:
            XCTFail()
        }
    })
    waitForExpectations(timeout: 3.0)
}
```
we can even swap out the data that the mock network will output! That is rather awesome!

## Using tests
In order to test the network manager, the package can be downloaded and ⌘-U will run the tests.

# Conclusion
Want to look at the whole thing? [network manager](https://github.com/stevencurtis/NetworkManager) has the whole thing, tests an all.

Want to use it? Download it and off you go!

I'm now using this in many of my articles: rather than explaining the working of the network 
 
 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 