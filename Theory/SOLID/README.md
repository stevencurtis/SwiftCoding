# The SOLID Principles Applied to Swift
## Let us apply Uncle Bob's acronym to Swift!

![photo-1555474258-ee7cefbcbd82](Images/photo-1555474258-ee7cefbcbd82.jpeg)
<sub>Photo by Berenice Melis @brrknees on Unsplash<sub>

I've already touched upon the SOLID pinciples, like in my articles about [dependency injection](https://medium.com/@stevenpcurtis.sc/learning-dependency-injection-using-swift-c94183742187), yet I think there is a need for the principles to be outlined in an article that can be used for quick-reference (with examples). Read on for just such an article


# Why SOLID?
You might well have heard of the SOLID Principles, which are five of Robert Cecil Matin's principles.

They have been in use for coding in the Object-Oriented paradigm for twenty or so years. The idea of these principles is to improve how robost code is against bugs, encourage code reuse and make code more flexible (so changes can easily be made in code).

The 5 principles here are covered with Swift examples. I've even got a link to some code snippets in my [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/Theory/SOLID) - read on for the details!

# The S - The Single Responsibility Principle (SRP)
There should never be more than one reason for a class to change. If a class has multiple reasons to change this can increase complexity and make it tricky to track down bugs. We don't want that!

In respect to iOS development there has always been a danger that too many reponsibilities are placed within a `UIViewController`. One way of dealing with this is to separate out the data source into a different class. Here is how this might be done:

```swift
class WithoutDataSourceViewController: UIViewController {
    let dataSource = MyDataSource()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
}

extension WithoutDataSourceViewController: UITableViewDelegate {}

class MyDataSource: NSObject, UITableViewDataSource {
    var data = ["a","b","c"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
```

# The O - The Open-Closed Principle (OCP)
Classes, functions and modules should be open for exension but closed for modification. Essentially you should design modules that should never change - this makes the modification of your code much easier. So when the requirements change the behaviour of modules can be altered by adding new code (rather than changing existing code), as a result modification to the behaviour of code is easier.

We can do this is Swift by conforming to a `protocol`, so we can add classes that conform to the protocol without modifying the rest of our code.
```swift
protocol DataProtocol{
    func getData() -> Data?
}

final class NetworkData {
    func getData() -> Data? {
        // fetch data with URLSession
        return nil
    }
}

final class PersistentData {
    func getData() -> Data? {
        // fetch data from CoreData, or similar
        return nil
    }
}

let getURLData = NetworkData()
let returnedData = getURLData.getData()

// to add SQL getData we don't need to change anything else, and can add the class below

final class SQLData {
    func getData() -> Data? {
        // fetch data from Database
        return nil
    }
}
```

# The L - The Liskov Substitution Principle (LSP)
Functions that use pointers or references to base classes must be able to use objects of the derived classes without they are using a derived class. That is, objects in a superclass should be replaceable with objects of it's subclass.

If you decide to apply this principle to your code, the behavior of your classes becomes more important than its structure. The advantages of this become code re-isability, loose coupling and easier maintenance.

More generally, LSP extends the open-closed principe, and derived classes must be substitutable for their base classes. For example you make an error that inherits from Error as in the following code:

```swift
public enum NetworkError: Error, Equatable {
    case bodyInGet
    case invalidURL
    case noInternet
    case invalidResponse(Data?, URLResponse?)
    case accessForbidden
}
```

The resultant `NetworkError` IS also an `Error`. Great!

# The I - The Interface Segregation Principle (ISP)
ISP says that we should make fine grained interfaces that are client specific, or to put it another way no client should be forced to depend on methods that it does not use.

Simplifying classes allows for better resuability, and code becomes simpler and easier to maintain (if you want to remove functionality you can choose to remove a class - easy!).

In Swift we use smaller `protocols` and composition into larger interfaces if necessary. If you wish to use multiple `protocols`, you can use composition to do so.

So you might have messages that can either display an image or text:

```swift
protocol Message {
    func displayImage()
    func displayText()
}
```

which would mean that a message that contains an image would also need a function to displayText - which it has no business knowing.

A better solution would be to use multiple protocols which means that an Image or a Text only have business displaying the type of data that they display. Which makes sense! 
```swift
protocol ImageMessage {
    func displayImage()
}

protocol TextMessage {
    func displayText()
}
```

# The D - The Dependency Inversion Principle (DIP)
Dependency Inversion is a principle that allows the decoupling of software modules.

Decouping code in this way makes code testable, reusable and ultimately readable (although some claim the increase in complexity makes code less readable, and there will be more files from following this principle).

Generally speaking, the following hold true for DIP:
- High-level modules should not depend on low-level modules. Both should depend on abstractions
- Abstractions should not depend on details. Details should depend upon abstraction - that is the protocol in this case

One way of implementing this is in Swift is documented in my [Dependency Injection](https://medium.com/@stevenpcurtis.sc/learning-dependency-injection-using-swift-c94183742187) article.


Other methods of implementing DIP are [ServiceLocator](https://medium.com/@stevenpcurtis.sc/the-service-locator-pattern-in-swift-5db2c770bcc), Event and Delegate.

# Conclusion
Writing code that conforms to SOLID principles might well end up getting you a job, a promotion or a great performance review (or get your PR accepted).
 
You might well notice that this article doesn't cover the advantages and disadvantages of the SOLID principles, and there is a good reason for this. Even though there are advantages to using each one, it is kind of a way of life, a way of thinking and the application of the principles that are important. Taking out a single principle and saying that it increased complexity may well be true, but the end goal is to write better code that helps maintenance, readability and code reuse - and presupposes that you want to achieve these goals in your code.

That is - you want to write great code? The SOLID principles are a great way to start! 

I hope you enjoyed this article, and that it is of some use to you in your coding journey.

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 