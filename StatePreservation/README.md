# State Preservation

![](Images/photo-1559548331-f9cb98001426.jpeg)<br/>
<sub>Photo by kyryll ushakov on Unsplash <sub>

#Terminology:
State: The particular condition that the App is in at a specific time

#Prerequisites:
- You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)

#The setup
In the `AppDelegate` we set true for `optional func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool` and `optional func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool` like in the following code snippet: 

```swift 
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
```

#The UITableView example

We set 
![encodemvc](Images/encodemvc.png)
[encodemvc](https://gist.github.com/stevencurtis/a082abe921f9beab3f667356b493cd8f)
[mvccode](https://gist.github.com/stevencurtis/0d0fa8116db63b7be83605a9af66c9da)

We need to make sure we have a "restoration identifier" set `tableView.restorationIdentifier = restorationID` which is also set in the Storyboard

![restorationidstoryboard](Images/restorationidstoryboard.png)

which gives us the following code which is not production ready (note that it uses a rather poor MVC achitecture)

![encodemvc](Images/encodemvc.png)

# Conclusion
Preserving state for iOS Apps is relatively simple!

Don't take it too far - it can be done and it certainly can add great usability to your iOS App.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)

