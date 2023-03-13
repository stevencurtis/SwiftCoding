# How To Use Async let To Simplify Asynchronous Fetching in Your SwiftUI App
## Simplify that code!


Async let was introduced with [Swift 5.5](https://github.com/apple/swift-evolution/blob/main/proposals/0317-async-let.md) and is a fantastic opportunity to write simplified asynchronous code.

I like guides with full code examples. So this is the article I've written that provides just that.

# Before we start

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 14.2, and Swift 5.7.2 

## Prerequisites:
* You will be expected to be able to create a [SwiftUI project](https://stevenpcurtis.medium.com/use-swiftui-in-a-playground-4f8a74181593)

## Keywords and Terminology:
async: A keyword introduced in Swift 5.5 which defines an asynchronous operation
Task: A task represents a unit of work that can be executed asynchronously, independently of the main thread of the application.

# The example
I like to use https://api.chucknorris.io/jokes/random as a simple backend substitute in order to check how we might use async let in a small sample project.

## Content View
The view is a dumb view that when the user taps the screen fetches an image. While the image is being loaded a ProgressView is displayed to (hopefully) be replaced by an image.
That if let else tree? Yeah, it's there to attempt to make this View extremely easy to read (through bad coding). Feel free to come at me in the comments (for this I'd usually have a state enum because it makes no sense to have isLoading off while the jokeText is nil but never-mind).

```swift
struct ContentView: View {
    @StateObject var viewModel = ImageViewModel()

    var body: some View {
        ZStack {
            if let joke = viewModel.jokeText {
                Text(joke)
                    .frame(width: 200, height: 200)
            } else if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let error = viewModel.error {
                Text(error.localizedDescription)
            } else {
                Text("Tap to fetch joke")
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

## JokeViewModel
The view model is an [ObservableObject](https://stevenpcurtis.medium.com/what-is-the-published-property-wrapper-37497124befe) which means that it emits when the object has changed - idea when we are using a loading boolean and have an image which might be displayed. 
It makes sense to apply `@MainActor` to the class definition since all of the properties and methods should be accessed on the main thread in order to update the UI. 
Way down in the `fetchJoke` function we have the subject of this article. That `async let`.

```swift
@MainActor
final class ImageViewModel: ObservableObject {
    @Published var jokeText: String?
    @Published var isLoading = false
    @Published var error: Error?

    func fetchJoke() async {
        do {
            isLoading = true
            async let fetchedJoke = getJoke()
            jokeText = try await fetchedJoke
            isLoading = false
        } catch {
            isLoading = false
            self.error = error
        }
    }

    private func getJoke() async throws -> String {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()

        let result = try decoder.decode(Joke.self, from: data)
        return result.value
    }
}

struct Joke: Codable {
    let value: String
}
```

## Alternatives
We could use Task to achieve the same aim here. We would use the same view and change the viewmodel with:

```swift
@MainActor
final class ImageViewModel: ObservableObject {
    @Published var jokeText: String?
    @Published var isLoading = false
    @Published var error: Error?

    func fetchJoke() {
        isLoading = true
        Task {
            do {
                jokeText = try await getJoke()
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
    private func getJoke() async throws -> String {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()

        let result = try decoder.decode(Joke.self, from: data)
        return result.value
    }
}

struct Joke: Codable {
    let value: String
}
```

which operates in pretty much the same way, but in this case seems to be more elegant code. 

## So choose which solution?
I mean, at least we are avoiding blocking the UI!
Let us see some advantages and disadvantages of `async let`

## Advantages of async let
Simplification `async let` makes it easier to write and read code that depends on multiple asynchronous operations. It allows you to declare a set of asynchronous operations that should be executed concurrently, and then await their results in a single line of code.
Improved performance: By allowing multiple asynchronous operations to execute concurrently, `async let` can improve the performance of your code by reducing the amount of time it takes to complete all of the operations.

That second one, "improved performance" is problematic here as we are not taking full advantage of the language feature. For the above example, we might choose not to use `async let` since there are some disadvantages that we need to suffer for using it.

## Disadvantages of async let
Overuse: Like any language feature, `async let` can be overused. While it's great for simplifying the code that depends on multiple asynchronous operations, using it too often can make your code harder to read and understand.
Debugging difficulties: If something goes wrong with one of the asynchronous operations in an `async let` block, it can be harder to track down the source of the problem. This is because multiple operations are running concurrently, which can make it harder to determine which operation caused the error.
Race conditions: If you're not careful, using `async let` can lead to race conditions in your code. This can happen if two or more asynchronous operations modify the same data at the same time, causing unexpected behaviour.
Not supported in older versions of Swift: `async let` is a new language feature introduced in Swift 5.5, which means that it's not available in older versions of Swift. This can be a problem if you need to maintain compatibility with older versions of iOS or macOS.

## The async let project
To take advantage of `async let` I've set up a new project. This one can benefit from the performance benefits of allowing multiple asynchronous calls to execute concurrently.
This means we are going to have 3 Joke objects from the same call. Let's take a look!
We can swap out our viewmodel for the following:

```swift
import SwiftUI

@MainActor
final class ImageViewModel: ObservableObject {
    @Published var jokesText: [String]?
    @Published var isLoading = false
    @Published var error: Error?
    
    func fetchJoke() async {
        do {
            isLoading = true
            async let firstJoke = getJoke()
            async let secondJoke = getJoke()
            async let thirdJoke = getJoke()
            jokesText = try await [firstJoke, secondJoke, thirdJoke]
            isLoading = false
        } catch {
            isLoading = false
            self.error = error
        }
    }
    
    private func getJoke() async throws -> String {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        
        let result = try decoder.decode(Joke.self, from: data)
        return result.value
    }
}

struct Joke: Codable {
    let value: String
}
```

The joke is the same, but this time we get three of them! Awesome! These calls are performed in parallel, making the most of our system resources (which is nice)
By using `async let` Execution will start as soon as we defined an `async let` so no unnecessary waiting around.
Now we are using an array of these `Joke` we can make a minor update to our view.

```swift
struct ContentView: View {
    @StateObject var viewModel = ImageViewModel()

    var body: some View {
        ZStack {
            if let joke = viewModel.jokesText {
                VStack {
                    Text(joke[0])
                    Text(joke[1])
                    Text(joke[2])
                }
            } else if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let error = viewModel.error {
                Text(error.localizedDescription)
            } else {
                Text("Tap to fetch joke")
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
Like any language tool we need to think about whether any particular tool solves the problem we are approaching.

Thank you for reading.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
