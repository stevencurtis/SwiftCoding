# Lazy Closures Using Swift
## Delay that heavyweight work

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>

I've previously written an article about [Lazy Variables](https://stevenpcurtis.medium.com/the-lazy-variables-what-and-why-in-swift-619cb951ee0f) but feel that it doesn't go into enough detail about [closures](https://medium.com/swift-coding/swift-closures-c14cb7aa2170) to set up a property and I'm not that happy about the examples used.

Time has passed. I'm now a better coder. Can I write a better article?

Let's get into it.

# Terminology
Closure: A self-contained block of functionality that can be passed around
lazy: A keyword indicating that it is a property whose initial value isn’t calculated until the first time it’s used. Must be declared as a variable (with the var keyword)

# Using A Closure To Initialize A Property
## Why
When you want to set up a property but the initial value is relatively expensive to create, you might want to ensure you do it *just once* and *only when necessary*.

We can do that by **using a closure*.

## The Example

If we create some code to read a `json` file and output a `String` if the file is successfully read. This isn't necessary production-ready code for reading a file (hey, it works) but is a good example for this particular article.

```swift
final class FileReader {
    func readFile() -> String? {
        do {
            guard let fileUrl = Bundle.main.url(
                forResource: "fav",
                withExtension: "json"
            ) else {
                fatalError()
            }
            let text = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
            return text
        } catch {
            return nil
        }
    }
}

let reader = FileReader()
print(reader.readFile()) // Optional("{ \"favourites\": [] }\n")
```

If we call `readFile` repeatedly the system has to go away and read the file multiple times. Since we know that `fav.json` isn't going to change (it's a static file here) in between execution that is rather wasteful indeed!

## Using a closure
Here we are using a closure to make sure that we are only reading that file a single time. the `lazy` keyword means that the closure is only created once and `()` means that the property is called. Take a look:

```swift
final class FileReader {    
    lazy var fileContents: String? = {
        do {
            guard let fileUrl = Bundle.main.url(
                forResource: "fav",
                withExtension: "json"
            ) else {
                fatalError()
            }
            let text = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
            return text
        } catch {
            return nil
        }
    }()
}
```

# Conclusion
Lazy loading. It's a good thing!

I hope this example has made things a bit clearer for those reading these article.

Happy coding!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
