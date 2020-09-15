//
//  ThreadSafeArrayTests.swift
//  ThreadSafeArrayTests
//
//  Created by Steven Curtis on 15/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import ThreadSafeArray

class ThreadSafeArrayTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testArray() {
        self.measure {
            // Put the code you want to measure the time of here.
            let vc = ViewController()
            let result = vc.oneThousand(originalArray: true, interations: 10)
            // XCTAssertEqual(result, 11)
        }
    }
    
    func testSafeArray() {
        self.measure {
            // Put the code you want to measure the time of here.
            let vc = ViewController()
            let result = vc.oneThousand(originalArray: false, interations: 100)
            XCTAssertEqual(result, 101)
        }
    }

}
