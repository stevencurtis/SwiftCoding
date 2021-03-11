import UIKit
import XCTest

func addition(num1: Int, num2: Int) -> Int {
    return num1 + num2
}

//print( addition(num1: 1, num2: 2) )

class MyTests: XCTestCase {
    func testAddition() {
        let firstNum = 2
        let secondNum = 3
        XCTAssertEqual(addition(num1: firstNum, num2: secondNum), 5)
    }
}

MyTests.defaultTestSuite.run()
