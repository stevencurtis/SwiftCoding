# Create emails in SwiftUI
## Get the user to email!

Difficulty: **Beginner** | Easy | Normal | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.7.2

The background to this is I wanted to make an email from a SwiftUI App. I mean how hard can that be?

# The approach
I wanted to make sure I could make an email from within a SwiftUI app. It turns out that using MVVM didn't make this task any more difficult really than doing it straight.

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
    func email() {
        guard let url = URL(string: "mailto:support@example.com") else { return }
        openURL.open(url)
    }
    
    func emailWithSubject() {
        let subject = "Feedback"
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "mailto:support@example.com?subject=\(encodedSubject)") else { return }
        openURL.open(url)
    }
    
    func emailWithSubjectAndBody() {
        let subject = "Feedback"
        let body = "I wanted to share some feedback about...'the issue' ok"

        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        if let url = URL(string: "mailto:support@example.com?subject=\(encodedSubject)&body=\(encodedBody)") {
            openURL.open(url)
        }
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
            Button("Click me to email", action: {
                viewModel.email()
            })
            Button("Click me to email with subject populated", action: {
                viewModel.emailWithSubject()
            })
            Button("Click me to email with subject and body populated", action: {
                viewModel.emailWithSubjectAndBody()
            })
        }
        .padding()
    }
}
```

ViewModel
```swift
final class ViewModel: ObservableObject {
    let openURL: OpenURLProtocol
    init(openURL: OpenURLProtocol = UIApplication.shared) {
        self.openURL = openURL
    }
    func email() {
        guard let url = URL(string: "mailto:support@example.com") else { return }
        openURL.open(url)
    }
    
    func emailWithSubject() {
        let subject = "Feedback"
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "mailto:support@example.com?subject=\(encodedSubject)") else { return }
        openURL.open(url)
    }
    
    func emailWithSubjectAndBody() {
        let subject = "Feedback"
        let body = "I wanted to share some feedback about...'the issue' ok"

        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        if let url = URL(string: "mailto:support@example.com?subject=\(encodedSubject)&body=\(encodedBody)") {
            openURL.open(url)
        }
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

final class OpenEmailSwiftUITests: XCTestCase {
    func testEmail() throws {
        let expectedUrl = URL(string: "mailto:support@example.com")
        let mockApplicationURLOpener = MockApplicationURLOpener()
        let vm = ViewModel(openURL: mockApplicationURLOpener)
        vm.email()
        XCTAssertEqual(mockApplicationURLOpener.urlOpened, expectedUrl)
    }
    
    func testEmailWithSubject() throws {
        let expectedUrl = URL(string: "mailto:support@example.com?subject=Feedback")
        let mockApplicationURLOpener = MockApplicationURLOpener()
        let vm = ViewModel(openURL: mockApplicationURLOpener)
        vm.emailWithSubject()
        XCTAssertEqual(mockApplicationURLOpener.urlOpened, expectedUrl)
    }
    
    func testEmailWithSubjectAndBody() throws {
        let expectedUrl = URL(string: "mailto:support@example.com?subject=Feedback&body=I%20wanted%20to%20share%20some%20feedback%20about...'the%20issue'%20ok")
        let mockApplicationURLOpener = MockApplicationURLOpener()
        let vm = ViewModel(openURL: mockApplicationURLOpener)
        vm.emailWithSubjectAndBody()
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
That's my way of creating an email in a SwiftUI app. I hope this has been of use to someone reading.

