# The Factory Pattern using Swift
## It actually makes sense to create things this way

![Photo by Manja Vitolic on Unsplash](Images/photo-1514888286974-6c03e2ca1dba.jpeg)<br/>
<sub>Photo by Manja Vitolic on Unsplash<sub>

Difficulty: Beginner | **Easy** | Normal | Challenging

The factory pattern provides an interface for creating objects in a superclass.

# A factory
In programming, a factory is an object for creating other objects. In Swift that object will typically be a class, and will produce a concrete instance of an object. In the [original book](https://en.wikipedia.org/wiki/Design_Patterns) it is declared that there is no strict factory pattern, but rather a factory method pattern and an abstract factory pattern.

The idea of this article is to cover both.

# Why use a factory
**Complexity**
Instantiations may be complex, and encapsulating instantiation can simplify creating concrete instances by defining a single place. This means that we can follow the Dependency Inversion Principle, and even open the door to dependency injection.

**Decouple the use of an object from creating it**
We can abstract our code, so where modifications are made to a class the client of that class can continue to use it without further modificaiton. By implementing to an interface we are provided with an abstraction rather than a concrete type, so code is protected from unwanted implementation details.

# The difference between a factory method and an abstract factory
The factory method is (well, obviously) a method, and an abstract factory is an object. Factory methods can be overridden in a subclass. An abstract factory is an object that can have multiple factory methods.

# The Factory Method Pattern 
A factory protocol will return new objects. In Swift we usually code to a [protocol](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18), an extension could provide a defailt implementation but there will usually be a concrete instance of this factory.

Since we are using **Swift** this overriding is NOT something that we would usually do. Overriding a function? I'd rather not, thank you.

In any case, here is the code. In this example we will create a factory to create a `Struct` that just holds the name as a `String`:


```swift
class PersonFactory {
    func createPerson() -> Person? {
        nil
    }
}

class DaveFactory: PersonFactory {
    override func createPerson() -> Person? {
        Person(name: "Dave")
    }
}

let dave = DaveFactory().createPerson()
print (dave)
```

# The Abstact Pattern
This particular guide is going to give you a definition for the abstract factory pattern.That is, the abstract:

"Provide an interface for creating families of related or dependent objects without specifying their concrete classes."

In this example we will create a factory to create a `Struct` that just holds the name as a `String`:

```swift
struct Person {
    var name: String
}

protocol PersonFactory {
    func createPerson() -> Person
}

class DaveFactory: PersonFactory {
    func createPerson() -> Person {
        Person(name: "Dave")
    }
}

let dave = DaveFactory().createPerson()
```

# The Factory example
We can set up a factory method for the property initialization, this lives inside an abstract factory.

```swift
class ViewControllerFactory {
    func createInfoViewControllerWith(item: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InformationViewController
        vc.item = item
        return vc
    }
}
```

of course we are in the Swift world, so coding to [protocols](https://medium.com/@stevenpcurtis.sc/protocols-in-swift-f46c31283b18) means that we can swap out the factory.

Here is the code:

```swift
protocol ViewControllerFactoryProtocol {
    func createInfoViewControllerWith(item: String) -> UIViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    let storyboard: UIStoryboard

    func createInfoViewControllerWith(item: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InformationViewController
        vc.item = item
        return vc

    }
    
    init(storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) {
        self.storyboard = storyboard
    }
}
```

so when we decide to test, we can use the following;

```swift
class MockFactory: ViewControllerFactoryProtocol{
    var didCreateInfo = false
    func createInfoViewControllerWith(item: String) -> UIViewController {
        didCreateInfo = true
        return UIViewController()
    }
}
```

which can then be elegantly swapped out in the test:

```swift
    func testExample() throws {
        let injectedFactory = MockFactory()
        let viewController = ViewController()
        viewController.viewControllerFactory = injectedFactory
        viewController.traverseToInfo()
        XCTAssertEqual((injectedFactory as MockFactory).didCreateInfo, true)
    }
```

# A Factory using Enum
It can make sense to create a complicated object using Swift's rather nice `Enum`. Now this isn't something I've used in production (for a URL) since I use my own [URLBuilder](https://medium.com/swlh/building-urls-in-swift-51f21240c537) for this functionality, but this gives a good example of using a factory in real code! 

```swift
protocol ResourceFactoryProtocol {
    func create() -> String
}

class ProductionResourceFactory: ResourceFactoryProtocol {
    func create() -> String {
        return "http://prodserver"
    }
}

class DevResourceFactory: ResourceFactoryProtocol {
    func create() -> String {
        return "http://devserver"
    }
}

protocol URLFactoryProtocol {
    func create() -> String?
}

class URLFactory: URLFactoryProtocol {
    enum Environment {
        case prod
        case dev
    }
    
    var env: Environment
    
    init(env: Environment) {
        self.env = env
    }
    
    func create() -> String? {
        switch self.env {
        case .prod:
            return ProductionResourceFactory().create()
        case .dev:
            return DevResourceFactory().create()
        }
    }
}

let urlFactory = URLFactory(env: .dev)
print (urlFactory.create())
```

# Conclusion

This is used in my article [Dependency Injection using Storyboards](https://github.com/stevencurtis/SwiftCoding/DIStoryboards)

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
