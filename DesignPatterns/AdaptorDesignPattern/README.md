# The Adapter Design Pattern in Swift
## Collaborate together!


![Photo by Lopez Robin](Images/photo-1519741347686-c1e0aadf4611.jpeg)<br/>
<sub>Photo by Lopez Robin<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.5, and Swift 5.2.4

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* This article references use of the [Playground](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089), although you could translate the tests to that Single View Application

# Terminology:
Adapter Pattern: allows the interface of an existing class to be used as another interface
Design Pattern: a general, reusable solution to a commonly occurring problem

Adapters allow one thing to work with another, like when a European electrical applicance needs to be used in the Americas (you would need to change the pins and the voltage to enable the appliance to work). 

In software engineering the adapter pattern allows the interface of an existing class to be used as another interface.

# The Adapter Design Pattern in Swift
There are several approaches that we can take to make sure that a subsystem has an appropriate interface using adaptors.

To set up this project I've created a new `Playground` and, to work as some sort of [TDD](https://medium.com/@stevenpcurtis.sc/test-driven-development-tdd-in-swift-b903b31598b6) advocate I'm going to start with the tests (remembering to use `defaultTestSuite`, and specifically for this playground the line `AdapterTests.defaultTestSuite.run()` at the end of the Playgroud to run the tests):

```swift
class AdapterTests: XCTestCase {
    var network: ReturnRequest?
    var database: ReturnRequest?
    
    override func setUpWithError() throws {
        network = Network()
        database = Database()
    }

    func testNetworkRequest() {
        XCTAssertEqual(network?.request(), "Network request")
    }
    
    func testDatabaseRequest() {
        XCTAssertEqual(database?.request(), "Database request")
    }
}
```

So we are planning to make requests from both a network, and a database and treat them in the same way. The issue is that we already have a [protocol](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18) in place, and we use this to access the `Network` request:

```swift
protocol ReturnRequest {
    func request() -> String
}

class Network: ReturnRequest {
    func request() -> String {
        return "Network request"
    }
}

class Database {
    func fetch() -> String {
        return "Database request"
    }
}
```

The problem is that the database can't simply conform to the `ReturnRequest` - this is because the `Database` fetches rather than returns a request. 

Now the solution of whacking the functionality right into the `Database` is slightly disappointing - changing the functionality of an object to conform to a protocol? It's not great.

**The poor solution**

```swift
protocol ReturnRequest {
    func request() -> String
}

class Network: ReturnRequest {
    func request() -> String {
        return "Network request"
    }
}

class Database {
    func fetch() -> String {
        return "Database request"
    }
}
```

The answer? Whack it into an extension! This is the *Adaptor* pattern in use!

## Extension
This extension adds functionality to the Database, which represents the adaptor pattern as essentially we are just returning the results of the fetch in the form required by the protocol

```swift
extension Database: ReturnRequest {
    func request() -> String {
        return fetch()
    }
}
```

## The alternatives
Adaptors just make one thing work with another. We can create a class to perform this function, and then use the adaptor rather than the original class.

```swift
class DatabaseAdaptor: ReturnRequest {
    private let database = Database()
    func request() -> String {
        return database.fetch()
    }
}
```

Now `DatabaseAdaptor` can be used in place of the database, so let us look at the completed `Playground` with the minor differences that are made to the Playground in order to get this running:

```swift
protocol ReturnRequest {
    func request() -> String
}

class Network: ReturnRequest {
    func request() -> String {
        return "Network request"
    }
}

class Database {
    func fetch() -> String {
        return "Database request"
    }
}

class DatabaseAdaptor: ReturnRequest {
    private let database = Database()
    func request() -> String {
        return database.fetch()
    }
}

class AdapterTests: XCTestCase {
    var network: ReturnRequest?
    var database: ReturnRequest?
    
    override func setUpWithError() throws {
        network = Network()
        database = DatabaseAdaptor()
    }

    func testNetworkRequest() {
        XCTAssertEqual(network?.request(), "Network request")
    }
    
    func testDatabaseRequest() {
        XCTAssertEqual(database?.request(), "Database request")
    }
}

AdapterTests.defaultTestSuite.run()
```

Unsurprisingly enough, the tests now pass!

## The practical example in Swift
When I previously wrote an article to cover [OperationQueue](https://stevenpcurtis.medium.com/use-operationqueue-to-chain-api-calls-in-swift-71eefd6891ef) an adapter links properties for `dataFetched` and `error`.

```swift
let adapterList = BlockOperation() { [unowned fetchList, unowned parseList] in
    parseList.dataFetched = fetchList.dataFetched
    parseList.error = fetchList.error
}
```

So all operations can be used together. **nice**

# Conclusion
The adaptor design pattern is one of the more useful ones that you will come across in Swift. This is because we are often coding to an interface when coding to a protocol - and the adaptor patter will help us to rather connect things together.

This is a really important thing to do: get things to work together.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
