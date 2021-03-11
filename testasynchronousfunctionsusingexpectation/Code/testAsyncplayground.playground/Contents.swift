import UIKit
import XCTest
//import PlaygroundSupport

//PlaygroundPage.current.needsIndefiniteExecution = true

func messageAfterDelay(message: String, time: Double, completion: @escaping (String)->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
        completion (message)
    }
}

class asyncTests: XCTestCase {
    func testDelay() {
        let exp = expectation(description: "\(#function)")

        messageAfterDelay(message: "myMessage", time: 1.0, completion: {message in
            XCTAssertEqual(message, "myMessage")
            exp.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
}

asyncTests.defaultTestSuite.run()
