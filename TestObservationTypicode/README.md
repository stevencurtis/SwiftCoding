# Learning to Unit Test The Observable Macro
## No more Combine! Observable FTW

During  WWDC 2023 Apple swift developers had the opportunity to learn about the shiny new Observation Framework.

That means we no longer need to test `@Published` properties to maintain full test coverage. That's quite nice isn't it?

# Unit Testing With Combine
I have simple project that takes an endpoint (https://jsonplaceholder.typicode.com/posts) and displays them on the screen. There's a simple viewModel to move the network call out of the view, and a simple service in order to use dependency injection for `URLSession`.
It's 80 lines of code.

```swift
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            LazyVStack{
                ForEach(viewModel.posts) { post in
                    Text(post.title)
                }
            }
        }
        .onAppear {
            viewModel.getPosts()
        }
        .alert(
            "Login failed.",
            isPresented: Binding(get: { viewModel.error != nil }, set: { _,_ in viewModel.error = nil })
        ) {
            Button("OK") {
                // TODO: retry mechanism
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Something went wrong")
        }
        .padding()
    }
}

final class ViewModel: ObservableObject {
    @Published var error: PostError?
    @Published private(set) var posts: [Post] = []
    private let service: PostServiceProtocol
    init(service: PostServiceProtocol) {
        self.service = service
    }
    
    @MainActor
    func getPosts() {
        Task {
            do {
                let posts = try await service.getPosts().map { $0.toDomain() }
                self.posts = posts
            } catch {
                self.error = error as? PostError
            }
        }
    }
}
```

Sure, I wouldn't usually hardcode the url in the service and I'd probably use [my own network client](https://medium.com/r/?url=https%3A%2F%2Fgithub.com%2Fstevencurtis%2FNetworkClient) but to make this slightly easier to follow I've omitted that in favour of using plain URLSession. There's no loading before the screen is populated, but I hope you can accept that for this particular solution.
Here is what we've come for. The traditional way of testing the viewmodel. There is only a single test for `getPosts` so the class contains all of the properties, but this works to test the viewModel.


```swift
import Combine
@testable import TestObservationOldWay
import XCTest

final class ViewModelTests: XCTestCase {
    private var cancellables: [AnyCancellable] = []

    func testGetPostsSuccess() async {
        let expectation = XCTestExpectation()
        let mockPost = [PostDTO(title: "test")]
        let mockPostService = MockPostService()
        mockPostService.posts = .posts(mockPost)
        let viewModel = ViewModel(service: mockPostService)

        viewModel.$posts
            .dropFirst()
            .sink { post in
                XCTAssertEqual(post, mockPost.map { $0.toDomain() })
                expectation.fulfill()
            }
            .store(in: &cancellables)
        await viewModel.getPosts()

        await fulfillment(of: [expectation])
    }
    
    func testGetPostsError() async {
        let expectation = XCTestExpectation()
        let mockError = PostError.invalidURL
        let mockPostService = MockPostService()
        mockPostService.posts = .error(mockError)
        let viewModel = ViewModel(service: mockPostService)

        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertEqual(error, mockError)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await viewModel.getPosts()

        await fulfillment(of: [expectation])
    }
}
```

The tests work fine! The viewmodel updates the `@Published` property that holds the posts, we listen to the changes emitted by the publisher and assign a `Cancellable` property to `viewModel.$posts.sink {} ` 
But can't we do a little bit better by implementing the shiny Observation Framework? Once we migrate we can't create a listener to a property on the viewmodel as there is no publisher to listen to.

# Unit Testing With Observation
We can now update the view and view model with the observation Framework.

```swift
struct ContentView: View {
    var viewModel: ViewModel
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.posts) { post in
                    Text(post.title)
                }
            }
        }
        .onAppear {
            viewModel.getPosts()
        }
        .alert(
            "Login failed.",
            isPresented: Binding(get: { viewModel.error != nil }, set: { _,_ in viewModel.error = nil })
        ) {
            Button("OK") {
                // TODO: retry mechanism
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Something went wrong")
        }
        .padding()
    }
}

import Observation

@Observable
final class ViewModel {
    var error: PostError?
    private(set) var posts: [Post] = []
    private let service: PostServiceProtocol
    init(service: PostServiceProtocol = PostService()) {
        self.service = service
    }
    
    @MainActor
    func getPosts() {
        Task {
            do {
                let posts = try await service.getPosts().map {
                    $0.toDomain()
                }
                self.posts = posts
            } catch {
                self.error = error as? PostError
            }
        }
    }
}
```

Then I want to test the posts and errors, as before and here is the code:

```swift
@testable import TestObservationObservation
import XCTest

final class ViewModelTests: XCTestCase {
    func testGetPostsSuccess() async {
        let expectation = XCTestExpectation(description: "Posts updated")

        let mockPost = [PostDTO(title: "test")]
        let mockPostService = MockPostService()
        mockPostService.posts = .posts(mockPost)
        let viewModel = ViewModel(service: mockPostService)
        
        withObservationTracking {
            _ = viewModel.posts
        } onChange: {
            expectation.fulfill()
        }

        await viewModel.getPosts()
        await fulfillment(of: [expectation], timeout: 0.1)
        XCTAssertEqual(viewModel.posts, mockPost.map { $0.toDomain() } )
    }
    
    func testGetPostsError() async {
        let expectation = XCTestExpectation(description: "Posts updated")

        let mockError = PostError.invalidURL
        let mockPostService = MockPostService()
        mockPostService.posts = .error(mockError)
        let viewModel = ViewModel(service: mockPostService)
        
        withObservationTracking {
            _ = viewModel.error
        } onChange: {
            expectation.fulfill()
        }
        
        await viewModel.getPosts()
        await fulfillment(of: [expectation], timeout: 0.1)

        XCTAssertEqual(viewModel.error, mockError)
    }
}
```

Let us take the first test, and see how that has been implemented.


```swift
func testGetPostsSuccess() async {
        let expectation = XCTestExpectation(description: "Posts updated")

        let mockPost = [PostDTO(title: "test")]
        let mockPostService = MockPostService()
        mockPostService.posts = .posts(mockPost)
        let viewModel = ViewModel(service: mockPostService)
        
        withObservationTracking {
            _ = viewModel.posts
        } onChange: {
            expectation.fulfill()
        }

        await viewModel.getPosts()
        await fulfillment(of: [expectation], timeout: 0.1)
        XCTAssertEqual(viewModel.posts, mockPost.map { $0.toDomain() } )
    }
```

Observation tracking is an effective way to detect when the `posts` property is actually updated. So we use [withObservationTracking](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.apple.com%2Fdocumentation%2Fobservation%2Fwithobservationtracking%28_%3Aonchange%3A%29) so we know when the property has changed, in this case the posts property.

Using an expectation with a short timeout means we ensure that the property has been correctly updated so we can compare the expected posts with the actual posts, the `await` keyword being (well) key to ensuring that we wait until the updates have happened.

Just a note, we need to ensure that `getPosts` is called after `withObservationTracking` is set up as we need to ensure that we don't proceed to the assertion until both the method has completed and the property has been updated. The `onChange` closure is designed to notify that a change has occurred not to provide the state after the change, and since the closure can execute in a context where the system hasn't fully reconciled all the changes to the observed properties we perform the `XCTAssertEqual` test outside the closure.

# Conclusion

This transition to `@Observable` is more than just a syntactical change - it's a step towards more efficient and readable code. As with any new tool, it might take a bit of practice to get comfortable, but the benefits of a simplified approach to state management and testing are well worth the effort.
I hope this article has provided you with a clear path to start using the `@Observable` macro in your own projects.
