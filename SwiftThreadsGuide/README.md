# Swift Threads: The Guide
## Nothing To Do With Clothes

I've previously [written that threads](https://stevenpcurtis.medium.com/swift-views-shouldnt-know-about-threads-3de632cccd47) should be handled by the view model in MVVM. I've written about [GDC](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2). I've even completed some work around RunLoop in Swift.

I haven't made what threads are clear.

*I'll fix that now.*

Difficulty: Beginner | Easy | **Normal** | Challenging
This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites
Be able to produce a ["Hello, World!" SwiftUI project](https://stevenpcurtis.medium.com/hello-world-swiftui-92bcf48a62d3)

# Keywords and Terminology:
RunLoop: an object that manages events and tasks within a thread, including the main thread, and ensures the thread remains active and responsive.

Thread: Tasks can have their own threads of execution to stop long-running tasks block the execution of the rest of the application

# Threads
A thread can be thought of as a sequence of instructions that can be executed (independently of other threads). By executing tasks on multiple threads an application can perform multiple tasks simultaneously which can ultimately increase performance and responsiveness.

## An Example
Imagine a world where you wish to download several large files. 

**A single thread**
If you only have access to a single thread, each file would need to be downloaded sequentially. That is, each file would need to be downloaded in turn before the next can be downloaded

**Multiple threads**
If you have access to multiple threads, the application can perform multiple tasks simultaneously. In our example, files can be downloaded simultaneously on multiple threads which would mean the overall download time is decreased (since the downloads are in parallel) and the application's responsiveness is increased.

**Challenges of multiple threads**
Parallelising code isn't a free solution to coding problems. Since using multiple threads involves computing in parallel it introduces the [readers-writers problem](https://stevenpcurtis.medium.com/the-readers-writers-problem-995a2a89d0ab), challenges around [thread-safety](https://stevenpcurtis.medium.com/swift-thread-safe-arrays-ed1541301eb3) and data races.

# RunLoop
Runloop manages events and tasks within a thread. RunLoop is responsible for receiving and processing events and executing associated handlers in the thread's current mode.

You'd wish to use a RunLoop when you want to keep a thread alive when no tasks are to be performed. This means that the thread can be available when needed instead of needing to be restarted or woken up. Also? [TIMERS](https://stevenpcurtis.medium.com/what-is-a-runloop-anyway-swift-and-ios-guide-aa574577331b).

## Seeing The RunLoop
No problem. We can print out the RunLoop

```swift
print(runloop.main)
```

Which prints something* like the following:

```swift
<_NSMainThread: 0x600000a18140>{number = 1, name = main}
```

*Your real-life thread may vary from mine.

You can also even see the runloop from Xcode!

## RunLoop and Threads
- Each thread potentially has a unique RunLoop object corresponding to it
- The RunLoop for the main thread has been created automatically, and Runloop for sub-thread needs to be created manually.
- RunLoop is created on the first acquisition and destroyed at the end of the thread
- RunLoop allows you to keep a thread alive and responsive even when no tasks are to be performed, helping to improve performance and the user experience

# Main Thread
The main thread in iOS is the primary thread of execution in a program. Responsible for UI events, putting a long-running task on the main thread can cause the UI to become unresponsive (and lead to shouts of "it's frozen" from your users)

**Blocking the Main Thread**

You do not (generally) with to block the main thread under any circumstances. 
A download from the Internet? You might be tempted to write something like the following:

```swift
func downloadFile(from url: URL) {
    guard let data = try? Data(contentsOf: url) else {
        print("Error downloading file")
        return
    }
    // Save or otherwise deal with the downloaded file
    print(data)
}

let urlString = "https://picsum.photos/200/300"
downloadFile(from: URL(string: urlString)!)
```

It all seems happy when you run this from the playground (or similar). Call `downloadFile` from a full-fledged App? You'll see the user interface freeze horribly.
Talking of horrible code, look at this:

```swift
class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func downloadFile(from url: URL) {
        guard let data = try? Data(contentsOf: url) else {
            print("Error downloading file")
            return
        }
        // Save or otherwise deal with the downloaded file
        print(data)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = "https://picsum.photos/5000/5000"
        downloadFile(from: URL(string: urlString)!)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "press to download"
        return cell
    }
}
```

Ugg. Not even `final` for the class. However, if you run this and click to download, the UI will freeze. It's awful in quite a number of ways.

To solve this problem we can use `URLSession` which always does it's work on a background thread.

```swift
func downloadFile(from url: URL) {
        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url) { (location, response, error) in
            guard let location = location, error == nil else {
                print("Error downloading file: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            
            do {
                let data = try Data(contentsOf: location)
                // Save or otherwise deal with the downloaded file
                print(data)
            } catch {
                print("Error saving file: \(error.localizedDescription)")
            }
        }
        downloadTask.resume()
    }
}
```

[The documentation](https://developer.apple.com/documentation/foundation/urlsession) conforms the status of `URLSession`: Like most networking APIs, the `URLSession` API is highly asynchronous.

You do need to be aware about returning to the Main thread.

If you wrote the following code (and it would be a little rubbish if you did) you'd get a crash, It's awful.

```swift
class ViewController: UIViewController {
    @IBOutlet var button: UIButton?
    @IBOutlet var textView: UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressButton() {
        let urlString = "https://picsum.photos/5000/5000"
        self.downloadFile(from: URL(string: urlString)!)
    }
    
    private func downloadFile(from url: URL) {
        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url) { (location, response, error) in
            guard let location = location, error == nil else {
                print("Error downloading file: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            
            do {
                let data = try Data(contentsOf: location)
                self.textView?.text = "Downloaded \(data)"
            } catch {
                print("Error saving file: \(error.localizedDescription)")
            }
        }
        downloadTask.resume()
    }
}
```

This can be solved by making sure we `self.textView?.text = "Downloaded \(data)"` on the main thread
which means we have the following

```swift
DispatchQueue.main.async {
    self.textView?.text = "Downloaded \(data)"
}
```

or the code in full:

```swift
class ViewController: UIViewController {
    @IBOutlet var button: UIButton?
    @IBOutlet var textView: UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressButton() {
        let urlString = "https://picsum.photos/5000/5000"
        self.downloadFile(from: URL(string: urlString)!)
    }
    
    private func downloadFile(from url: URL) {
        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url) { (location, response, error) in
            guard let location = location, error == nil else {
                print("Error downloading file: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            
            do {
                let data = try Data(contentsOf: location)
                DispatchQueue.main.async {
                    self.textView?.text = "Downloaded \(data)"
                }

            } catch {
                print("Error saving file: \(error.localizedDescription)")
            }
        }
        downloadTask.resume()
    }
}
```

The reason this works is that UI code MUST go onto the main thread. We also must take care not to block the main thread with background tasks.

*I hope this makes everything clear*

# Creating a Thread with GCD
GCD has already been covered in [my article](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2) about it, and has even be touched upon in this article with the `DispatchQueue.main.async` code above.

GCD is an easy to use way of dealing with threads and concurrency than dealing with them directly. Work items can be dispatched to run concurrently on either serial or concurrent queues.

**Example**

To create a new thread using GCD, you can use the `DispatchQueue` class. A dispatch queue is a task queue that manages the execution of tasks on one or more threads. You can use a dispatch queue to create a new thread and perform work on it.

Here's an example of how to create a new thread with GCD:

```swift
let myQueue = DispatchQueue(label: "myqueue")

// Dispatch a block of code to the queue to be executed asynchronously

myQueue.async {
    // Code to be executed on the new thread goes here
    print("This print statement is running on a background thread")
}

// Code that will be executed on the main thread continues to run concurrently
print("This print statement is running on the main thread")
```

Here we have an example queue called `myQueue` (excellent name, I know) with a label `myqueue`. The async function dispatches a code block to the queue to be executed synchronously, and the code in that block is executed on a new serial background queue.

The code outside that block continues to run on the main queue, so the second print statement continues to run concurrently.

The `async` method is non-blocking so does not wait for the task to complete. The closure is executed on a new thread created by the system and moves back to the main thread when the task completes.

We can always move back onto the main queue either asynchronously

```swift
DispatchQueue.main.async { }
```

or synchronously

```swift
DispatchQueue.main.sync { }
```

You can also choose a quality of service for background threads

```swift
DispatchQueue.global(qos: .background).async { }
```

These global queues are accessed with the quality of service attribute on the queue; user-interactive, user-initiated, utility and background.

## Working with Thread-Safe Data
When you're working with threads, it's essential to ensure that your data is thread-safe. Thread-safe data can be accessed and modified by multiple threads without causing data races or other concurrency-related issues.

In Swift, you can use the `@Atomic` property wrapper to make a variable thread-safe. The `@Atomic` property wrapper guarantees that the variable can be read and written atomically, which means that it's not possible for two threads to access the variable at the same time.

Here's an example of how to use the `@Atomic` property wrapper:

```swift
class Counter {
    @atomic var count: Int = 0
    
    func increment() {
        // The increment operation is performed atomically
        self.count += 1
    }
    
    func decrement() {
        // The decrement operation is performed atomically
        self.count -= 1
    }
}
```

In this example, we create an `@Atomic` variable called `counter`. We then create a new dispatch queue and use it to increment the `counter` variable on a new thread. Because `counter` is thread-safe, we don't need to worry about data races or other concurrency-related issues.

If you want more information about this, perhaps see my article on [thread-safe arrays](https://stevenpcurtis.medium.com/swift-thread-safe-arrays-ed1541301eb3).

# Conclusion

It is extremely important to write iOS applications which are performant and responsive. In order to do so it is worth understanding the concept of threads and how they can be used to execute tasks.

There are challenges in working with concurrent data, including thread-safety, data races and blocking the main thread but we have iOS tools like RunLoop and GCD (as well as URLSession) to help us out.

I hope this article (going through the various techniques) helps you out and assists you in continuing your journey with Swift.

Happy coding!

Subscribing to Medium using this link shares some revenue with me.
You might even like to give me a hand by buying me a coffee https://www.buymeacoffee.com/stevenpcuri.
If you've any questions, comments or suggestions please hit me up on Twitter
