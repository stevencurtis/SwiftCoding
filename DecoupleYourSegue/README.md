# Decoupling
## The MVC Architecture in Swift: A Practical Example

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.2, and Swift 5.3

# Prerequisites:
* I have already written an article on [MVC](https://medium.com/swift-coding/mvc-in-swift-a9b1121ab6f0), and the code in this article is based on that code
* This article leverages [protocol](https://stevenpcurtis.medium.com/protocols-in-swift-f46c31283b18)s 

# Terminology
Coupling: The degree of interdependence between software modules and classes
protocol: A blueprint on methods, properties, and requirements to suit a piece of functionality

# Coupling
Coupling is the degree of interdependence between software modules, and how closely connected they are.

A low degree of coupling is seen as a good design since low coupling can assist with reuse as well as readability and maintainability.

# Coupling Using a Segue for Navigation
If we are trying to move between View Controllers using a Storyboard, we might well use code that has `prepare(for:sender)` and use this to pass data to a `DetailViewController`.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailVC = segue.destination as? DetailViewController {
        detailVC.data = dataDownloaded.description
    }
}
```

where the `DetailViewController` has a `data` property

```swift
class DetailViewController: UIViewController, DataViewProtocol {
    var data: String = ""
```

This code only works if the Destination is a `DetailViewController`, and nothing else can support having the data parameter filled in with a String. 

**Argument Number 1**
Since you are performing a segue to a view controller, you know that the property exists on that view controller. You as the developer can guarantee that the property is there, so what is the problem?

The answer to this is that we cannot easily swap out the implementation for `DetailViewController` to another View Controller. This isn't ideal!

## Solution: The Protocol
By conforming to a protocol we allow `AnyObject` that conforms to the protocol which exposes the properties that are required.

Here is an example protocol that can be used. We are specifying a getter and setter in the protocol here:

```swift
protocol DataViewProtocol: AnyObject {
    var data: String { get set }
}
```

which then we can conform to the protocol (no other changes are required in the view controller)

```swift
class DetailViewController: UIViewController, DataViewProtocol {
    var data: String = ""
```

This means that we can change the segue in the view controller to segue to another other View Controller that Conforms to the `DataViewProtocol` - which are just some changes in the Storyboard

[Images/indigo.png](Images/indigo.png)<br>

which would be to change the segue from the blue view controller to the indigo one. 

[Images/indigo.png](Images/indigotwo.png)<br>

we are now accessing the data property through the protocol. This means we are free to swap out the implementation of `OtherDetailViewController` for any view controller which conforms to `DataViewProtocol`.

This means the implementation isn't tightly coupled, we can swap out concrete implementations from behind the protocol. This is obviously great news!

# Conclusion
Decoupling is an important part of programming.

When we are programming to create iOS applications we can think about this as the ability to be able to swap out implementations. In this case, we have done so using the example of a View Controller.

I hope this article has helped you, and wish you all the best in your coding journey.

If you've any questions, comments, or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
