# Mastering Concurrency in Swift: Understanding Grand Central Dispatch Quality of Service
## Optimising Performance and Responsiveness

I love my previous article about [GCD and concurrency in Swift](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2), but I've never been satisfied about how I treated  quality of service as an afterthought. 

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 14.2, and Swift 5.7.2 

# Prerequisites:
* I do occasionally refer to my [previous article](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2)

# Keywords and Terminology:
Grand Central Dispatch (GCD): Apple's high-level API for managing concurrency on macOS, iOS, and other Apple platforms. It provides a way to manage concurrent tasks using dispatch queues, which can be used to execute tasks asynchronously and in a thread-safe manner.

# DispatchQueue isn't quite good enough
Sometimes we would like to dispatch queues with a priority in order to make our Apps more performant.

This is in addition to dispatching tasks synchronously or asynchronously.

Here's a quick reminder of async and sync:
Sync dispatching means that the thread where the task is dispatched has to pause and finish executing the task before resuming.

Async dispatching means that the thread can be dispatched and does not wait for the task to finish executing.

```swift
let queue = DispatchQueue(label: "myqueue")

// Async Dispatch
queue.async {
    // Perform task asynchronously on a background thread
}

// Sync Dispatch
queue.sync {
    // Perform task synchronously on the current thread
}
```

The main reason to perform a task on a background thread (asynchronously) is if that task is computationally expensive or a task like a network call which may take some time to complete. By using a background thread we can ensure that the application remains responsive to user interactions and the UI is not blocked.

The reason for using sync dispatch to perform a task on the current thread is when you wish to wait for the task to complete before continuing. This might be because we would want to make sure a function is not called multiple times. It is important to be careful with sync dispatch, as it is blocking and the result of this can be to cause deadlocks in code.

As a result it is rare that you would want to use sync dispatch on the main thread as it can cause freezes or crashing. It may be required to update UI or a shared data structure, but go with care!

# Quality of Service (QoS) levels in GCD
Here are the quality of service levels as defined in the documentation: https://developer.apple.com/documentation/dispatch/dispatchqos, ranked by priority (highest first):

## User Interactive
This can be used like:

```swift
DispatchQueue.global(qos: .userInitiated).async {
    // Load data in response to a user action, such as searching or filtering
}
```
This QoS level is suitable for UI updates such as scrolling or animations. These are given the highest priority to ensure the user experience is as good as it can be.

## User-initiated
This can be used like:

```swift
DispatchQueue.global(qos: .userInteractive).async {
    // Perform UI updates, such as scrolling or animations
}
```

A good example of a suitable use for user-initiated is when a user makes an action like searching or filtering. These tasks are important and require a fast response, but do not have quite the same priority level as user-interactive tasks.

## Utility
This can be used like:

```swift
DispatchQueue.global(qos: .utility).async {
    // Perform periodic maintenance tasks, such as cleaning up temporary files or performing database backups
}
```
Maintenance tasks such as cleaning up temp files should be assigned to the utility QoS level. These tasks are important but 

Periodic maintenance tasks, such as cleaning up temporary files or performing database backups, might be assigned to the utility QoS level. These tasks are important but are not time-sensitive and can be executed over a longer period of time.

## Background
This can be used like:

```swift
DispatchQueue.global(qos: .background).async {
    // Download large files or perform batch processing tasks, such as image or video processing
}
```
This is suitable where large files are downloaded or video processing might take place. 

## Default
Used where a task is not explicitly assigned a QoS level. It is therefore a reasonable choice for most tasks and is suitable for active work performed on your user's behalf.

## Unspecified
Used when a task is dispatched without specifying a QoS level. In this case, the system assigns the default QoS level.

# Conclusion
Thank you for reading.

Grand Central Dispatch (GCD) is a powerful tool in Swift for managing concurrency, allowing tasks to be executed asynchronously and in a thread-safe manner. Quality of Service (QoS) levels in GCD help optimise the performance and responsiveness of applications, prioritising certain tasks over others based on their importance.

I hope this article has helped you out, and maybe I'll see you next time?

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
