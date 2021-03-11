//
//  TestingiOSTests.swift
//  TestingiOSTests
//
//  Created by Steven Curtis on 30/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import TestingiOS

class TestingiOSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddition() {
        let firstNum = 2
        let secondNum = 3
        XCTAssertEqual(addition(num1: firstNum, num2: secondNum), 5)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
