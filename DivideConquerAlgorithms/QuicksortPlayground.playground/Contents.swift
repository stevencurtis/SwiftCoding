import UIKit
import XCTest

func quicksort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 {return arr}
    let pivot = arr.count / 2
    let fp = arr.filter{$0 < arr[pivot]}
    let equal = arr.filter{$0 == arr[pivot]}
    let lp = arr.filter{$0 > arr[pivot]}
    return  quicksort(fp) + equal + quicksort(lp)
}

quicksort([5,4,3,2,1]) // [1,2,3,4,5]

class sortingTests: XCTestCase {
    override func setUp() {  }
    func testSorts() {
        XCTAssertEqual( quicksort([1,2,3,4,5]), [1,2,3,4,5] )
        XCTAssertEqual( quicksort([3,2,1]), [1,2,3] )
        XCTAssertEqual( quicksort([1,2,3]), [1,2,3] )
        XCTAssertEqual( quicksort([5,4,3,2,1]), [1,2,3,4,5] )
        XCTAssertEqual( quicksort([4,1,3,9,7]), [4,1,3,9,7].sorted() )
        XCTAssertEqual( quicksort([10,9,8,7,6,5,4,3,2,1]), [10,9,8,7,6,5,4,3,2,1].sorted() )
    }
}

sortingTests.defaultTestSuite.run()
