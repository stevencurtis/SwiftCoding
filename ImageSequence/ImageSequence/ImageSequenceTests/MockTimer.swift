import Foundation
@testable import ImageSequence

final class MockTimer: TimerProtocol {
    public private(set) var invalidateCalled = false
    
    func invalidate() {
        invalidateCalled = true
    }
}
