# Testing the Sandwiches SwiftUI WWDC Code
## Without the Hot Dogs References

I've previously written [an article](https://stevenpcurtis.medium.com/recreating-the-sandwiches-swiftui-wwdc-code-b669e266dc8d) where I recreated the code from [a Video](https://developer.apple.com/videos/play/wwdc2020/10119/) from WWDC.

I'm taking a view about the necessity of viewModels when using SwiftUI, and part of that investigation is around testing.

Can I write even simple tests for that code, and get them working? Let's take a look.

# Before we begin
Difficulty: **Beginner** | Easy | Normal | Challenging<br/>
This article has been developed using Xcode 12.0, and Swift 5.3

# Terminology:
SwiftUI: A simple way to build user interfaces across Apple platforms

## Prerequisites:
* You will be expected to be aware how to make a [SwiftUI](https://medium.com/@stevenpcurtis.sc/hello-world-swiftui-92bcf48a62d3) project

# The experiment
## if DEBUG macro
The setup I've taken the code from that old article I knocked together. One thing that was fine was skipping the `#if DEBUG` and there is evidence for that on one [Stack Overflow question](https://stackoverflow.com/questions/56485562/are-the-if-debug-statements-really-needed-for-previews-in-swiftui-to-remove-it).

Great!

Since in `RecreateSandwichesApp` we are using the test data we aren't able to wrap any of that test data in the macro (because if not it would break for release mode). That's fine, but worth noting here.

## The tests
Can I create a set of tests for that sandwich store? Sure I can.

Since the test data is part of the `RecreateSandwiches` target we need to `@testable import RecreateSandwiches` but we would need to do that in any case to be able to access the project files in order to test them.

```swift
@testable import RecreateSandwiches
import XCTest

final class SandwichStoreTests: XCTestCase {
    func testInitializerEmpty() {
        let sut = SandwichStore()
        XCTAssertTrue(sut.sandwiches.isEmpty)
    }

    func testInitializer() {
        let sut = SandwichStore(sandwiches: data)
        XCTAssertTrue(sut.sandwiches.count == 2)
        XCTAssertEqual(sut.sandwiches, data)
    }
}
```

In order to run these tests I also needed to make the sandwiches conform to equatable. Since this is not required in the main project I added this to the test target.

```swift
extension Sandwich: Equatable {
    public static func == (lhs: Sandwich, rhs: Sandwich) -> Bool {
        lhs.id == rhs.id
    }
}
```

I think this makes sense, and adding it to the test target means we are not polluting the main project with code unnecessarily.

# Conclusion
If you'd like to go through the [WWDC Video](https://developer.apple.com/videos/play/wwdc2020/10119/) you've now got the code to help you!

This is a good thing for everyone concerned, and I'll leave my [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/SwiftUI/RecreateSandwiches) up for people use in the future. 

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
