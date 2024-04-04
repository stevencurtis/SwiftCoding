import Foundation
@testable import ImageSequence

final class MockTimerFactory: TimerFactoryProtocol {
    var numberOfRepeats: Int = 1
    var timerInvalidateCalled: Bool? {
        (timer as? MockTimer)?.invalidateCalled
    }
    
    private(set) var createTimerCallCount = 0
    private let timer: TimerProtocol
    
    func createTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (TimerProtocol) -> Void) -> TimerProtocol {
        createTimerCallCount += 1
        for _ in 0 ..< numberOfRepeats {
            block(timer)
        }
        return timer
    }
    
    init(timer: TimerProtocol = MockTimer()) {
        self.timer = timer
    }
}
