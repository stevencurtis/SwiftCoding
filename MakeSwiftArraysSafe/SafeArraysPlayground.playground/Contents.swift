import UIKit
import XCTest

extension Array {
    subscript(safe index: Index) -> Element? {
        if indices.contains(index) {
            return self[index] as Element
        }
        return nil
    }
}

class MyTests: XCTestCase {
    var array: [String]!
    override func setUp() {
        super.setUp()
        array = ["a"]
    }
    func testLess() {
        XCTAssertEqual(array[safe: -1], nil)
    }
    
    func testFirst() {
        XCTAssertEqual(array[safe: 0], "a")
    }
    
    func testLast() {
        XCTAssertEqual(array[safe: 1], "a")
    }
}

MyTests.defaultTestSuite.run()
