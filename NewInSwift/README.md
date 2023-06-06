# WWDC 2023: What's New In Swift
## It's getting great!

This article is intended as a companion to https://developer.apple.com/videos/play/wwdc2023/10164/ and does not replace it in any way.

## 
Instead of using difficult to read Ternary expressions that some can find hard to read we can use inline if statements.
```swift
struct Account {
    var balance: Double
}

let account = Account(balance: 500)

let status =
    if account.balance < 0 { "debt" }
    else if account.balance == 0 { "break even" }
    else { "Profit" }

print("Your account is in \(status).")
Similarly we can use switch statements. Something like the below shows how we might use this:
enum WeatherCondition {
    case sunny
    case cloudy
    case rainy
}

let weather = WeatherCondition.sunny

let advice =
    switch weather {
    case .sunny: "Feeling hot!"
    case .cloudy: "Oooooooh"
    case .rainy: "Don't forget your rain jacket"
    }

print("Today's advice: \(advice)")
```
## Improved error detection
I don't have a better example than Apple's here from the video. So I reproduce that here rather than bluffing anything else:
struct ContentView: View {
    enum Destination { case one, two }

    var body: some View {
        List {
            NavigationLink(value: .one) { //In 5.9, Errors provide a more accurate diagnostic
                Text("one")
            }
            NavigationLink(value: .two) {
                Text("two")
            }
        }.navigationDestination(for: Destination.self) {
            $0.view // Error occurs here in 5.7
        }
    }
}

## Value and Type Parameter Packs
Parameter Packs a way to write functions that accept an arbitrary number of arguments, making them variadic functions. Additionally, these arguments can be of different types. Parameter packs, when combined with concepts such as generics, can make the code much more flexible and reusable.
My example is taken from: https://github.com/apple/swift-evolution/blob/main/proposals/0393-parameter-packs.md

```swift
struct Pair<First, Second> {
    let first: First
    let second: Second
    init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
}

func makePairs<each First, each Second>(
  firsts first: repeat each First,
  seconds second: repeat each Second
) -> (repeat Pair<each First, each Second>) {
    (repeat Pair(each first, each second))
}

let pairs = makePairs(firsts: 1, "hello", seconds: true, 1.0)
print(pairs)
```

The struct isn't too difficult to understand. The function takes two value parameter packs (first and second) that have the pack expansion types repeat each First and repeat each Second. This particular function returns a tuple type (repeat Pair<each First, each Second>). The return matches the first of each of the firsts with the first of each of the seconds, and continues through the positions.
The makePairs function declares two type parameter packs, First and Second. The value parameter packs first and second have the pack expansion types repeat each First and repeat each Second, respectively. The return type (repeat Pair<each First, each Second>) is a tuple type where each element is a Pair of elements from the First and Second parameter packs at the given tuple position. The repeat keyword is used to indicate that the function returns multiple Pair objects.
The function is called with two lists: firsts: 1, "hello" and seconds: true, 1.0. This creates pairs of items: (1, true) and ("hello", 1.0).

## Macros
Macros are APIs just like types or functions. You can generate repetitive code at compile time, which can save you time!
Since they are essentially external programs run at the build phase, I think it makes more sense to create a separate article to cover these. But I'm very excited about them!

## Observation in SwiftUI
Apple are making things easier in terms of the observer design pattern. In beta, we can use the @Observable macro to a type declaration. 
There used to be quite a few things to remember to make things observable. The object conforms to ObservableObject and properties are decorated with the @Published property wrapper:
```swift
final class ViewModel: ObservableObject {
    @Published var name: String = ""
    
    init(name: String, needsRepairs: Bool = false) {
        self.name = name
    }
```
Here is an example using `@Observable`:
```swift
@Observable final class ViewModel {
    var name: String = ""
    
    init(name: String, needsRepairs: Bool = false) {
        self.name = name
    }
```

## Noncopyable structs and enums
We can suppress the implicit ability to copy a type for value types (struct and enum).
So instead of:
```swift
struct Person {
    var name: String
}

let person = Person(name: "T Swift")
let secondPerson = person
We can now
struct Person: ~Copyable {
    var name: String
}

let person = Person(name: "T Swift")
let secondPerson = person
```
Which at least in my Playground has this rather attractive error:

`expression failed to parse:
unknown error`

Sigh! You also get access to a dinit for value types, but cannot conform to other protocols (other than sendable). If you mark a function as consuming (rather than the default of borrowing), it must be the final use of the value.
The video itself says ~Copyable types are at an early point in their evolution, so that means there may well be exciting times ahead!

## Actors and concurrency
Tasks and actors are at the heart of Swift concurrency. In Swift 5.9 a particular actor can implement its own synchronization mechanism.
If you want to use a specific dispatch queue for an actor now you can!
```swift
actor Counter {
    private var value = 0
    private let queue: DispatchSerialQueue
    
    init(value: Int = 0, queue: DispatchSerialQueue) {
        self.value = value
        self.queue = queue
    }
    
    nonisolated var unownedExecutor: UnownedSerialExecutor { queue.asUnownedSerialExecutor() }

    func next() -> Int {
        let current = value
        value = value + 1
        return current
    }
    
    func total() -> Int {
        value
    }
}

let counter = Counter(queue: DispatchSerialQueue.main as! DispatchSerialQueue)

Task {
    for _ in 0..<1000 {
        await (counter.next())
    }
}

Task {
    for _ in 0..<1000 {
        await (counter.next())
    }
}

try await Task.sleep(nanoseconds: 1000000000)
await print(counter.total())
```

This is useful if you have other code that hasn't adopted actors as we guarantee the queue the work in the actor works on.
 
# Conclusion
That's so much new Swift stuff. I think I'll write a number of articles on these topics, particularly the macro type.
I'd love to hear from you if you have questions for me!
Subscribing to Medium using this link shares some revenue with me, or you might like to help me out by buying me a coffee on https://www.buymeacoffee.com/stevenpcuri.
