# Swift Configuration Objects For Testability
## Make testing easier!

This runs alongside my development of a simple design library system that I'm going to import in my project apps and tutorial projects. Take a look at (https://github.com/stevencurtis/DesignLibrary/tree/main)[https://github.com/stevencurtis/DesignLibrary/tree/main].

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 15.0, and Swift 5.9

## Terminology:
Configuration object: A design pattern that encapsulates all the settings and parameters an application needs to operate in different environments, such as development, testing, and production. This approach allows for more flexible and maintainable code by externalising configuration details from the business logic, making it easier to adjust behaviour without altering the core application code.


# The Principles of Configuration Objects
There are several principles of configuration objects. Here they are:
- Encapsulation
- Reusability
- Modularity

# Encapsulation of Button Style
In SwiftUI `ButtonStyle.Configuration` is a dedicated configuration object that encapsulates all the settings needed to render a button in a specific style.

Here is a simple custom button style that uses `ButtonStyle.Configuration` to adjust the button's appearance.

```swift
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
```

This makes the button change color when it is pressed.
This can be applied using the following code:

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Button("Tap Me") {
                print("Button tapped!")
            }
            .buttonStyle(CustomButtonStyle())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
```

So a single like applies a `CustomButtonStyle` to the button. This means that there can be consistent behavior across multiple buttons and the style can be updated in just one place and change all of the buttons to which that style has been applied.

This is the promotion of a modular and reusable design, and aligns with the configuration object pattern.

We get this out of the box in SwiftUI, which is nice.

# A Real-World Example
It is more interesting to come up with our own use case for configuration objects. So here we go!
My example is using my own Network Client framework (https://github.com/stevencurtis/NetworkClient) where I wish to handle different network clients for debugging and production.

## The Configuration
I've set up a configuration file so we can use a main client for production, and a mock for testing.

```swift
import Foundation
import NetworkClient

protocol NetworkClientConfiguration {
    var networkClient: NetworkClient { get }
}

struct DebugNetworkClientConfiguration: NetworkClientConfiguration {
    var networkClient: NetworkClient {
        MockNetworkClient()
    }
}

struct ReleaseNetworkClientConfiguration: NetworkClientConfiguration {
    var networkClient: NetworkClient {
        MainNetworkClient()
    }
}
```
## Dynamic Configuration Selection
Using the NetworkClientSelector, you can dynamically select configurations based on build settings or launch arguments. This selector determines whether to use a debug or release configuration, making it possible to customize behavior without changing the core logic.

```swift
import Foundation

struct NetworkClientSelector {
    static func select() -> NetworkClientConfiguration {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-UITests") {
            return DebugNetworkClientConfiguration()
        }
        #endif
        return ReleaseNetworkClientConfiguration()
    }
}
```

This pattern allows testing with mock configurations during UI testing while ensuring that the release configuration is used in production builds. By embedding this selection in a dedicated selector, you enhance maintainability and streamline switching between environments.

## Factory Pattern with APIFactory
The `APIFactory` offers a central point for creating network clients with the selected configuration. This setup improves code consistency by encapsulating the client creation logic.

```swift
import Foundation
import NetworkClient

struct APIFactory {
    static func makeDefault(
        with configuration: NetworkClientConfiguration = NetworkClientSelector.select()
    ) -> NetworkClient {
        configuration.networkClient
    }
}
```

## Testing Configuration Objects
In testing, configuration objects become indispensable for isolating different components. Here's how the `APIFactory` configuration is tested using `XCTest`:

```swift
@testable import NetworkClientSwitcher
import NetworkClient
import XCTest

final class APIFactoryTests: XCTestCase {
    func testMakeMockNetworkClient() {
        let networkClient = APIFactory.makeDefault(with: DebugNetworkClientConfiguration())
        XCTAssertTrue(networkClient is MockNetworkClient)
    }
    
    func testMakeMainNetworkClient() {
        let networkClient = APIFactory.makeDefault(with: ReleaseNetworkClientConfiguration())
        XCTAssertTrue(networkClient is MainNetworkClient)
    }
}
```

These tests validate that the correct network client is instantiated based on the configuration provided. By isolating the network client behavior, you can easily mock network interactions, enabling more thorough testing and adherence to test-driven principles.


# Conclusion
Using configuration objects in Swift is a robust solution for managing different environments and configurations. This pattern promotes code flexibility, modularity, and testability, empowering developers to create scalable, maintainable applications. Configuration objects align well with Swift best practices and support a smooth, consistent development experience.

Thanks for reading!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
