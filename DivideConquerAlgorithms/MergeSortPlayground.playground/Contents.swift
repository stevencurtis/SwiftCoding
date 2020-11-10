import UIKit
import XCTest

func mergeSort(_ inputArray: [Int]) -> [Int] {
    guard inputArray.count > 1 else {return inputArray}
    let midpoint = inputArray.count / 2
    let firstArr = Array(inputArray[0..<midpoint])
    let secondArr = Array(inputArray[midpoint..<inputArray.count])
    return merge( mergeSort(firstArr), mergeSort(secondArr) )
}

// merge assumes the input arrays themselves are sorted
func merge(_ arrOne: [Int], _ arrTwo: [Int]) -> [Int] {
    var result = [Int]()
    var firstArr = arrOne
    var secondArr = arrTwo
    while let fa = firstArr.first, let sa = secondArr.first {
        if firstArr.first! < secondArr.first! {
            result.append(fa)
            firstArr.removeFirst()
        } else {
            result.append(sa)
            secondArr.removeFirst()
        }
    }
    
    while let fa = firstArr.first {
        result.append(fa)
        firstArr.removeFirst()
    }
    
    while let sa = secondArr.first {
        result.append(sa)
        secondArr.removeFirst()
    }
    return result
}

class sortingTests: XCTestCase {
    override func setUp() {  }
    func testSorts() {
        XCTAssertEqual( mergeSort([1,2,3,4,5]), [1,2,3,4,5] )
        XCTAssertEqual( mergeSort([3,2,1]), [1,2,3] )
        XCTAssertEqual( mergeSort([1,2,3]), [1,2,3] )
        XCTAssertEqual( mergeSort([5,4,3,2,1]), [1,2,3,4,5] )
        XCTAssertEqual( mergeSort([4,1,3,9,7]), [4,1,3,9,7].sorted() )
        XCTAssertEqual( mergeSort([10,9,8,7,6,5,4,3,2,1]), [10,9,8,7,6,5,4,3,2,1].sorted() )
    }
    
    func testMerge() {
        XCTAssertEqual( merge([1,2],[]), [1,2])
        XCTAssertEqual( merge([],[1,2]), [1,2])
        XCTAssertEqual( merge([1,2], [1,2]), [1,1,2,2] )
    }
}

sortingTests.defaultTestSuite.run()
