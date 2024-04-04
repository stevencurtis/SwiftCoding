@testable import ImageSequence
import XCTest

final class AnimatedImageViewModelTests: XCTestCase {
    func test_timerStart_createsTimer() {
        let mockTimerFactory = MockTimerFactory()
        let sut = makeSUT(timerFactory: mockTimerFactory)
        sut.start()
        XCTAssertEqual(mockTimerFactory.createTimerCallCount, 1)
    }

    func test_timerStartTwice_createsTimer() {
        let mockTimerFactory = MockTimerFactory()
        let sut = makeSUT(timerFactory: mockTimerFactory)
        sut.start()
        sut.start()
        XCTAssertEqual(mockTimerFactory.createTimerCallCount, 1)
        XCTAssertEqual(mockTimerFactory.timerInvalidateCalled, false)
    }
    
    func test_timerStop_invalidatesTimer() {
        let mockTimer = MockTimer()
        let mockTimerFactory = MockTimerFactory(timer: mockTimer)
        let sut = makeSUT(timerFactory: mockTimerFactory)
        sut.start()
        sut.stop()
        XCTAssertEqual(mockTimerFactory.createTimerCallCount, 1)
        XCTAssertEqual(mockTimer.invalidateCalled, true)
    }
    
}

extension AnimatedImageViewModelTests {
    func makeSUT(
        interval: TimeInterval = 1.0,
        imageCount: Int = 2,
        repeats: Bool = false,
        timerFactory: TimerFactoryProtocol = MockTimerFactory()
    ) -> AnimatedImageViewModel {
        AnimatedImageViewModel(
            interval: interval,
            imageCount: imageCount,
            repeats: repeats,
            timerFactory: timerFactory
        )
    }
}
