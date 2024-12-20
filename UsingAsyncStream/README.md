# An Introduction to AsyncStream in Swift: A Practical Example with a Timer
## async await

`AsyncStream` is a powerful way in swift to handle sequences of asynchronous values.

In this article I'll run through `AsyncStream` and how it works, with a simple timer example helping us dive into the code and how to test AsyncStream.

# What is AsyncStream?
`AsyncStream` allows the production of a sequence of values over time. Values are emitted as they become ready, making it ideal for handling:
- Network responses
- User events
- Timers

As well as providing tools so we can manage cancellation and asynchronous flows gracefully.

# Key Concepts
When we use AsyncStream the producer yields values to the stream, and the consumer iterates over them asynchronously.
There are built-in mechanisms for handling task cancellation.

# A Timer Using AsyncStream
I've already indicated that timers are good use cases for `AsyncStream`, so what better example for this article?
Essentially the timer will produce asynchronous sequences using `AsyncStream`.

## The TimerService
Here's how we can use `AsyncStream` to create a timer that emits a formatted time string every second.
Because we would like this to be testable we use a `protocol`.

```swift
protocol TimerServiceProtocol {
    func timeStream() -> AsyncStream<String>
}

final class TimerService: TimerServiceProtocol {
    private let date: () -> Date
    private let formatter: DateFormatter
    private let interval: TimeInterval

    init(
        formatter: DateFormatter = TimerService.defaultFormatter(),
        interval: TimeInterval = 1.0,
        currentDate: @escaping @autoclosure () -> Date = Date()
    ) {
        self.date = currentDate
        self.formatter = formatter
        self.interval = interval
    }

    func timeStream() -> AsyncStream<String> {
        return AsyncStream { continuation in
            let now = dispatchTime(from: date())
            let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer.schedule(deadline: now, repeating: interval)
            timer.setEventHandler { [weak self] in
                guard let self else { return }
                let date = date()
                let currentTime = self.formatter.string(from: date)
                continuation.yield(currentTime)
            }
            timer.resume()

            continuation.onTermination = { _ in
                timer.cancel()
            }
        }
    }

    private func dispatchTime(from date: Date) -> DispatchTime {
        let timeInterval = date.timeIntervalSinceNow
        return DispatchTime.now() + timeInterval
    }
    
    private static func defaultFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
}
```

Essentially we create an `AsyncStream` that produces the sequence of formatted strings, and we use `DispatchSourceTimer` to emit a new value every second.

We also handle cancellation using `onTermination` to cancel the timer when the stream consumption stops, handling the resource cleanup.

## Consuming the AsyncStream
We set up a view model to consume the emitted time values and update state accordingly.
This uses the `Observation` `protocol` because, well, why not?

```swift
import Observation

@Observable
final class TimerViewModel {
    private(set) var time: String = "default"    
    private let timerService: TimerServiceProtocol
    init(timerService: TimerServiceProtocol = TimerService()) {
        self.timerService = timerService
    }

    func initializer() async {
        for await newTime in timerService.timeStream() {
            time = newTime
        }
    }
}
```

We take the emitted stream and then convert this into a nicely formatted string that can be displayed by the view.

# Testing AsyncStream
Of course I have produced the required `MockTimerService` required to test the view model.

That means the following tests can be performed on the view model. By injecting into `TimerService` we make the behaviour predictable, and this makes it easy to verify the output.

```swift
@testable import UsingAsyncStream
import XCTest

final class ViewModelTests: XCTestCase {
    func testTimeUpdates() async {
        let mockValues = ["10:00 AM", "10:01 AM", "10:02 AM"]
        let mockService = MockTimerService(values: mockValues)
        let viewModel = TimerViewModel(timerService: mockService)
        
        await viewModel.initializer()
        
        XCTAssertEqual(viewModel.time, "10:02 AM")
    }

    func testInitialTime() {
        let mockService = MockTimerService(values: [])
        let viewModel = TimerViewModel(timerService: mockService)
        
        XCTAssertEqual(viewModel.time, "default")
    }
    
    func testMultipleTimeUpdates() async {
        let mockValues = ["11:00 AM", "11:01 AM", "11:02 AM"]
        let mockService = MockTimerService(values: mockValues)
        let viewModel = TimerViewModel(timerService: mockService)
        
        await viewModel.initializer()
        
        XCTAssertEqual(viewModel.time, "11:02 AM")
    }
}
```
We don't need any mocks to test the service. However we do need to use `XCTestExpectation` to manage the timing of async events. The test waits until the expectation is fulfilled, ensuring we capture emitted values.

Since we inject the interval and `currentDate` we can control what is happening within the timer.

```swift
import XCTest
@testable import UsingAsyncStream

final class TimerServiceTests: XCTestCase {
    func testTimeStreamEmitsFormattedTime() async {
        let expectation = XCTestExpectation()
        let fixedDate = Date(timeIntervalSince1970: 1609459200)
        let formatter = createMockFormatter()
        
        let service = TimerService(
            formatter: formatter,
            interval: 0.1,
            currentDate: fixedDate
        )
        
        var receivedTime: String?
        let _ = Task {
            for await time in service.timeStream() {
                receivedTime = time
                expectation.fulfill()
                break
            }
        }
        
        await fulfillment(of: [expectation])
        
        XCTAssertEqual(receivedTime, formatter.string(from: fixedDate))
    }
    
    func testTimeStreamEmitsMultipleFormattedTimes() async {
        let expectation = XCTestExpectation()
        var currentDate = Date(timeIntervalSince1970: 1609459200)
        let formatter = createMockFormatter()
        
        let mockDateProvider: () -> Date = {
            let date = currentDate
            currentDate.addTimeInterval(1)
            return date
        }
        
        let service = TimerService(
            formatter: formatter,
            interval: 0.1,
            currentDate: mockDateProvider()
        )
        
        var receivedTimes: [String] = []
        let _ = Task {
            for await time in service.timeStream() {
                receivedTimes.append(time)
                if receivedTimes.count > 2 {
                    expectation.fulfill()
                }
            }
        }
        
        await fulfillment(of: [expectation])

        XCTAssertEqual(receivedTimes, [
            formatter.string(from: Date(timeIntervalSince1970: 1609459201)),
            formatter.string(from: Date(timeIntervalSince1970: 1609459202)),
            formatter.string(from: Date(timeIntervalSince1970: 1609459203))
        ])
    }
    
    func testTimeStreamHandlesTermination() async {
        let expectation = XCTestExpectation()
        let fixedDate = Date(timeIntervalSince1970: 1609459200)
        let formatter = createMockFormatter()
        
        let service = TimerService(
            formatter: formatter,
            interval: 0.1,
            currentDate: fixedDate
        )
        
        var receivedTimes: [String] = []
        let _ = Task {
            for await time in service.timeStream() {
                receivedTimes.append(time)
                if receivedTimes.count == 2 {
                    expectation.fulfill()
                }
            }
        }
        
        await fulfillment(of: [expectation])
        
        XCTAssertEqual(receivedTimes.count, 2)
    }
}

extension TimerServiceTests {
    private func createMockFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
}
```

# Conclusion
This article introduced `AsyncStream`, using a timer as a straightforward example to showcase its capabilities. The timer may be simple, but the principles demonstrated here-producing asynchronous sequences, consuming them, and testing them-apply to a wide range of scenarios in modern Swift development.
