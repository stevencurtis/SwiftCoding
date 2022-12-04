# The Decorator Design Pattern in Swift
## Add to it!

![Photo by Aleks Dorohovich](Images/doctype-hi-res.jpg)<br/>
<sub>Photo by Aleks Dorohovich<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.5, and Swift 5.2.4

## Prerequisites: 
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

# Terminology:
Design Pattern: a general, reusable solution to a commonly occurring problem

Rather than subclassing (which follows from the principle that we should favour composition over inheritance)

# The Decorator Design Pattern in Swift
Essentially decorators act as a middle man, intercepting calls to a core object and providing customised behaviour to the client.

This means the design pattern is useful if
* The core object needs to be wrapped for the purpose of testing
* The core object cannot be modified directly

# The Detail
The decorator allows adding behaviour and responsibility to an object without modifying code. This is commonly implemented in Swift, and when used clients are not aware if they are using a decorator or core object to access functionality.

```swift
func testDeleteDB() {
    let expectation = XCTestExpectation(description: #function)
    let mgr = SQLiteManager("testDB")
    mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
        switch result {
        case .failure(let error):
            print(error)
        case .success(let success):
            try! mgr.delete(table: "mytable", deleteValues: PairedVals(column: "ID", data: .integer(2)), success!, completion: {
                let result = TestHelpers().readFromTable(table: "mytable", success!)
                XCTAssertEqual(result, [["1", "Apple"], ["3", "Fries"]])
                expectation.fulfill()
            }
            )
        }
    })
    wait(for: [expectation], timeout: 3.0)
}
```


## The practical example in Swift
I implemented an [SQLiteManager](https://youtu.be/qVu0ow0mats) that shows how a wrapper can be used to make sure that the use of the database doesn't render code untestable.

This opens up our code to having a **repeatable** set of tests - where we can swap out implementation to prevent having to use a concrete database.

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

You can then call the concrete object something like the following:

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

# Conclusion
This article has provided an example in Swift about how we might create use the design pattern in a way that allows adding of behaviour and responsibility to an object.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
