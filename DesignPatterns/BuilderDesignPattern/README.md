# The Builder Design Pattern in Swift
## Make it this way

![](Images/photo-1529268127899-36bf4524c254.jpeg)<br/>
<sub>Photo by Dan Gold<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.5, and Swift 5.2.4

## Prerequisites: 
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

# Terminology:
Design Pattern: a general, reusable solution to a commonly occurring problem

# The Builder Pattern in Swift
The builder pattern creates complex objects step by step, and the name brings to mind an assembly line where we are creating a complex object operation by operation. 

This avoids creating initializers that grow the hierarchy into a considerable number of subclasses, or creating a giant constructor that has many parameters - and neither makes for a great code review!

## The detail
The builder constructs objects in a stepwise fashion. This is great and helps avoid massive constructors!
This means
* reusability is enhanced since the same code can be used in various representations of objects
* The Single Responsibility Principle is followed, as complex construction code is separated from the object
* Objects are constructed in a stepwise manner

## The example in Swift
I've previously created a way to [build URLs in Swift](https://medium.com/swlh/building-urls-in-swift-51f21240c537), and that works fine for me.

An alternative could be to leverage the builder pattern. 

The method I might use follows:

```swift
class URLBuilder {
    var component: URLComponents!
    
    init() {
        var endpoint = URLComponents()
        endpoint.scheme = "https"
        endpoint.host = "reqres.in"
        component = endpoint
    }
    
    func set(path: String) -> URLBuilder {
        component.path = path
        return self
    }
    
    func addPageQuery(page: Int) -> URLBuilder {
        component.queryItems = [URLQueryItem(name: "page", value: page.description)]
        return self
    }
    
    func build() -> URL? {
        return self.component.url
    }
}


let url = URLBuilder()
    .set(path: "/api/users")
    .addPageQuery(page: 2)
    .build()
```

I prefer my [URL Builder](https://medium.com/swlh/building-urls-in-swift-51f21240c537), but this shows exactly how we can use the builder pattern to build something step-by-step! This is much better than alternatives with massive parameter lists, however, and does not expose the finished product while running the construction. No incomplete result? Sounds good to me!

As ever, it is prudent to code to a [protocol](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18), which would mean the `URLBuilder` would conform to a `BuilderProtocol` which contains the relevant functions, meaning that the builder could be swapped out using [Dependency Injection](https://medium.com/@stevenpcurtis.sc/learning-dependency-injection-using-swift-c94183742187) or similar.

## The Builder pattern with a director
A separate class called a director defines an order in which to execute the steps of a builder. In this pattern, the builder provides the implementation for each step. One advantage of using a director-class is that the details of construction are obfuscated from the client code, and therefore a director can be compatible with a variety of builder classes. 

This becomes a little more complex. Imagine that we use a builder to create a page for publication. We can inspect the code that we might use in the following code block:

```swift
protocol ContentBuilderProtocol{
    func build() -> String
    func set(title: String) -> ContentBuilderProtocol
    func set(body: String) -> ContentBuilderProtocol
}

class PlainPageBuilder: ContentBuilderProtocol {
    var page: String!
    
    init() {
        page = String()
    }
    
    func set(title: String) -> ContentBuilderProtocol {
        page += title
        return self
    }
    
    func set(body: String) -> ContentBuilderProtocol {
        page += body
        return self
    }
    
    func build() -> String {
        return page
    }
}

class PageBuilder: ContentBuilderProtocol {
    var page: String!
    init() {
        page = String()
    }
    
    func set(title: String) -> ContentBuilderProtocol {
        page += "#\(title)"
        return self
    }
    
    func set(body: String) -> ContentBuilderProtocol {
        page += body
        return self
    }
    
    func build() -> String {
        return page
    }
}

// without a director
let page = PageBuilder()
    .set(title: "MyTitle")
    .set(body: "This is a great article!")
    .build()
    
class PageDirector {
    let builder: ContentBuilderProtocol!
    init(builder: ContentBuilderProtocol) {
        self.builder = builder
    }
    
    func build() -> String {
        self.builder.set(title: "Hello")
        self.builder.set(body: "Text Body")
        return self.builder.build()
    }
}

let builder = PageBuilder()
let director = PageDirector(builder: builder)
director.build()

let plainBuilder = PlainPageBuilder()
let plainDirector = PageDirector(builder: plainBuilder)
plainDirector.build()
```

Note that the same director can be used, and the builder swapped out if we want a different type of page. That would be nice (wouldn't it?)

## The Builder pattern with keyPath
We can obtain the advantage of separating the construction code as separated from the object  (which is the [Single Responsibility Principle](https://medium.com/@stevenpcurtis.sc/apply-the-single-responsibility-principle-to-swift-2e633ee9a38f) in action!)

The sample code? Why here it is:

```swift
protocol KeypathConfiguration {}

extension KeypathConfiguration where Self: AnyObject {
    func with<T>(_ property: ReferenceWritableKeyPath<Self, T>, setTo value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
}

extension UIView: KeypathConfiguration {}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
            .with(\.textColor, setTo: .blue)
            .with(\.text, setTo: "This is a label")
            .with(\.textAlignment, setTo: .center)

        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
```

# Conclusion
I hope this article has been of help to you.

Happy coding!

If you've any questions, comments, or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
