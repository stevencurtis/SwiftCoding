import UIKit
import PlaygroundSupport
import XCTest


func binarySearch (arr: [Int], target : Int) -> Int? {
    guard arr.count > 0 else {return nil}
    func binarySearch (_ arr: [Int], _ target : Int, _ lowerBound: Int, _ upperBound: Int) -> Int? {
        if lowerBound > upperBound {return nil}
        let mid = lowerBound + (upperBound - lowerBound) / 2
        if arr[mid] == target {return mid}
        if arr[mid] < target {
            return binarySearch(arr, target, mid + 1, upperBound)
        } else {
            return binarySearch(arr, target, lowerBound, mid - 1)
        }
    }
    return binarySearch(arr, target, 0, arr.count - 1)
}

class binarySearchTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
        func testCantFind() {
            XCTAssertEqual(binarySearch(arr: [], target: 0), nil)
            XCTAssertEqual(binarySearch(arr: [1], target: 0), nil)
            XCTAssertEqual(binarySearch(arr: [1,2], target: 3), nil)
            XCTAssertEqual(binarySearch(arr: [1,2,3,4], target: 5), nil)
            XCTAssertEqual(binarySearch(arr: [1,2,3,4], target: 0), nil)
        }
        func testmidElement() {
            XCTAssertEqual(binarySearch(arr: [1], target: 1), 0)
            XCTAssertEqual(binarySearch(arr: [1,2,3], target: 2), 1)
            XCTAssertEqual(binarySearch(arr: [1,2,3,4,5], target: 3), 2)
        }
        func testElementinArray() {
            XCTAssertEqual(binarySearch(arr: [1,2], target: 2), 1)
            XCTAssertEqual(binarySearch(arr: [1,2,3,4,5,6,7,8], target: 7), 6)
            XCTAssertEqual(binarySearch(arr: [1,2,3,4,5,6,7,8,55,66,88,99,100,101,105], target: 99), 11)

            XCTAssertEqual(binarySearch(arr: [2,3,4,5,6], target: 5), 3)
            XCTAssertEqual(binarySearch(arr: [2,4,6,8], target: 6), 2)
            XCTAssertEqual(binarySearch(arr: [3,4,16,23], target: 16), 2)
        }
        func testFirstElement() {
            XCTAssertEqual(binarySearch(arr: [1,2], target: 2), 1)
            XCTAssertEqual(binarySearch(arr: [1,2,3], target: 1), 0)
            XCTAssertEqual(binarySearch(arr: [7,8,9,10], target: 7), 0)
    
        }
        func testLastElement() {
            XCTAssertEqual(binarySearch(arr: [1,2], target: 2), 1)
            XCTAssertEqual(binarySearch(arr: [1,2,3], target: 3), 2)
            XCTAssertEqual(binarySearch(arr: [1,2,3,4], target: 4), 3)
            XCTAssertEqual(binarySearch(arr: [1,2,3,4,5], target: 5), 4)
        }
}

binarySearchTests.defaultTestSuite.run()
