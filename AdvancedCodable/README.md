# Advanced Codable: Missing Fields In Arrays and More (Swift)
## Decode without try

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 14.2, and Swift 5.7.2

This article is "inspired" by the current implementation of `Decodable`. If we have missing fields in an Array which we wish to decode, what are we to do? 
Read on to find out what can possibly be done about this!

# Prerequisites
You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
It would be great to have some background [regarding decoding JSON](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fdecode-json-like-a-pro-40bdb75f4965)

# Terminology
Decodable: A type that can decode itself from an external representation
JSON: JavaScript Object Notation, a lightweight format for storing and transporting data

# The Code
## The Basics
**try** this
When we take a response (json, usually) from a backend we can use `Decodable` to do just that.
```swift
func decode<T: Decodable>(data: Data) -> T? {
do {
return try JSONDecoder().decode(T.self, from: data)
} catch {
// will silently fail and return nil
return nil
}
}
```

I can use Swift to make a basic call to the backend

```swift
func basicCall() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos/8")!
    
    httpManager?.get(url: url, completionBlock: {res in
        print (res)
        
        switch res {
        case .success(let data) :
            let _: ToDoModel? = self.decode(data: data)
            break
        case .failure:
            break
        }
    })
}
```

Which is then processed with this model

```swift
struct ToDoModel: Codable {
    let completed: Bool
    let id: Int
    let title: String
    let userId: Int
}
```

With those basics out of the way, for the rest of this article I shall use `json` files within the App bundle. If you are interested, you can checkout the repo and the `Bundle-decode` file.

## Snake cased keys and dates
We can process more complex responses. Snake cased keys and dates are one example of more difficult data that needs to be processed.

JSONdecoder has `keyDecodingStrategy` and `dateDecodingStrategy` to help us out! 

Now an "ordinary" ISO8601Date (such as "2020-02-06T00:33:01Z") can be handled with `decoder.dateDecodingStrategy = .iso8601`!

Glory!

```swift
static var snakeCaseISO8601Date: JSONDecoder = {
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
return decoder
}()
```

But what if your endpoint features "2019-01-18T10:15:32.250Z" - like in the following JSON string:

```
[
  {
      "timestamp": "2019-01-18T10:15:29.979Z",
      "unique_key": "policy:dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe"
  },
    {
        "timestamp": "2019-01-18T10:15:32.250Z",
        "unique_key": "transaction:dev_tx_000000BansDm7JjbiFjqm6TTTFPdo"
  }
]
```

still in Zulu time but we are including **milliseconds**. The standard .iso8601 decoding strategy will not recognise this as ISO8601-formatted.

Oh dear!

So we can use a custom decoder - 

```swift
extension JSONDecoder {
let decoder = JSONDecoder()
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
decoder.keyDecodingStrategy = .convertFromSnakeCase
decoder.dateDecodingStrategy = .formatted(dateFormatter)
return decoder
}()
}
```

and since we are trying to get rid of the annoying underscore_ in the variable name when we are converting this into Swift, we can use the `CodingKey` protocol to make this happen!

```swift
struct TimeModel: Codable {
    let timeStamp: Date
    let uniqueKey: String
    
    enum CodingKeys: String, CodingKey {
      case timeStamp = "timestamp"
        case uniqueKey = "uniqueKey"
    }
}
```

In the repo I decode `json` `Strings` from a bundle. In order to use the modified `JSONDecoder` that I use would be updated too.

The update of that? It's right here:

```swift
extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, with decoder: JSONDecoder = JSONDecoder()) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw ErrorModel(errorDescription: "\(file) missing in \(self).")
        }

        guard let data = try? Data(contentsOf: url) else {
            throw ErrorModel(errorDescription: "\(file) missing in \(self).")
        }

        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw ErrorModel(errorDescription: "\(file) could not be decoded from \(self) with error: \(error).")
        }
    }
}
```

## An array missing fields
You might have a field in a rather large list that is missing a field or two.

```swift
[
  {
      "timestamp": "2019-01-18T10:15:29.979Z",
      "unique_key": "policy:dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe"
  },
    {
        "unique_key": "transaction:dev_pol_000000BsrbGm3JjbiFjqm6TTTFPdo"
  },
    {
        "timestamp": "2019-01-18T10:15:32.250Z",
        "unique_key": "transaction:dev_tx_000000BansDm7JjbiFjqm6TTTFPdo"
  }
]
```

It's not enough just to try to process the fields as above.

That is, the following code block:
```swift 
func missingFieldsFile() {
let times: [TimeModel] = try! Bundle.main.decode([TimeModel].self, from: "TimesMissingTimeStamp.json", with: JSONDecoder.snakeCaseMillisecondsISO8601Date)
print(times)
}
```

will generate a `DecodingError` and a crash for the user.

We need to think about a better strategy in order to create the right experience for the user.

One way of handling this is to create an optional field in the model for that particular type. The problem comes when we **require** that field for a view, and therefore just wish to skip the object and move on. There must be a good solution for this.

So could we, I don't know, create our own `decoder` for this? The following implementation uses the `TimeModel` declared above, but also **RUNS FOREVER IF WE ARE MISSING A SINGLE TIMESTAMP SO DON'T DO THIS**.

```swift
// Don't do this
struct TimeModelInfiniteLoop: Codable {
    var times: [TimeModel]
    init(from decoder: Decoder) throws {
        var times = [TimeModel]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let route = try? container.decode(TimeModel.self) {
                times.append(route)
            }
        }
        self.times = times
    }
}
```

What is happening here is `decoder.unkeyedContainer()` does not move onto the next value if one is missing. You'd want an else and skip the value if you can't append the route to the times array.

Can we create a solution?

It seems unfortunate, and like a hack. But we create `DummyCodable` struct.

```swift
struct TimeModelCodable: Codable {
    var times: [TimeModel]
    init(from decoder: Decoder) throws {
        var times = [TimeModel]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let route = try? container.decode(TimeModel.self) {
                times.append(route)
            }
            else {
                _ = try? container.decode(DummyCodable.self)
            }
        }
        self.times = times
    }
}

private struct DummyCodable: Codable {}
```

This suggestion is from https://github.com/apple/swift-corelibs-foundation/issues/4414, and although it seems that there is a better solution in the works from Swift wizards so we shall see.

# Conclusion
I hope this article has been of help to you.

Happy programming!

Subscribing to Medium using this link shares some revenue with me.
You might even like to give me a hand by buying me a coffee https://www.buymeacoffee.com/stevenpcuri.
If you’ve any questions, comments or suggestions please hit me up on Twitter 
