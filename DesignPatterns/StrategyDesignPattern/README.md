# Strategy Design in Swift
## Select an algorithm at runtime

![Photo by Erik Mclean](Images/photo-1553481187-be93c21490a9.jpeg)<br/>
<sub>Photo by Erik Mclean<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.5, and Swift 5.2.4

Instead of simply implementing an algorithm, code receives run-times instructions to as to which algorithms to use. 

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

# Terminology:
Design Pattern: a general, reusable solution to a commonly occurring problem

# The Simple Example
There are several different methods of [logging in Swift](https://stevenpcurtis.medium.com/logging-in-swift-d9b59146ff00).

Now what if we could switch the method of logging?

It turns out that we can do just that!

```swift
protocol LoggerProtocol {
    func log(_ message: String)
}

func use(logger: LoggerProtocol, with message: String) {
    logger.log(message)
}

struct PrintLogger: LoggerProtocol {
    func log(_ message: String) {
        print("The function \(#function) received \(message)")
    }
}

struct NSLogLogger: LoggerProtocol {
    func log(_ message: String) {
        NSLog ("Received %@", message)
    }
}

var printLogger = PrintLogger()
printLogger.log("Print Log")

var nsLogger = NSLogLogger()
nsLogger.log("print log using CSLog")
```

This then outputs the following:

```swift
The function log(_:) received Print Log
Logging[15805:363573] Received print log using CSLog
```

# A real example
I have an example where the same principles are used.

I implemented an [SQLiteManager](https://youtu.be/qVu0ow0mats) that shows how a wrapper can be used to make sure that the use of the database doesn't render code untestable.

This opens up our code to having a **repeatable** set of tests - where we can swap out implementation to prevent having to us a concrete database .

An approach to creating this wrapper and using it includes the mock as defined here:

```swift
@testable import SQLiteManager
import SQLite3

class MockSqlite3Wrapper: Sqlite3WrapperProtocol {
    
    var columns = 0
    
    var outputStrings: [[String]] = [["1", "Hello", "World"], ["2", "a", "b"], ["3", "c", "d"]]

    func sqlite3_column_text(_ op: OpaquePointer!, _ iCol: Int32) -> UnsafePointer<UInt8>! {
        if columns < 3 {
            let outputString = outputStrings[counter][columns]
            let data = outputString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            let dataMutablePointer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
            data.copyBytes(to: dataMutablePointer, count: data.count)
            let dataPointer = UnsafePointer<UInt8>(dataMutablePointer)
            columns += 1
            return dataPointer
        }
        columns = 0
        return nil
    }
    
        struct MockSqliteRun {
        var close: Bool = false
        var finalize: Bool = false
        var step: Bool = false
        var open: Bool = false
        var prepare: Bool = false
        var column: Bool = false
        var bindInt: Bool = false
        var bindText: [String] = []
    }
    
        
    var whichRun: MockSqliteRun = MockSqliteRun()
    func sqlite3_close(_ pointer: OpaquePointer!) -> Int32 {
        whichRun.close = true
        return 0
    }
    
    func sqlite3_finalize(_ pStmt: OpaquePointer!) -> Int32 {
        whichRun.finalize = true
        return 0
    }
    
    var counter = -1
    var stepdone = false
    
        func sqlite3_step(_ pointer: OpaquePointer!) -> Int32 {
        whichRun.step = true
        if (stepdone) {return SQLITE_DONE}
        if counter < 1 {
            counter += 1
            return SQLITE_ROW
        }
        return SQLITE_DONE
    }
    
        func sqlite3_open_v2(_ filename: UnsafePointer<Int8>!, _ ppDb: UnsafeMutablePointer<OpaquePointer?>!, _ flags: Int32, _ zVfs: UnsafePointer<Int8>!) -> Int32 {
        // in order to pass out the reference to the db
        SQLite3.sqlite3_open_v2(filename, ppDb, flags, zVfs)
        whichRun.open = true
        return 0
    }
    
    func sqlite3_prepare_v2(_ db: OpaquePointer!, _ zSql: UnsafePointer<Int8>!, _ nByte: Int32, _ ppStmt: UnsafeMutablePointer<OpaquePointer?>!, _ pzTail: UnsafeMutablePointer<UnsafePointer<Int8>?>!) -> Int32 {
        whichRun.prepare = true
        SQLite3.sqlite3_prepare_v2(db, zSql, nByte, ppStmt, pzTail)
        return SQLITE_OK
    }
    
        func sqlite3_column_int(_ oP: OpaquePointer!, _ iCol: Int32) -> Int32 {
        whichRun.column = true
        return 0
    }
    
    func sqlite3_bind_int(_ oP: OpaquePointer!, _ first: Int32, _ second: Int32) -> Int32 {
        whichRun.bindInt = true
        return SQLITE_OK
    }
    
    func sqlite3_bind_text(_ oP: OpaquePointer!, _ first: Int32, _ second: UnsafePointer<Int8>!, _ third: Int32, _ ptrs: (@convention(c) (UnsafeMutableRawPointer?) -> Void)!) -> Int32 {
        whichRun.bindText.append( String(cString: second) )
        return SQLITE_OK
    }   
}   
```

which of course conforms to the following protocol:

```swift
public protocol Sqlite3WrapperProtocol {
    @discardableResult
    func sqlite3_close(_ pointer: OpaquePointer!) -> Int32
    @discardableResult
    func sqlite3_finalize(_ pStmt: OpaquePointer!) -> Int32
    @discardableResult
    func sqlite3_step(_ pointer: OpaquePointer!) -> Int32
    @discardableResult
    func sqlite3_open_v2(_ filename: UnsafePointer<Int8>!, _ ppDb: UnsafeMutablePointer<OpaquePointer?>!, _ flags: Int32, _ zVfs: UnsafePointer<Int8>!) -> 
    @discardableResult
    func sqlite3_prepare_v2(_ db: OpaquePointer!, _ zSql: UnsafePointer<Int8>!, _ nByte: Int32, _ ppStmt: UnsafeMutablePointer<OpaquePointer?>!, _ pzTail: UnsafeMutablePointer<UnsafePointer<Int8>?>!) -> Int32
    @discardableResult
    func sqlite3_column_int(_ oP: OpaquePointer!, _ iCol: Int32) -> Int32
    func sqlite3_bind_int(_ oP: OpaquePointer!, _ first: Int32, _ second: Int32) -> Int32
    func sqlite3_bind_text(_ oP: OpaquePointer!, _ first: Int32, _ second: UnsafePointer<Int8>!, _ third: Int32, _ ptrs: (@convention(c) (UnsafeMutableRawPointer?) -> Void)!) -> Int32
    func sqlite3_column_text(_ op: OpaquePointer!, _ iCol: Int32) -> UnsafePointer<UInt8>!
}    
```

You can then call the concrete object with something like the following:

```swift
var wrapper: MockSqlite3Wrapper!
var mgr: SQLiteManager!

override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    wrapper = MockSqlite3Wrapper()
    mgr = SQLiteManager("testDB", wrapper: wrapper)
}

func testDeleteDB() {
    let expectation = XCTestExpectation(description: #function)
    wrapper.stepdone = true
    mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
        switch result {
        case .failure(let error):
            print(error)
        case .success(let success):
            try! self.mgr.delete(table: "mytable", deleteValues: PairedVals(column: "1", data: .text("Hello")), success!, completion: {
                XCTAssertEqual(self.wrapper.whichRun.bindText, ["Hello"])
                expectation.fulfill()
            })
        }
    })
    wait(for: [expectation], timeout: 3.0)
}
```

which is a repeatable test.

In the production code we can run the database using code like the following:

```swift
let manager: SQLiteManager = SQLiteManager(Constants.db)
    manager.open(withCompletionHandler: { [weak self] result in
        switch result {
        case .failure(let error):
            print(error)
        case .success(let dbPointer):
            print ( try! manager.listTables() )
        }
    })
```

# Why use the strategy design pattern
The main advantage of this pattern is that it allows you to encapsulate each algorithm's implementation details, making it easy to swap them in and out without affecting the rest of your code. Additionally, the strategy pattern can make your code more flexible, easier to maintain, and easier to test.

# Conclusion

Using the strategy pattern means we can make database agnostic code. That's a good thing.

I hope this article has helped make things a little clearer for the reader, and has proved useful.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
