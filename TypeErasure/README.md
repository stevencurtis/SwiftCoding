# Type Erasure in Swift
## Get rid of that type information

![](images/erasure-mn2s.jpg)

Difficulty: Beginner | Easy | Normal | **Challenging**<br/>
This article has been developed using Xcode 11.4.1, and Swift 5.2.2

This article is example laden, and shows how I've used `Type Erasure` in my production Apps. It should help if you wish to know what `Type Erasure` is and how you might apply it in your Swift code.

This is no "Ship of fools", and we are all hoping this article does not have any references to the 80's pop sensations Erasure. Their music is before my time, the references will go over the heads of everybody and you'll just want me to "Stop!". 

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), or a [Playground](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to run Swift code
* You will need to know about [protocols in Swift](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18)
* The heart of this article is a constant (and annoying) talk about [generics](https://medium.com/better-programming/generics-in-swift-aa111f1c549)

## Terminology:
Type Erasure: Removing type information 

When programming in Swift we have a [type-safe language](https://medium.com/@stevenpcurtis.sc/why-type-safety-is-essential-in-swift-363a5fd2a795), that is Swift is strongly typed.  

Now sometimes you might want to use type erasure, that is removing type information to find out why you might want to *lose* information in this way we have to think about protocol-oriented programming and specific implementations of the same...

## Protocol-oriented programming - A real life need for Type Erasure
When we code against an interface (in Swift we code against a `protocol`) we develop a contract between the client and supplier of a service. 

I've previously used [associated types](https://medium.com/@stevenpcurtis.sc/protocols-with-associated-types-in-swift-eec850af3c02) to create articles on [Operation queues](https://medium.com/@stevenpcurtis.sc/use-operationqueue-to-chain-api-calls-in-swift-71eefd6891ef) where I've a `protocol` with an `associated type` to make the `protocol` in some sense generic.

In that instance, my `HTTPManager` conforms to a `HTTPManagerProtocol` which can then be represented as a stored property, for example in my `UserListRetrievalOperation` class:

```swift
class UserListRetrievalOperation<T: HTTPManagerProtocol>: NetworkOperation {
    var dataFetched: Data?
    var httpManager: T?
    var error: Error?
    var url: URL?
    
    init(url: URL? = nil, httpManager: T) {
        self.url = url
        self.httpManager = httpManager
    }
       
    override func main() {
        guard let url = url else {return}
        httpManager?.get(url: url, completionBlock: { data in
            switch data {
            case .failure(let error):
                self.error = error
                self.complete(result: data)
            case .success(let successdata):
                self.dataFetched = successdata
                self.complete(result: data)
            }
        })
    }
}
```

where, inevitably the class must itself be generic with  `<T: HTTPManagerProtocol>` being added to the class signature. The reason for this is that we need to save an instance of type `T`, and that means we need to be able to specify what type that property will be. The danger with this approach is that we are looking down the barrel of making everything generic. If you want to take a look at this approach **in situ** please do take a look at the [full article ](https://medium.com/@stevenpcurtis.sc/use-operationqueue-to-chain-api-calls-in-swift-71eefd6891ef), where generic `protocols` have been used to allow full testing of the classes that have been used. 

Now this approach isn't a problem per se (it met it's goals, and delivered a rather spiffing article), but we can do better. You don't need to guess: A better approach is using `Type Erasure`.

## The approach in the article
This particular article is about Type Erasure, and therefore I'm repurposing my favourite [basic network manager](https://medium.com/@stevenpcurtis.sc/my-basic-httpmanager-in-swift-db2be1e340c2) to simply make a network request.

**A little respect**
The approach I'd usually take is [MVVM-C](https://medium.com/@stevenpcurtis.sc/mvvm-c-architecture-with-dependency-injection-testing-3b7197eb2e4d) or similar, perhaps making network requests from the coordinator. However, for this article I'm attempting to make everything as simple as possible - and we will make network requests from *right in* the `UIViewController`. The reason for this is that making this a discrete article, away from architecture should make `Type Erasure` easier to understand without the use of any particular archiecture (for those interested, this is trivial to implement in other architectures).

I've gone for an approach **not** using the `storyboard` so I can inject the network manager using the same mechanism for testing and production code. 

## The example
So we can pass through this step-by-step (although please do download the code from the repo, that's what it is there for!)
**Initialise the CV**

```swift
    let windowScene = UIWindowScene(session: session, connectionOptions: connectionOptions)
    self.window = UIWindow(windowScene: windowScene)
    let network = HTTPManager(session: URLSession.shared)
    let initialVC = ViewController<HTTPManager<URLSession>>(network: network)
    self.window?.rootViewController = initialVC
    self.window?.makeKeyAndVisible()
```
You see the problem - that `ViewController<HTTPManager<URLSession>>(network: network)` makes me feel a little sick.

The view controller can be generic, and store the network manager 
```swift
    class ViewController<U: HTTPManagerProtocol>: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func loadView() {
            view = UIView()
            view.backgroundColor = .red
        }
        
        var httpManager: U?

        init<T: HTTPManagerProtocol>(network: T ) {
            super.init(nibName: nil, bundle: nil)
            let url = URL(string: "https://httpbin.org/get")!
            
            httpManager = network as? U
            
            network.get(url: url, completionBlock: { res in
                print ("use the returned data \(res)")
            })
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
```

but uggh. We have to continue to drag the associated type around with us, and this will continue up until it pollutes the AppDelegate and/or scene delegate.

## AnyHTTPManager

We are going to use a type erasure technique commonly  used in the Swift standard libarary - SwiftUI in particular has the `AnyPublisher` type that most who have touched SwiftUI have become familiar with. 

We say that we wrap a protocol (which has an associated value) into a generic type, which can then be used without making each hosting object generic.

The key:
```swift
class AnyHTTPManager<U>: HTTPManagerProtocol {
    let session: U
    let closure: (URL, @escaping (Result<Data, Error>) -> Void) -> ()
    
    func get(url: URL, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        closure(url, completionBlock)
    }
    
    init<T: HTTPManagerProtocol>(manager: T) {
        closure = manager.get
        session = manager.session as! U
    }
}
```
This is now our main class for the **HTTPManager**

In the `SceneDelegate` in the example I've instantiated the HTTPManager and then injected this into the view controller (I'd usually put this into the ViewModel, but this example is meant to be easy and it is certainly not production-ready).

```swift
let network = HTTPManager(session: URLSession.shared)
let initialVC = ViewController(network: network)
```

I've then created an Initializer in the `View Controller` that lets us store the `HTTPManager` - as an `AnyHTTPManager` with associated type

```swift
var httpManager: AnyHTTPManager<URLSession>?

init<T: HTTPManagerProtocol>(network: T) {
    self.httpManager = AnyHTTPManager(manager: network)
    super.init(nibName: nil, bundle: nil)
}
```

which means that then we can make network calls from within any particular function in (this case) the view controller

```swift
httpManager?.get(url: url, completionBlock: { result in
    print ("use the returned data \(result)")
})
```

Look - there's a nice [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/ThreadSafeArray) that enables you to see all of the code that is avaliable. 

In any case, Type Erasure is Cool!


# Conclusion

It seems surprising that *losing* information is actually useful - but that is exactly what the type erasure is.

That is, it erases the type.

Does that make it easier to understand what `AnyPublisher` is in Swift? Tell me.

In any case, have a nice day.
 
 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 