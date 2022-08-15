# What is a RunLoop Anyway? Swift and iOS Guide
## Threads are not all that there is to getting stuff done.

## Apple Say
Apple has enabled the iOS SDK to handle user events and trigger responses within the application through use of the event queue.

## Eh?
A run loop keeps your thread busy when there is work to do and put your thread to sleep when there is none.
In other languages a run loop might be called an event loop.

## A Simple Example
*Let’s take an example about how views are laid out.*
When a user interacts with an application, the event is added to the event queue, which can then be handled by the application and potentially dispatched to other objects in the application. Once the events are handled, they then return control to the main run loop and begin the update cycle, which is responsible for laying out and drawing views.

## Then
Once control is returned to the main run loop, the system renders layout according to constraints on view instances.
When a view is marked as requiring a change in the next update cycle, the system executes all the changes.
The system works through the run loop, then constraints before the deferred layout pass.

## A better explanation
Apps are interactive. That is, they react to user input and then move back to a state where they can accept user input.
In the example above we are seeing how the run loop can be used to update views on the screen.
In fact, the run loop is responsible for
Touch events, and selector events
Timer events
Drawing points on the screen
So a runloop checks for events, and keeps checking.

## Runloops and threads
Each thread has a unique RunLoop corresponding to it
The main thread has a RunLoop automatically created
RunLoop for sub-threads would need to be manually created
RunLoop is created on first acquisition of a thread, and destroyed at the end of the thread

## See the runloop
No problem. We can print out the Run loop

```print(runloop.main)```

Which prints something* like the following:
```swift
<_NSMainThread: 0x600000a18140>{number = 1, name = main}
```
*Your real-life thread may vary from mine.

1. You can also see the RunLoop using the Debug. The shortcut for this is ⌘6 or the small bug spray can will get you there.
2. Ensure that view process by thread is selected
3. See CFRunLoopRun

![images/RunLoopDebug.png](images/RunLoopDebug.png)

## The Process
Each thread can have a RunLoop. Apple’s [OS_dispatch_queue_main](https://developer.apple.com/documentation/dispatch/os_dispatch_queue_main) is set up for serial tasks on the main thread, and is the only dispatch queue that has a `RunLoop`.
The main thread, by default has a `RunLoop` which can be accessed with a
```swift
print("Main Loop: \(RunLoop.main)")
```
However, when we think of `RunLoop` we call `RunLoop.current` to return the current thread’s `RunLoop` (if it is there) or create one for you.
If one is created, you might need to explicitly run the run loop of the thread with a `RunLoop.current.run()`.

## The Example
In the documentation for Timer Apple helpfully tells you that you should be aware of how run loops operate in order to user Timers. They point to the old [Threading Programming Guide](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.apple.com%2Flibrary%2Farchive%2Fdocumentation%2FCocoa%2FConceptual%2FMultithreading%2FIntroduction%2FIntroduction.html%23%2F%2Fapple_ref%2Fdoc%2Fuid%2F10000057i) which is pretty much fine, but few people actually read the documentation at that level.
What is useful is the following:

```swift
Run loops maintain strong references to their timers, so you don't have to maintain your own strong reference to a timer after you have added it to a run loop.
```

Which is pretty clear, right (if it's not drop me a message on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)).

This brings us to the common issues programmers have with timers and iOS. It's when interaction with the screen seems to "freeze" the timer if you interact with the display (scrolling a `UITableView` for example). It's a common issue and can even lead to weird effects and your QA shouting at you.

If you ignore the rather ugly red background of the following video you'll see that ONE of the `UITableViewCell` displayed in the `UITableView` updates even when the `UITableView` is pulled downwards.

![images/out.gif](images/out.gif)

The difference is to add the timer to a specific runloop `.common` being a, well common mode for timers and observers.
In the following example the first `Timer` kicks off `fireTimer` and the inventively named `timerUpdate` does the same for `timerUpdate`.

We can take a look at the code below:

```swift
Timer.scheduledTimer(
timeInterval: 1.0,
target: self,
selector: #selector(fireTimer),
userInfo: nil,
repeats: true
)
let timerUpdate = Timer.scheduledTimer(
timeInterval: 1.0,
target: self,
selector: #selector(fireNumberUpdateTimer),
userInfo: nil,
repeats: true
)
RunLoop.current.add(timerUpdate, forMode: .common)
```

Don’t worry, the complete code is available at the end of this article and also on the accompanying Repo.

## RunLoop.main and DispatchQueue.main
There can be some confusion between `RunLoop.main` and `DispatchQueue.main`, but there really shouldn’t be. `DispatchQueue.main` is set up with a `RunLoop` by default. A RunLoop has several modes, as we have seen above and one (frequently used) mode is `.common`, which is different from the default behaviour of `.default`.
The default behaviour of `RunLoop`? It’s that it is set up to not block the thread by touch events. The disadvantage of this is that it can make a `Timer` appear not to work.

## The Code

```swift
import UIKit
class ViewController: UIViewController {
@IBOutlet private var tableView: UITableView!
var number = 0
var numberUpdate = 0
override func viewDidLoad() {
super.viewDidLoad()
print(Thread.current)
print("Main Loop: \(RunLoop.main)")
setupTableView()
        Timer.scheduledTimer(
timeInterval: 1.0,
target: self,
selector: #selector(fireTimer),
userInfo: nil,
repeats: true
        )
let timerUpdate = Timer.scheduledTimer(
timeInterval: 1.0,
target: self,
selector: #selector(fireNumberUpdateTimer),
userInfo: nil,
repeats: true
        )
        RunLoop.current.add(timerUpdate, forMode: .common)
    }
@objc func fireTimer() {
        number += 1
        tableView.reloadData()
    }
@objc func fireNumberUpdateTimer() {
        numberUpdate += 1
        tableView.reloadData()
    }
private func setupTableView() {
        tableView.backgroundColor = .red
        tableView.dataSource = self
    }
}
extension ViewController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
2
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
if indexPath.row == 0 {
let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = number.description
return cell
        }
let cell = UITableViewCell(style: .default, reuseIdentifier: "celltwo")
        cell.textLabel?.text = numberUpdate.description
return cell
    }
}
```

## Conclusion
It really is useful to know what a `RunLoop` is. Or at least be aware of `EventLoop` in other languages.

Why?

So you won’t get timers that don’t work on interaction with the screen.

*Wouldn’t that be nice?*

Subscribing to Medium using [this link](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fmembership) shares some revenue with me.
You might even like to give me a hand by buying me a coffee https://www.buymeacoffee.com/stevenpcuri.
If you’ve any questions, comments or suggestions please hit me up on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)
