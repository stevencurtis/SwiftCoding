# Create a telephone call in SwiftUI
## Get the user to call!

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.7.2

The background to this is I wanted to make a native call from a SwiftUI App. I mean how hard can that be?

# The approach
I wanted to make sure I could make a telephone call from within a SwiftUI App. It turns out that using MVVM didn't make this task any more difficult really than doing it straight.

Sure I needed to create a protocol for `UIApplication` to conform to so it can be injected in the view model.

```swift
protocol OpenURLProtocol {
    func open(_ url: URL)
}

extension UIApplication: OpenURLProtocol {
    func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}
```

that can then be injected using initilizer dependency into the view model.

```swift
final class ViewModel: ObservableObject {
    let openURL: OpenURLProtocol
    init(openURL: OpenURLProtocol = UIApplication.shared) {
        self.openURL = openURL
    }
    func callNumber() {
        guard let url = URL(string: "tel://08000480408") else { return }
        openURL.open(url)
    }
}
```

# Code
ContentView
```swift
struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Button("Click me to call", action: {
                viewModel.callNumber()
            })
        }
        .padding()
    }
}
```

ViewModel
```swift
import UIKit

final class ViewModel: ObservableObject {
    let openURL: OpenURLProtocol
    init(openURL: OpenURLProtocol = UIApplication.shared) {
        self.openURL = openURL
    }
    func callNumber() {
        guard let url = URL(string: "tel://08000480408") else { return }
        openURL.open(url)
    }
}
```

OpenURLProtocol
```swift
protocol OpenURLProtocol {
    func open(_ url: URL)
}

extension UIApplication: OpenURLProtocol {
    func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}
```

Tests and mock
```swift
import XCTest
@testable import OpenCallSwiftUI

final class OpenCallSwiftUITests: XCTestCase {
    func testCall() throws {
        let expectedUrl = URL(string: "tel://08000480408")
        let mockApplicationURLOpener = MockApplicationURLOpener()
        let vm = ViewModel(openURL: mockApplicationURLOpener)
        vm.callNumber()
        XCTAssertEqual(mockApplicationURLOpener.urlOpened, expectedUrl)
    }
}

final class MockApplicationURLOpener: OpenURLProtocol {
    var urlOpened: URL?
    func open(_ url: URL) {
        urlOpened = url
    }
}
```


# Conclusion

That's my way of making a call from a SwiftUI app. I hope this has been of use to someone reading.
