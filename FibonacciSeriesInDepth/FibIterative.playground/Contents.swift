import UIKit
import XCTest

func fib (_ n: Int) -> Int {
    guard n > 1 else {return n}
    var a = 0
    var b = 1
    for _ in 2...n {
        let temp = b
        b = a + b
        a = temp
    }
    return b
}

class fibTests: XCTestCase {
    
    func testFib() {
        measure {
            XCTAssertEqual(fib(0), 0)
            XCTAssertEqual(fib(1), 1)
            XCTAssertEqual(fib(2), 1)
            XCTAssertEqual(fib(3), 2)
            XCTAssertEqual(fib(4), 3)
            XCTAssertEqual(fib(5), 5)
            XCTAssertEqual(fib(6), 8)
            XCTAssertEqual(fib(7), 13)
            XCTAssertEqual(fib(8), 21)
            XCTAssertEqual(fib(9), 34)
        }
    }
}
fibTests.defaultTestSuite.run()
