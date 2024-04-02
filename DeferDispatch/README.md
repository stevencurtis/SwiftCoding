# The Defer Keyword in Swift
## Playing around in Swift

The reason for this article is that defer is often useful, but seldom used (in my experience) where it could make things much easier for programmers using swift.

Difficulty: **Beginner** | Easy | Normal | Challenging<br/>
This article has been developed using Xcode 15.0, and Swift 5.9

## Terminology:
`defer`: A statement in Swift that schedules a block of code to execute just before exiting the current scope, ensuring resource cleanup and final actions are reliably performed

# The defer statement
The defer statement in Swift allows developers to declare a block of code that will be executed in the future, specifically just before the current scope (such as a function, method, or loop block) exits. This helps to ensure that cleanup tasks are performed even if an error interrupts the happy path execution flow.

Not only that. Using defer can enhance readability and maintainability of code - specific situations where defer is useful include dealing with files, database connections, or any system resources that require explicit release or closure.

# A simple example
This technical example shows how `defer` can be used and uses an asynchronous block to hammer home the point. Don't worry too much about the logic of using `defer` in this case, this example is simply to show the nuts and bolts of using defer.

Let's dive in! 

```swift
final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var i: Item? = Item()
        i = nil
        print(i)
    }
}

class Item {
    init() {
        print("called init")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            defer { print("Dispatch 2") }
            print("dispatch 3")
        }
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            print("Dispatch 1")
        }
        )
        print("Dispatch 4")
    }

    deinit {
        print("deinit called")
    }
}
```

What is happening is that an instance of `Item` is created and then set to `nil`. This triggers the `deinit` method for the `Item` class.

Since the `init` method of the `Item` class schedules two tasks on the main dispatch queue we should see the impact of having different delays logged with print statements.

The output: 

```swift
called init
Dispatch 4
deinit called
nil
Dispatch 1
Dispatch 3
Dispatch 2
```

Dispatch 3 is printed, exactly how we might expect. The defer statement means "Dispatch 2" is printed immediately after "Dispatch 3" - which is exactly what we would expect defer to do (execute right after the scope is exited).

The execution order: 
"Dispatch 4" is printed immediately upon initialization of Item.
After 0.2 seconds, "Dispatch 1" is printed.
After 5 seconds, "dispatch 3" and then "Dispatch 2" are printed because of the defer statement.
"deinit called" is printed when the Item instance is deallocated, which happens right after its initialization due to it being set to nil.

# File handling
When working with file operations, such as reading from or writing to files, it's important to ensure that the file is properly closed after the operations are completed. `defer` can be used to guarantee that the file is closed.

In this example, regardless of whether the file read operation succeeds or an error is thrown, the defer block ensures that the file handle is closed, thus preventing a resource leak.

```swift
import Foundation

func readFileContents(path: String) -> String? {
    let fileURL = URL(fileURLWithPath: path)
    do {
        let fileHandle = try FileHandle(forReadingFrom: fileURL)
        defer {
            fileHandle.closeFile()
        }
        let data = fileHandle.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)
    } catch {
        print("Error reading file: \(error)")
        return nil
    }
}
```

# Database Transactions
`defer` can be instrumental in managing database transactions, ensuring that transactions are properly closed or rolled back if an error occurs. Here, defer is used to call endTransaction to ensure that the transaction is closed properly, regardless of whether the operations succeed or fail.

`defer` is used to call endTransaction to ensure that the transaction is closed properly, regardless of whether the operations succeed or fail.


```swift
func performDatabaseTransaction() {
    let dbConnection = Database.connect()
    
    dbConnection.beginTransaction()
    defer {
        dbConnection.endTransaction()
    }
    
    do {
        try dbConnection.insert(...)
        try dbConnection.update(...)
        // Additional database operations
    } catch {
        dbConnection.rollbackTransaction()
        print("Transaction failed: \(error)")
    }
}
```

# Managing Multiple Resources
In scenarios involving multiple resources (e.g., network connections and file handles), defer statements can be stacked to ensure that all resources are released.

This demonstrates how multiple defer statements ensure that both the network session and the file handle are properly closed, avoiding resource leaks even if an error occurs during processing.

```swift
func processFile(from url: URL, to destinationPath: String) {
    let networkSession = NetworkSession.start()
    defer {
        networkSession.close()
    }
    
    do {
        let fileHandle = try FileHandle(forWritingTo: URL(fileURLWithPath: destinationPath))
        defer {
            fileHandle.closeFile()
        }
        
        let data = try networkSession.download(url: url)
        fileHandle.write(data)
        
    } catch {
        print("Processing failed: \(error)")
    }
}
```

# Cleanup Actions in Complex Functions
`defer` is also useful in complex functions with multiple exit points, to perform necessary cleanup actions. In this complex function with multiple guard statements (and thus multiple exit points), defer ensures that the allocated resource is always released.

This showcase how `defer` can be a versatile tool in Swift for managing resources and ensuring cleanup, making code safer and more robust.

```swift
func complexFunction() -> Int {
    let resource = Resource.allocate()
    defer {
        resource.release()
    }
    
    guard condition1 else { return 0 }
    guard condition2 else { return 1 }
    
    // Function logic continues
    
    return 2
}
```

# Conclusion
The `defer` statement critical role in crafting clean, maintainable, and error-resistant code.

If only we used it more. Right? Right?
