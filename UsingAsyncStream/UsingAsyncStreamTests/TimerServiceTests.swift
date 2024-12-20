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
