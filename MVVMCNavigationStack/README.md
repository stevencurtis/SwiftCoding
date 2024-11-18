# Practical MVVM-C in SwiftUI
## A Clear Separation of Concerns

It's been a challenge to use MVVM-C using SwiftUI, and many developers have fallen back to using UIKit for navigation and SwiftUI for Views.

It's understandable why they might do this, as testability and separation of concerns is important for a well architected app.

Yet something changed in iOS 16. `NavigationStack` and `NavigationPath` give us the flexibility to separate navigation from the view. My current approach is to use the coordinator pattern for a SwiftUI project, and this article covers converting my existing approach to pure SwiftUI.

If you want to download this project https://github.com/stevencurtis/SwiftCoding/tree/master/MVVMCNavigationStack

# The MVVM-C Implementation
This is a rather simple app. There are three screens, the first containing two buttons. The buttons take you to the following screens: a user screen and an order screen.

There aren't any other functions, it's just a simple implementation to demonstrate navigation.

Here are the screens:

[Images/CombinedImageWithSeparators.png](Images/CombinedImageWithSeparators.png)<rb>

So bring on the code!

## The Top Level

At the top level we instantiate our `AppCoordinator` at the root of the project. 

It's defined as a `StateObject` as the root of the project creates and owns the `AppCoordinator` , and a `StateObject` ensures the coordinator is only initialized once regardless of how many times the view hierarchy re-renders.

```swift
@main
struct NavigationProjectApp: App {
    @StateObject private var coordinator = AppCoordinator(
        screenFactory: DefaultScreenFactory()
    )

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
```

## The AppCoordinator
The AppCoordinator does the heavy lifting here of the navigation.

```swift
final class AppCoordinator: ObservableObject {
    @Published private var navigationPath = NavigationPath()
    private let screenFactory: ScreenFactory

    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }

    func start() -> some View {
        setupNavigationStack()
    }
    
    private func makeHomeView() -> some View {
        screenFactory.makeHomeView(coordinator: self)
    }
    
    private func setupNavigationStack() -> some View {
        NavigationStack(path: Binding(
            get: { self.navigationPath },
            set: { self.navigationPath = $0 }
        )) {
            makeHomeView()
                .navigationDestination(for: User.self) { user in
                    self.screenFactory.makeUserView(for: user)
                }
                .navigationDestination(for: Order.self) { order in
                    self.screenFactory.makeOrderView(for: order)
                }
        }
    }

    func goToUser(_ user: User) {
        navigationPath.append(user)
    }

    func goToOrder(_ order: Order) {
        navigationPath.append(order)
    }
}
```

The `AppCoordinator` conforms to `ObservableObject` so views can observe state changes, and `navigationPath` is `Published` so SwiftUI can observe when the navigation is updated.

The `ScreenFactory` means view creation is decoupled from the coordinator, and uses dependency injection so can be separately tested.

`goToUser` and `goToOrder` provide clear and focused interfaces for navigating to views, encapsulating the logic for modifying the `navigationPath`.

`start` is the entry point for the app, returning a View that sets up the navigation stack.

## The ScreenFactory
The `ScreenFactory` provides methods to create View in a way decoupled from the coordinator.

```swift
protocol ScreenFactory {
    func makeHomeView(coordinator: AppCoordinator) -> HomeView
    func makeOrderView(for order: Order) -> OrderView
    func makeUserView(for user: User) -> UserView
}

final class DefaultScreenFactory: ScreenFactory {
    
    func makeHomeView(coordinator: AppCoordinator) -> HomeView {
        let viewModel = HomeViewModel(coordinator: coordinator)
        return HomeView(viewModel: viewModel)
    }
    
    func makeOrderView(for order: Order) -> OrderView {
        let viewModel = OrderViewModel(order: order)
        return OrderView(viewModel: viewModel)
    }
    
    func makeUserView(for user: User) -> UserView {
        let viewModel = UserViewModel(user: user)
        return UserView(viewModel: viewModel)
    }
}
```

## The Views
There isn't anything too surprising (I hope) in the views and the view models. The view models attempt to control the navigation by simply calling the functions in the coordinator.

**HomeView and HomeViewModel**

```swift
struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
            VStack {
                Button("Go to User Profile") {
                    viewModel.navigateToUser()
                }
                Button("Go to Order Details") {
                    viewModel.navigateToOrder()
                }
            }
    }
}

final class HomeViewModel: ObservableObject {
    private let coordinator: AppCoordinator

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }

    func navigateToUser() {
        let user = User(id: 1, name: "Ahmed")
        coordinator.goToUser(user)
    }

    func navigateToOrder() {
        let order = Order(id: 1, description: "Cheese")
        coordinator.goToOrder(order)
    }
}
```

**OrderView and OrderViewModel**

```swift
struct OrderView: View {
    let viewModel: OrderViewModel

    var body: some View {
        Text("Order Details: \(viewModel.order.description)")
    }
}

final class OrderViewModel: ObservableObject {
    let order: Order
    
    init(order: Order) {
        self.order = order
    }
}
```

**UserView and UserViewModel**

```swift
struct UserView: View {
    let viewModel: UserViewModel

    var body: some View {
        Text("User Profile: \(viewModel.user.name)")
    }
}

final class UserViewModel: ObservableObject {
    let user: User

    init(user: User) {
        self.user = user
    }
}
```

## The Models
The models are described as follows:

```swift
struct Order: Hashable {
    let id: Int
    let description: String
}

struct User: Hashable {
    let id: Int
    let name: String
}
```

# Conclusion

The MVVM-C pattern provides a robust, scalable, and testable architecture for SwiftUI applications, enabling developers to create clean, modular designs while maintaining separation of concerns. By leveraging tools like NavigationStack and NavigationPath, iOS 16 and later versions have made it feasible to fully embrace SwiftUI for both navigation and UI creation, eliminating the need to fall back on UIKit.
I certainly hope this article has helped you out, and given you an idea of how this implementation might just work!
