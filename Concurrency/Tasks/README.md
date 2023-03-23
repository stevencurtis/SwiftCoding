# The Power of Tasks in Swift: Concurrency Made Easy
## Take it to the task!

Tasks are part of Swift's new concurrency model introduced way back in 2021. Essentially a Task allows us to create a concurrent environment from a non-concurrent method. That is we ca call `async` APIs in order to perform work in the background giving us a safe way to manage concurrency.

Let's look at the detail.

# Before we start

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 14.2, and Swift 5.7.2 

## Prerequisites:
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)
* Some familiarity with [GCD and concurrency](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2) would be useful for the reader

## Keywords and Terminology:
Task: A task represents a unit of work that can be executed asynchronously, independently of the main thread of the application.

# What are Tasks in Swift?
Tasks are a unit of work that can be executed asynchronously, independently on the main thread of the application. That is, you can provide a closure that contains the work for the task to perform.

If you choose to give up a reference to your task you will be unable to wait for it to complete or to cancel it (more on that later).

Which is a rather basic explanation. Perhaps this is better with a few examples? If you think you're getting that if you read on you'd be right.

# Key advantages of tasks
- They will be run in parallel (if it is safe to do so) with other tasks
- They work with async functions, and are capable of asynchronous execution
- Tasks have built-in support for cancellation which is useful if they are no longer needed or take too long to execute
- Swift's concurrency model is designed to be performant, and Tasks are an integral part of this model

# Tasks place work on a queue
Yes, that's correct. In Swift, a Task does not run immediately when it is created or started. Instead, it is added to a queue of tasks to be executed and scheduled for execution at a later time.
Oh, and a parent task can only complete when all of it's child tasks are finished.

# The simple example: Unstructured tasks
We can create a new task using the `Task` initializer, taking in a closure which represents the work to be performed. We then call the `run()` method to execute the closure.

Note that the following means we await the result of the task, before being able to print it (that's the await in the following code block)

```swift
let task = Task {
    return "Hello, world!"
}

let result = await task.value
print(result)
```

Now of course this can be instantly more complex than we might like. When we run code with the Playground we run from synchronous context. This can be done by wrapping the print statement in a `Task.init`.

```swift
let task = Task {
    print("Task running")
    return "Hello, worlds!"
}

Task.init {
    let result = await task.value
    print(result)
}
```

## Concurrent tasks
Multiple tasks can be run simultaneously. There are a couple of prerequisites to seeing this working on your machine (even if you download from the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/Concurrency/Tasks))

- It is better to not use either the Playground or the Simulator as threads only seem to show their true colours on a device. So the example is a plain `UIKit` project
- As you'll see the `Task` isn't used. `Task.detached` is. To understand why the latter works we will need to read on (although don't worry, that is explained later in this article)

```swift
final class Counter {
    private var count = 0
    func increment() -> Int {
        count += 1
        return count
    }
}

final class ViewController: UIViewController {
    
    private var tasks = [Task<Void, Never>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let counter = Counter()
  
        for _ in 1...1000 {
               tasks += [
                Task.detached {
                       print(counter.increment())
                   }
               ]
           }
    }
}
```

this gives the output that is commonly in sequential order, but sometimes it will be out of order:

[Images/outoforder.png](Images/outoforder.png)<br>

which might be as expected.

The tasks in this instance run out of order is because `Task.detached` creates a new task that is detached from the current task group and scheduled for execution on a concurrent dispatch queue. Essentially each task is scheduled for independent execution and runs independently to other `Task.detached` tasks.

## But the detached task in place of a vanilla task?
If you run the same code as above replacing `Task.detached` with `Task` (that is without the detached `Task` and instead with a `Task`) you'd have this code:

```swift
final class Counter {
    private var count = 0
    func increment() -> Int {
        count += 1
        return count
    }
}

final class ViewController: UIViewController {
    
    private var tasks = [Task<Void, Never>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let counter = Counter()
  
        for _ in 1...1000 {
               tasks += [
                Task {
                       print(counter.increment())
                   }
               ]
           }
    }
}
```

So the tasks run out of order (so in parallel) when we run `Task.detached` in the view controller code, but not with `Task`.

Tasks created with `Task` are guaranteed to run in order since they are created within the same task group. Each task in the task hierarchy has a parent task right up to the top-level task created when the application is launched. Each new task Task becomes a child of the current `Task` (that is typically the creating Task), is then scheduled for execution and added to the end of the task queue (which itself is associated with the task group).

Since we are operating in the same task group the tasks (within that task group) will run in the order in which they are created (as long as each task completes before the next starts, that is are not a `Task.detached` or on a concurrent dispatch queue). If `Task` are in different task groups they are not guaranteed to run in order as is a `Task.detached`.

So dobe careful with `Task.detached`. [Apple themselves](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.apple.com%2Fdocumentation%2Fswift%2Ftask%2Fdetached%28priority%3Aoperation%3A%29-3lvix) say to prefer using child tasks over `Task.detached` since you need to manage priority and task-local storage.
Which brings us onto the next sub-topic.

## Managing priority and task local storage with Task
**Managing priority**
Tasks in Swift concurrency can be assigned a priority (TaskPriority) that determines their relative importance and scheduling order. The available priority levels are `.userInitiated`, `.default`, `.utility`, and `.background`, with `.userInitiated` being the highest priority and `.background` being the lowest priority.

Here's an example of how to create a task with a specific priority:

```swift
let task = Task(priority: .userInitiated) {
    // ...
}
```

You can also set the priority of an existing task using the `Task.currentPriority` property:

```swift
Task.currentPriority = .userInitiated
```

By default, tasks are executed in the order they are created, regardless of priority. However, tasks with a higher priority will be given precedence over tasks with a lower priority when the system is deciding which tasks to execute next.

You might use `.userInitiated` in order to fetch some data on a button press. Something like:

```swift
@objc func fetchDataButtonTapped() {
    let task = Task(priority: .userInitiated) {
        let data = await fetchData()
        processData(data)
    }
}
```

## task local storage
Task local storage provides a way to store thread-local data that is associated with a specific task. This allows you to store and access data within a specific task without the risk of data races or other concurrency-related issues.

`TaskLocal` needs to be used within the Swift concurrency framework. 

Here's an example of how to use task local storage:

```swift
var taskLocal = TaskLocal<String>(wrappedValue: "Original value")

func printTaskLocalValue() async {
    let value = taskLocal.get()
    print(value)
}

let taskUnchanged = Task {
    await printTaskLocalValue() // Original value
}

let taskWithLocalChange = Task {
    await taskLocal.withValue("Hello, World!") {
        await printTaskLocalValue() // Hello, World
        await printTaskLocalValue() // Hello, World
    }
    await printTaskLocalValue() // Original value
}

let taskUnchangedAgain = Task {
    await printTaskLocalValue() // Original value
}
```

When we change the value, as in `taskWithLocalChange` the change only persists within the scope of the `withValue(_:)` function.

That is because `taskLocal` is thread-local, the value stored in `taskLocal` is only accessible within the task in which it was created. This ensures that the data is accessed and modified safely, without the risk of data races or other concurrency-related issues.

`TaskLocal` is designed to store context-specific values within a task. This could potentially be useful for user session information as TaskLocal values can store this information, making it easier to access it across different functions without explicitly passing it around.

## Using Task to bridge asynchronous and synchronous code
Tasks allow you to write code that will bridge the gap between synchronous and asynchronous code.

In the repo "TasksProject" the view model has this function:

```swift
private func getJoke() async throws -> String {
    let url = URL(string: "https://api.chucknorris.io/jokes/random")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()

    let result = try decoder.decode(Joke.self, from: data)
    return result.value
}
```

Note the use of the `async` keyword. This means the function is asynchronous and can be suspended partway through its execution, allowing other tasks to run concurrently. The await keyword indicates that the function is waiting for a result from the `URLSession.shared.data(from:)` function before continuing.

To call the `getJoke()` function from a synchronous context, you can use a Task to bridge the gap between the async and sync code. Here's an example of how you can achieve this:

```swift
func fetchJokeSync() {
    let task = Task {
        let joke = try? await getJoke()
        // populate a joke object here
    }
}
```

the comment shows where you might populate an object with the response from your (in this case) getJoke function - in this case a string.

Note: no callbacks have been used here.

## withThrowingTaskGroup
`withThrowingTaskGroup` is a Swift concurrency feature that allows you to create and manage a group of tasks that can throw errors. This can be useful when you need to perform multiple tasks concurrently, such as making multiple network requests, and want to handle errors in a centralised and consistent way. Inevitably my example is rather simple.

I'm attempting to demonstrate that using `withThrowingTaskGroup` can improve performance by running tasks in parallel. Something like:

```swift
func task1() async -> String {
    for i in 0..<10 {
        sleep(1)
        print("Task 1: \(i)")
    }
    return "Task 1: Complete"
}

func task2() async -> String {
    for i in 0..<10 {
        print("Task 2: \(i)")
    }
    return "Task 2: Complete"
}

func runTasks() async -> [String] {
    var items: [String] = []
    try? await withThrowingTaskGroup(of: String.self) { group in
        group.addTask {
            let result = await task1()
            return result
        }

        group.addTask {
            let result = await task2()
            return result
        }
        
        for try await item in group {
            items.append(item)
        }
    }
    return items
}

await runTasks() // ["Task 1: Complete", Task 2: Complete]
```

The `withThrowingTaskGroup` function creates a new task group, and tasks are added to the group using the `addTask` method. When all tasks are added, the `withThrowingTaskGroup` function waits for them to complete. If any task within the group throws an error, the error can be caught and handled when iterating over the task group.

The order of the tasks is not guaranteed because they run in parallel and the execution order is non-deterministic. This means that the results are appended to the `items` array in the order that the tasks finish rather than the order they were added to the group.

`withThrowingTaskGroup` provides a convenient way to perform multiple tasks concurrently while handling errors in a centralized and consistent way. An alternative? It's further up the page with `Task.detached`.

## withTaskGroup
The primary difference between `withTaskGroup` and `withThrowingTaskGroup` is how they handle errors. Both functions are used to create task groups and run multiple async tasks concurrently, but they differ in error handling so I'll give another (slightly different) simple example right here:

```swift
let result = await withTaskGroup(of: Int.self) { group in
  // Add two tasks to the group
  group.addTask {
      print("Task 1")
      return 1
  }
  group.addTask {
      print("Task 2")
      sleep(1)
      return 2
  }

  // Sum up all values returned by tasks
  var sum = 0
  for await value in group {
    sum += value
  }
  
  return sum
}

print(result) // 3
```

## withUnsafeCurrentTask
`withUnsafeCurrentTask` allows you to access the current task from within a task closure.

Something like the following will work:

```swift
func performOperation() async {
    await withUnsafeCurrentTask { task in
        print("Performing operation in task: \(task.id)")
    }
    // Perform operation...
}
```
This enables you to inspect the current task in order to understand the state of the application, and so is useful for debugging.

```swift
func performOperation() async throws {
    for i in 1...Int.max {
        try Task.checkCancellation()
        print("Operation step \(i)")
        // Perform operation step...
    }
}
```

It can be useful in situations where you have long-running or resource-intensive tasks, and you want to gracefully handle cancellations and clean up resources when the task is cancelled.

## Task.cancel()
If you wish to cancel a task you can as there is a `Task.cancel()` method, which is rather excellent.

For example using `Task.cancel()` in combination with UITableView means you can cancel tasks in cells when they are no longer needed - specifically when they go off screen when the user is scrolling. A call for `prepareForReuse`? I guess so!


# Why use Swift's Tasks?
Simplified concurrency: Tasks provide a simplified and safe way to manage concurrency in your applications, allowing you to write concurrent code without worrying about low-level details such as threads and synchronization primitives. This can make your code more readable and maintainable.
Improved performance: By running tasks concurrently, you can improve the performance of your application and provide a better user experience. Tasks can be used to perform CPU-bound work in the background, allowing your application to remain responsive to user interactions.
Error handling: Tasks provide powerful error handling capabilities, allowing you to gracefully handle errors that occur during task execution. This can help to improve the reliability of your application and provide a better user experience.
Compatibility: Tasks are compatible with both the existing Grand Central Dispatch (GCD) API and the new Swift concurrency features, allowing you to use the best tool for the job in your application.
Asynchronous I/O: Tasks can be used to perform asynchronous I/O operations, such as network requests and file I/O. This can help to improve the performance and responsiveness of your application.

# Alternatives to Swift's tasks
 Grand Central Dispatch (GCD): This low-level API allows developers to perform tasks asynchronously on a dispatch queue. It also supports uses of [semaphore](https://stevenpcurtis.medium.com/avoid-deadlock-with-semaphores-36bb879d73ae), barriers and [groups](https://stevenpcurtis.medium.com/dispatchgroups-to-group-api-calls-in-swift-7906b2203854). 
 

 Operation Queues: Operation Queues are another high-level API that allow developers to manage concurrent tasks. They provide a way to encapsulate a unit of work as an operation object, which can be added to a queue and executed asynchronously. Operation Queues provide support for dependencies between operations and for canceling operations.
Threads: Threads provide a low-level way to manage concurrency in Swift. They allow developers to execute code concurrently on separate threads, but they require more manual management of synchronization and communication between threads.
Actors: Actors are a new feature introduced in Swift 5.5 that provide a high-level way to manage shared mutable state in concurrent systems. Actors ensure that access to shared state is synchronized and serialized, making it easier to write correct concurrent code.

# Conclusion

Thank you for reading.

Swift provides a powerful set of concurrency features, including tasks, actors, and Grand Central Dispatch (GCD), that can help developers write efficient, responsive, and reliable applications.

Tasks allow developers to easily manage concurrency by providing a simplified and safe way to perform work asynchronously, independently of the main thread of the application. With tasks, developers can write concurrent code without worrying about low-level details such as threads and synchronization primitives.

The advantages of using tasks in Swift include improved performance, simplified concurrency, powerful error handling capabilities, compatibility with other Swift concurrency features, and support for asynchronous I/O operations.

While tasks provide a powerful tool for managing concurrency, it is important to use them appropriately and in conjunction with other Swift concurrency features to create more complex concurrent systems. With the right tools and techniques, developers can create efficient and responsive applications that provide a great user experience.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
