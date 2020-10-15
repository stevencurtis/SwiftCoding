# Cache URLResponses in Swift
## We don't want to preload every ViewModel!

![Photo](Images/elizabeth-lies-PIQCA1ReSgU-unsplash.jpg)<br/>
<sub>Photo <sub>


Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.7, and Swift 5.2.4

## Prerequisites: 
* You will be expected to make a [Single View Swift Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)
* This code is built on my [network manager](https://github.com/stevencurtis/NetworkManager), which you can download and use for free
* This involves subscripts that I'm covered in [Create your own subscript](https://medium.com/@stevenpcurtis.sc/your-own-subscript-in-swift-5ac0a87410af)
* This code uses [Singletons](https://medium.com/@stevenpcurtis.sc/singleton-in-swift-8da9bea06339)

## Terminology
Cache: a collection of items of the same type stored

# The motivation
Alamofire has a cache. Surely I can make a simlar feature for my own Network manager? (Spoiler: Yes, yes I can).

This allows use of [dependency injection](https://medium.com/@stevenpcurtis.sc/learning-dependency-injection-using-swift-c94183742187) and provides us with a suitable way of testing our code. That is great!

Note that I've left print logging in the code that I've checked in, this is so we can see when data is stored and used from the cache by looking at the console. You wouldn't want to do that in production code (so please don't!)

## Coding to an interface
In order to code to an interface you will need to use a [protocol](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18) which the classes we create will conform to.

That protocol can be the following:

```swift
protocol CacheManagerProtocol {
    func fetchDataFromCache(request: URLRequest, completion: ((Data?)-> ()))
    func storeDataToCache(request: URLRequest, data: Data)
    subscript(request: URLRequest) -> Data? { get set }
}
```

Now the reason for doing this is to create a mock that we can later swap out during tests - for my rather basic tests I'm not concerted about the subscript returning Data, for more complex tests this would need to be filled in.

```swift
class MockCacheManager: CacheManagerProtocol {
    subscript(request: URLRequest) -> Data? {
        get {
            return nil
        }
        set(newValue) {
            // fill in if required
        }
    }
    
    func fetchDataFromCache(request: URLRequest, completion: ((Data?) -> ())) {
        if willReturn {
            completion(fetchData)
        } else {
            completion(nil)
        }
    }
    
    func storeDataToCache(request: URLRequest, data: Data) {
    }
    
    var cache: [URL: Data] = [:]
    var fetchData: Data?
    var willReturn: Bool = true
    public static var shared: CacheManagerProtocol! = MockCacheManager()
}
```

speaking of **tests**, we can think of creating those to test whether the data can be restored from the cache, and this may be something like the following:

```swift
    func testCache() {
        let expect = expectation(description: #function)
        let cache = CacheManagerNSCache.shared
        let data = Data("TEsts12".utf8)
        let url = URL(string: "www.testurl.com")
        let request = URLRequest(url: url!)
        cache.storeDataToCache(request: request, data: data)
        cache.fetchDataFromCache(request: request, completion: { returnedData in
            XCTAssertEqual(data, returnedData)
            expect.fulfill()
        })
        waitForExpectations(timeout: 3.0)
    }
```

If we get the data from the cache or from the Network the code shouldn't care. I've produced two different tests to demonstrate this:

```swift
    var urlSession: MockURLSession?
    var networkManager: NetworkManager<MockURLSession>?
    
    func testGetMethodNoBodyCacheReturns() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        let cacheManager = MockCacheManager()
        cacheManager.willReturn = true
        cacheManager.fetchData = Data("TEsts12".utf8)
        networkManager = NetworkManager(session: urlSession!, cacheManager: cacheManager)
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, completionBlock: { result in
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
    
    func testGetMethodNoBodyCacheNotReturns() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        let cacheManager = MockCacheManager()
        cacheManager.willReturn = false
        networkManager = NetworkManager(session: urlSession!, cacheManager: cacheManager)
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, completionBlock: { result in
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

So in the first test the data comes from the cache - and we check that the network manager returns that data (it does), in the second test the data comes from the network, and once again all is fine (which is great!

## The altered Network Manager

The heart of this code is the following Network Manager:
```swift
/// Errors that will be generated by the NetworkManager
public enum NetworkError: Error, Equatable {
    case bodyInGet
    case invalidURL
    case noInternet
    case invalidResponse(Data?, URLResponse?)
    case accessForbidden
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
    
    var cacheManager: CacheManagerProtocol
    
    required init(session: T, cacheManager: CacheManagerProtocol = CacheManager.shared) {
        self.session = session
        self.cacheManager = cacheManager
    }
    
        public func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, data: [String: Any]? = nil, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        // make network request
        if method == .get {
            guard data == nil else {
                completionBlock(.failure(NetworkError.bodyInGet))
                return
            }
        }
        
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
                completionBlock(.failure( ErrorModel(errorDescription: "Could not serialize data") ))
            }
            request.httpBody = serializedData
        }
        
                print ("subscript", cacheManager[request] )
        
        cacheManager.fetchDataFromCache(request: request, completion: { [weak self] data in
            
            if let data = data {
                print ("return from cache")
                completionBlock(.success(data))
                return
            }
            
            print ("make data call")


            let task = session.dataTask(with: request) { data, response, error in

                guard error == nil else {
                    completionBlock(.failure(error!))
                    return
                }
                guard
                    let _ = data,
                    let httpResponse = response as? HTTPURLResponse,
                    200 ..< 300 ~= httpResponse.statusCode else {
                        if let data = data {
                        	                            completionBlock(.success(data))
                        } else {
                            completionBlock(.failure(NetworkError.invalidResponse(data, response)))
                        }
                        return
                }
                // if passed guard
                if let data = data {
                    completionBlock(.success(data))
                    self?.cacheManager.storeDataToCache(request: request, data: data)
                }
            }
            task.resume()
            
            }
        )
    }
}
```

Now when this is called from the code, I'd say it calls it as **normal** from my network manager code, which is something like the following:

```swift
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        self.networkManager?.fetch(url: url, method: .get, completionBlock: { response in
        ...
```

Which of course uses a [force-unwrap which you shouldn't do in production code](https://medium.com/@stevenpcurtis.sc/avoiding-force-unwrapping-in-swift-6dae252e970e) but then you can deal with the response as you might well usually do.

The whole code is in the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/CacheResponses), which should answer the many implementation details that you would like to confirm with me


# Conclusion
The approach taken loosely follows MVVM and I've whacked a few tests in there too. I hope this is of use to those reading.

Swapping out implementation details using dependency injection is really important 
 
 In any case, have a nice day.
 
 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 