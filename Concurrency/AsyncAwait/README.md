# Swift Concurrency for Beginners: Getting Started with Async/Await
## Wait for this!

Ever since Swift 5.5 we have had access to fun concurrency features in Swift.
I think there is a crucial part of this, and it's Swift's `async/await` syntax. This article is intended to provide a beginner friendly introduction to this syntax and explain how it might be used in a practical way.

# Before we start
Difficulty: **Beginner** | Easy | Normal | Challenging
This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites:
You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)
Some familiarity with [GCD and concurrency](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2) would be useful for the reader

## Keywords and Terminology:
Asynchronous: Work that can be run out of order, and usually have a callback when completed.
async/await: An alternative to completion handlers, a coroutine model that allows execution to be suspended and resumed.

## The background
I've already written a simple [example article about async/await](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fuse-async-await-with-urlsession-b46b3e5130ab).  I think it's time to go further into this topic and think about how we might use async/await in our projects.

# Asynchronous Programming: What Is It?
Concurrency is a crucial aspect of modern programming which allows developers to perform multiple tasks efficiently.
The concurrency features available since Swift 5.5 simplify asynchronous programming for iOS developers.
Completing multiple tasks while avoiding blocking the main thread? That would mean that your App would remain responsive even when performing network requests (or complex computations).

# Callbacks and Completion Handlers
I've created a SwiftUI project that calls https://api.chucknorris.io/jokes/random. This code uses completion handlers in order to handle asynchronous tasks (in this case making the network call). It is difficult to reason about this code, and if we were introduce further network calls it would get more confusing. It simply isn't a great way to code (although it works fine).

```swift
final class JokeViewModel: ObservableObject {
    @Published var state: State = .initial
    
    enum State {
        case error(Error)
        case initial
        case joke(String)
        case loading
    }

    func fetchJoke() {
        state = .loading
        getJoke { data, _, _  in
            let decoder = JSONDecoder()
            guard let data = data,
                  let result = try? decoder.decode(JokeData.self, from: data)
            else { return }
            DispatchQueue.main.async {
                self.state = .joke(result.value)
            }
        }
    }
    
    private func getJoke(completion: @Sendable @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        let request: URLRequest = .init(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}
```

Don't worry too much about that [force unwrap](https://stevenpcurtis.medium.com/avoiding-force-unwrapping-in-swift-6dae252e970e), this isn't production code (essentially don't worry, I can code).

# Refactor
There's a great feature in Xcode. The refactor menu

[Images/refactor.png](Images/refactor.png)<br>

Which in this case gives the following code:

```swift
private func getJoke() async throws -> (Data, URLResponse) {
    let url = URL(string: "https://api.chucknorris.io/jokes/random")!
    let request: URLRequest = .init(url: url)
    return try await withCheckedThrowingContinuation { continuation in
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}
```

Which…isn't quite right.
At least in this case we are going to need to understand a little more about `async/await` to be able to convert this code to the concurrency model Apple have so generously provided us.

# Learning about async/await
The basics are set out here. How do we define async functions, await them and deal with errors. Read on to find out!

## Defining Async Functions
An async function is denoted by marking the function with the async keyword.
When such a function is called, it returns a Task instance which represents the ongoing operation.

```swift
func fetchData() async -> Data {
    // Asynchronous operation to fetch data
}
```

## Awaiting Asynchronous Functions 
To wait for an async function to complete you use the `await` keyword. Calling `await` within an `async` context maintains control flow, so you will typically be within an `async` function to `await` the result of another `async` function.

This is because when we await an `async` function we are communicating that the current async operation depends on the result of the awaited function. Because we depend on the result of the await function execution is paused until the function completes.

```swift
func processData() async {
    let data = await fetchData()
    // Process the data
}
```

## Swift's MainActor
We wish to update the UI on the main thread to prevent unseemly crashes or issues in the UI. A class or function can be annotated with @MainActor to ensure that the code is run on the main thread.

```swift
@MainActor
func updateUI() {
    // Update the user interface
}
```

## Error Handling with Async/Await
We can handle errors within `async/await` by using the standard [try-do-catch](https://betterprogramming.pub/error-handing-in-swift-dda6e3fb1c65) error handling mechanism of Swift. If an `async` function throws an error, it can be caught and handled as in this example:

```swift
func handleError() async {
    do {
        let data = try await fetchData()
        // Process the data
    } catch {
        // Handle the error
    }
}
```

# Creating an async/await example
This is right in the repo too!
## Making the call
We can create a function that returns a String. This feels more simple than the closure-based syntax above, but we use the async keyword.

```swift
private func getJoke() async throws -> String {
    let url = URL(string: "https://api.chucknorris.io/jokes/random")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()
    let result = try decoder.decode(JokeData.self, from: data)
    return result.value
}
```

In this case `getJoke()` will throw an error if something goes wrong with the coding (although you might argue that this function is doing two things, a network call and decoding the data which I'm not sure is great, but nevermind).

## Get that joke
When we call `getJoke()` we need to do so from an `async` context. We `await` the result of getting the joke, as might be expected. This particular function uses a state to communicate with the view, and the state is an enum which can pass data to the view.

```swift
func fetchJoke() async {
    state = .loading
    do {
        let jokeText = try await getJoke()
        state = .joke(jokeText)
    } catch {
        state = .error(error)
    }
}
```

# The view awaits
The view awaits the result of `fetchJoke` when the user taps on the screen. Task is used to execute `viewModel.fetchJoke()` asynchronously without blocking the main thread. This is a usage of `Task` to bridge an asynchronous to synchronous context. We wait on the result of `fetchJoke` before proceeding, but this is within the `Task` context so does not block the UI of the application since the view does not await the result of fetchJoke but the `Task` does.

```swift
.onTapGesture {
    Task {
        await viewModel.fetchJoke()
    }
}
```

# The full code
Some don't like to go to the repo for the code. For you, I'll copy and paste the code right here. I hope that helps you.

```swift
import SwiftUI

@MainActor
final class JokeViewModel: ObservableObject {
    @Published var state: State = .initial
    
    enum State {
        case error(Error)
        case initial
        case joke(String)
        case loading
    }

    func fetchJoke() async {
        state = .loading
        do {
            let jokeText = try await getJoke()
            state = .joke(jokeText)
        } catch {
            state = .error(error)
        }
    }
    
    private func getJoke() async throws -> String {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode(JokeData.self, from: data)
        return result.value
    }
}

struct JokeData: Codable {
    let value: String
}
```

Which would not be good without the view:

```swift
struct ContentView: View {
    @StateObject var viewModel = JokeViewModel()

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .initial:
                Text("Tap to fetch joke")
            case .joke(let jokeString):
                Text(jokeString)
                    .frame(width: 200, height: 200)
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .onTapGesture {
            Task {
                await viewModel.fetchJoke()
            }
        }
    }
}
```

# Conclusion
async/await isn't that hard. Actually it does depend on where you use it and what you use case is. So, really it is up to you to think about how you might use these great features of Swift.
Happy coding!
