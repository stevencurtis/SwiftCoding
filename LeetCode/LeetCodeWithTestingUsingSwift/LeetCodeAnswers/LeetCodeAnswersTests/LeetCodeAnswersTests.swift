//
//  LeetCodeAnswersTests.swift
//  LeetCodeAnswersTests
//
//  Created by Steven Curtis on 12/03/2021.
//

import XCTest

class LeetCodeAnswersTests: XCTestCase {
    var solution: Solution?

    override func setUpWithError() throws {
        solution = Solution()
    }

    func testOne() {
        XCTAssertEqual(solution?.minStartValue([-3, 2, -3, 4, 2]), 5)
    }

    func testTwo() {
        XCTAssertEqual(solution?.minStartValue([1, 2]), 1)
    }
    
    func testThree() {
        XCTAssertEqual(solution?.minStartValue([1, -2, -3]), 5)
    }
    
    func testPerformance() {
        measure {
            _ = solution?.minStartValue([-3, 2, -3, 4, 2])
        }
    }
}
