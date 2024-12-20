import Foundation
@testable import UsingAsyncStream

final class MockTimerService: TimerServiceProtocol {
    private var values: [String]
    private var index: Int = 0

    init(values: [String]) {
        self.values = values
    }

    func timeStream() -> AsyncStream<String> {
        return AsyncStream { continuation in
            // Iterate over provided mock values
            for value in self.values {
                continuation.yield(value)
            }
            continuation.finish()
        }
    }
}
