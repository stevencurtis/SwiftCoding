# Overcoming Default Arguments in a Protocol
## Overcome the main Swift limitation for protocol

![Photo by Sebastian Herrmann on Unsplash!](Images/0*UzQ0Cqb-1ag7fc4b.png)

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 12, and Swift 5.3

Protocol extensions to the rescue!
This article contains a real example for you that is used in production Apps. Don't say I don't spoil you (because I don't).

Difficulty: Beginner | Easy | Normal | Challenging

# Prerequisites:
- Be able to produce a "Hello, World!" iOS application (guide [HERE](https://medium.com/@stevenpcurtis.sc/your-first-swift-application-without-a-mac-79598ad839f8))
- Use of extensions in Swift (guide [HERE](https://medium.com/@stevenpcurtis.sc/extensions-in-swift-68cfb635688e))
- Use of protocols in Swift (Guide [HERE](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18))

# Terminology
Extensions: Extensions add new functionality to a class, struct, enum or protocol

# The issue
When you use a function, or initialise a class you might well use *default arguments*. 
This is incredibly useful, and I've used just such a feature when I've created a [Network Manager](https://medium.com/r/?url=https%3A%2F%2Fgithub.com%2Fstevencurtis%2FNetworkManager).

Now I want this to work with [REST APIs](https://medium.com/@stevenpcurtis.sc/rest-and-crud-ca5522bf3fc3), meaning I would want this to work for `GET,` `POST``, `PUSH`, `PUT`, `DELETE` and `PATCH` - but for some of these you might need to provide data in the body of the request. However for the `GET` request we shouldn't add any data.

So If we create a [protocol](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18) (which helps to enable good testing, and is the way we should be coding Swift applications after all) as follows:

```swift
public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }
    func cancel()
    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String: Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void)
}
```

we will only be able to access fetch if we provide data, and worse a *token*. But I don't want to use a token in my reusable Network Layer!

You might try to use [default arguments](https://medium.com/@stevenpcurtis.sc/default-arguments-in-swift-b5f3740e2259) and this would be a good strategy to follow

```swift
func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String? = nil, data: [String: Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void)
```
note there is only one small change here - adding `= nil` to the token parameter. This gives the following error:

`Default argument not permitted in a protocol method`

What a disaster! So how can we overcome this issue?
The solution is to use a [protocol extension](https://medium.com/@stevenpcurtis.sc/protocol-extensions-in-swift-3c8b1127701e)!

Here is the rub - you can add *default arguments to a protocol extension! *
Here is the full NetworkManagerProtocol

Here is the full NetworkManagerProtocol

```swift
public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }
    func cancel()
    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String: Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void)
}

public extension NetworkManagerProtocol {
    func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, data: [String: Any]? = nil, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetch(url: url, method: method, headers: headers, token: token, data: data, completionBlock: completionBlock)
    }
}
```

Now this can be accessed through the protocol, where you need to provide a header and a token OR you can do so through the extension (and note that the extension calls the main protocol signature too, and just fills out those default arguments).

Here are two ways you might use these arguments - now isn't that a little bit awesome?

```swift
networkManager?.fetch(url: url, method: .delete, headers: [:], token: nil, data: nil, completionBlock: { result in
    switch result {
    case .success(let data):
        // do something with data
    case .failure(let error):
        // do something with errpr
    }
})

networkManager?.fetch(url: url, method: .put, headers: [:], token: nil, data: nil, completionBlock: { result in
    switch result {
    case .success(let data):
        // do something with data
    case .failure(let error):
        // do something with errpr
    }
})
```

# Conclusion
Due to the way Swift works you can't add default arguments in a protocol method.

But you *can* use them in protocol extensions. 

There are quite a number of situations where this might be helpful, and this article has walked you through on of my examples.
Now I hope article has helped you out, and that you are doing OK on your coding journey.

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
