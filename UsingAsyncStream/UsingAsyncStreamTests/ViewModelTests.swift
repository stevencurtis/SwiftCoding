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
