import UIKit
import XCTest

func helloWorld(name: String) -> String {
    "Hello, world \(name)"
}

var counter = 0
func incCounter(by num: Int) -> Int {
    counter += num
    return counter
}

func giveNumber(number: Int) -> Int {
    Int.random(in: number..<100)
}

class helloTests: XCTestCase {
    func testHelloWorldDhruv() {
        XCTAssertEqual(helloWorld(name: "Dhruv"), "Hello, world Dhruv")
    }
    
    func testHelloWorldImani() {
        XCTAssertEqual(helloWorld(name: "Imani"), "Hello, world Imani")
    }

    func testCounterAddOne() {
        XCTAssertEqual(incCounter(by: 1), 1)
    }
    
    func testCounterAddTwo() {
        XCTAssertEqual(incCounter(by: 2), 3)
    }
    
    func testNumber() {
        XCTAssertEqual(giveNumber(number: 4), 8)
    }
}

helloTests.defaultTestSuite.run()
