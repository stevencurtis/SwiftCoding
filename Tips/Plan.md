# System Design

# Constraints and Assumptions (criteria)
Defining components in order to provide the required functionality, solving the problem of repeated code.

* Who?
* How do they use it?
* Number of users?
* What are the inputs and outputs of the system
* Requests per second
* Testing
* Security
* Offline storage
* Intermittent connection issues

Do not allow massive view controllers, rigidity, fragility

# High-level Design
## Functional and non-functional requirements
* Preformance
* Responsiveness
* Offline functionality
* Watch
* Security
* Avaliability
* Dark mode
* Accessibility

## Break out services i.e.
* Network
* Login
* Analytics

## Non-Domain Specific functionality
Services sit of top of the UI and MVC (or other App architecture), and frequently consist of services such as storage and networking. Using these services we can avoid duplicated code.

Frameworks can be used across applications.

Other examples of frameworks that can be created are:
* Login services
* Analytics
* Location services
* Localization
* Add in reachability

However care should be take on more-domain independent functionality such as handling notifications and storage. It should also be noted that this isn't the only solution to making your App modular (by any means), and usually only makes sense when Applications become larger


## System Design 1: Redux managing App State
Redux is commonly matched with MVI (Model-View-Intent) where the intent represents the state of the App. Here I have considered Redux to be MVI, and interact with Redux through an interactor.

Advantages:
* Pure reducer functions make business logic easy to test
* Centralized state makes debugging relatively easy
* State can be persistent
* Services separated out from the main Application

Disadvantages:
Redux should only be used if you actually require a state management tool.
That is, does this App:
* Require it's application state to be updated frequently, is complex to update and is required in many parts of the App
* Does the App have a medium-to-large codebase worked on by many people

Only the Specific application context can answer these questions. Do you really need to update the state over time?

![Images/SystemDesignRedux.png](DeleteImages/SystemDesignRedux.png)<br>

## System Design 2: MVVM-C
Want to separate UI and business logic

![Images/SystemDesign.png](DeleteImages/SystemDesign.png)<br>

MVVM-C or viper? MVVM provides less clearly defined responsibilities compared to VIPER. However, in VIPER we have layers with their own responsibilities which are perhaps less flexible.
If your project is long-term with well-defined requirements then VIPER may be a good option due to the clear separation of concerns. However, confusing communication 
However MVVM-C helps with the separation of concerns by separating out the flow coordinator while also allowing flexibility. 
For smaller projects VIPER can be seen as overkill, defining where responsibilities are defined. 

# Core Design Components
## API Design
**Pagination**
If we download messages over an API. This can be implemented either within a REST or a GraphQL API.

We can use a system like `messages(first: 2, offset:2)` which would as for the next two items in a list.

However what about the case where messages keep being sent? 
**ID-based**
We can improve and use and ID to as for the next two messages after a particular message
`messages(first:2 after:$messageID)`
**Time-based**
We can perform a similar trick with a timestamp
`messages(first:2 after: now()`

**Cursor**
Using a cursor is the most powerful of these options.
`messages(first:2 after:$messageCursor)`
This gives a further abstraction, if the pagination model changes in the future we will still be compatible. We should remember that cursors are opaque and the format should not be relied upon (suggesting a base64 encoding).

![Images/socketapi.png](DeleteImages/socketapi.png)<br>

![Images/apidesign.png](DeleteImages/apidesign.png)<br>

## Notifications
Use a notification manager

## OO Design
Class vs. Struct
Protocols
Class inheritance (subclassing) - is a. Favour composition through protocols
Program to an interface
Codable
Could use Combine for bindings
Reusability for functions using generics (store different data in a data structure, observables and sets)
Reusable components

![Images/socketapi.png](DeleteImages/architecture.png)<br>

## Decide database
**Server**
1) MongoDB
2) AWS ElasticSearch

MongoDB - data stored as documents. Single JSON.Doesn't have full text search
AWS ElasticSearch - full text and GIS search support. Autosharding. 

**Internal**
Core data - seen as tricky, managedobjectcontexts bound to a thread.Great migration.
Realm - Cross-compatibility with Android. Consistency across threads. Faster.

# Scale
## Bottlenecks
Build time (modularisation)
Depolyment scalability
Testing
Pagination, as all the data does not need to be downloaded at once
Throttling for pull to refresh
Traffic spikes - caching, CDN, server-side caching
Image sizes
Memory restrictions
Performance problem - single user. Scalability problem, slow under heavy load
Caching
Reachability


**server read heavy**
Might be as high as 1: 10000
Can use redis or memcach to cach. A CDN also caches. 
Firewall after CDN to prevent bots, ip banning. 

Can deploy to a Kubernetes Cluster with Amazon EKS. Kubernetes means it is easy to provide containerized services. Can use autoscaling or predicitive scaling. 

Memcache is faster than redis as multi-threaded. Memchache limited data structures, and limited key-value size (1MB whereas Redis is 512MB). Memcache has clustering support, REDIS does not have native clustering support (need REDIS Sentinal for that). 




# Questions
## Image caching
Using NSCache

 Place in an extension of UIImage

```swift
var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func loadImage(urlString: String) {
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            imageCache.setObject(image, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()

    }
}
```

```
private var anyNetworkManager: AnyNetworkManager<URLSession>?

func test<T: NetworkManagerProtocol>(networkManager: T) {
    self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
}



let networkManager = AnyNetworkManager<URLSession>()
networkManager.fetch(url: <#T##URL#>, method: <#T##HTTPMethod#>, completionBlock: <#T##(Result<Data, Error>) -> Void#>)
```

`private var anyNetworkManager: AnyNetworkManager<URLSession>`
`init<T: NetworkManagerProtocol>(networkManager: T) {
    self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
}`
