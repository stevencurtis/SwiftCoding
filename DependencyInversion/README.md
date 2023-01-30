# Dependency Inversion - A Swift guide
## A quite basic guide

![](Images/test.jpeg)<br/>
<sub>Photo by <sub>

A demonstration of dependency inversion using Swift

Difficulty: Beginner | Easy | **Normal** | Challenging
This article has been developed using Xcode 12.0, and Swift 5.3

# Terminology:
Dependency Injection: A technique that allows objects to receive other objects on which it depends
Dependency Inversion: A principle that allows the decoupling of software modules
Inversion of Control: A design pattern that allows code to conform to the Dependency Inversion principle

# Prerequisites:
- You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), or a [Playground](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to run Swift code
- I'd recommend that you have a working knowledge of [Dependency Injection](https://medium.com/@stevenpcurtis.sc/learning-dependency-injection-using-swift-c94183742187)

# Dependency injection vs. dependency inversion
Dependency Injection is a technique for supplying dependencies to a class, that is it is a technique that enables **Inversion of Control** by passing dependencies through a constructor, property or other method.

Dependency Inversion is a principle (and is therefore also known as the Dependency Inversion Principle or DIP) that revolves around de-coupling a class from it's concrete dependencies.

This means that dependency injection is technique to apply the principle of dependency inversion.

# The principles of The Dependency Inversion Principle (DIP)
- High-level modules should not depend on low-level modules. Both should depend on abstractions
- Abstractions should not depend on details. Details should depend upon abstractions
 
# Inversion of Control
This design pattern is a design pattern used to design loosely coupled classes in a testable, maintainable and extensible way. There are many concrete solutions for Inversion of Control (IoC) ServiceLocator, Event, Delegate, and of course Dependency Injection.

# The advantages of the The Dependency Inversion Principle (DIP)
Dependency Inversion can make code easier to maintain in terms of bug fixes and enhancements. 

# The disadvantages of the The Dependency Inversion Principle (DIP)
It can be said that adding levels of abstraction impacts the readability of code, and increases the complexity of any given App.

# A basic example
We have a user `struct` ([`Decodable`](https://medium.com/@stevenpcurtis.sc/decode-json-with-swift-and-test-it-e2d26dfafd6d) of course) and we want to store this in a database that can (of course!) Create, Retrieve, Update and Delete records [known as CRUD](https://medium.com/@stevenpcurtis.sc/rest-and-crud-ca5522bf3fc3).

Now in this artificial demonstration we won't actually perform these operations.

```swift
class Database {
    func create(_ name: String) {}
    func insert(_ user: User) {}
    func update(_ user: User) {}
    func delete(_userID: String) {}
    required init() {}
}

struct User: Decodable {
    let name: String
    let id: String
}


class UserTransaction {
    private let dataBase: Database
    
    init(dataBase: Database) {
        self.dataBase = dataBase
    }
    
    func add(user: User) {
        dataBase.insert(user)
    }
    
    func edit(user: User) {
        dataBase.update(user)
    }
    
    func delete(id: String) {
        dataBase.delete(_userID: id)
    }
}


let db = Database()
let userTransaction = UserTransaction(dataBase: db)
```

This seems fine, but in practice the `Database` is tightly coupled to the `UserTransaction` class. This means that the high-level module (`UserTransaction`) depends on the low-level model. This doesn't follow the Dependency Inversion Principle!

We can therefore fix this by using a [Protocol](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18), that is we will ensure that our Database conforms to a protocol.

```swift
class Database: DatabaseManager {
    func create(_ name: String) {}
    func insert(_ user: User) {}
    func update(_ user: User) {}
    func delete(_userID: String) {}
    required init() {}
}

protocol DatabaseManager {
    func create(_ name: String)
    func insert(_ user: User)
    func update(_ user: User)
    func delete(_userID: String)
    init()
}

struct User: Decodable {
    let name: String
    let id: String
}


class UserTransaction {
    private let dataBase: DatabaseManager
    
    init(dataBase: DatabaseManager) {
        self.dataBase = dataBase
    }
    
    func add(user: User) {
        dataBase.insert(user)
    }
    
    func edit(user: User) {
        dataBase.update(user)
    }
    
    func delete(id: String) {
        dataBase.delete(_userID: id)
    }
}

let db = Database()
let userTransaction = UserTransaction(dataBase: db)
```

which then has the advantage that we can inject a mock of the database into `UserTransaction`

```swift
class MockDatabase: DatabaseManager {
    func create(_ name: String) {}
    func insert(_ user: User) {}
    func update(_ user: User) {}
    func delete(_userID: String) {}
    required init() {}
}
```
which can then be added in to the `UserTransaction` - usually done through a test.

```swift
let db = MockDatabase()
let userTransaction = UserTransaction(dataBase: db)
```

# A real example
I've been a big fan of using a networking layer which implements **Inversion of Control** through dependency injection. This in fact has extra layers of abstraction since it leverages [Type Erasure](https://medium.com/@stevenpcurtis.sc/type-erasure-in-swift-8c109cbdd469) and the full code is available in the following 
[Repo](https://github.com/stevencurtis/SwiftCoding/tree/master/DependencyInversion).

However despite this complexity, it is still a valid example to look at.

The "outer" protocol which is `AnyNetworkManager` uses type erasure to mean that we don't need to store the associated type in the containing class. 

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
        
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, data: [String: Any]? = nil, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetchClosure(url, method, headers, token, data, completionBlock)
    }
}
```

This of course accepts any network manager that conforms to the `NetworkManagerProtocol`, which can be defined as follows (using the rather tricky associated type

```swift
public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }
    func cancel()
    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String: Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void)
}

extension NetworkManagerProtocol {
    func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String?, data: [String: Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetch(url: url, method: method, headers: headers, token: token, data: data, completionBlock: completionBlock)
    }
}
```

where the point is that we can use any network manager - that is a mock is perfectly acceptable which does not need to use the usual `URLSession` and therefore a test does not need to use the network (speeding our testing, and avoiding hitting our backend with test requests at any given time).

This can be expressed with a `MockNetworkManager` that can be expressed as follows (and which always produces the data that would make up an empty String.

```swift
public class MockNetworkManager <T: URLSessionProtocol>: NetworkManagerProtocol {
    public func cancel() { }
    
    var outputData = emptyString.data(using: .utf8)
    var willSucceed = true
    public let session: T

    required init(session: T) {
      self.session = session
    }
    
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String : Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void) {
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

since MockNetworkManager does not use URLSession (injected) to create it's response we can use this while testing this viewmodel:

```swift
class ViewModel {
    private var anyNetworkManager: AnyNetworkManager<URLSession>?

    var resultClosure: ((Data) -> ())?
    init<T: NetworkManagerProtocol> (
        networkManager: T
    ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
    }
    
    func fetch() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        anyNetworkManager?.fetch(url: url, method: .get, completionBlock: { [weak self] data in
            switch data {
            case .success(let data):
                self?.resultClosure?(data)
            case .failure:
                break
            }
        })
    }
}
```

Which we can then test using the following:

```swift
class ViewModelTests: XCTestCase {
    func testViewModel() {
        let mockNetworkManager = MockNetworkManager(session: URLSession.shared)
        let vm = ViewModel(networkManager: mockNetworkManager)
        var resultData: Data?
        vm.resultClosure = { result in
            resultData = result
        }
        vm.fetch()
        XCTAssertNotNil(resultData)
    }
}
```

# Conclusion

Dependency Inversion is really important, and here we have introduced a protocol abstraction between the high-level and low-level components in our modules.

Useful? I rather hope so.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)

