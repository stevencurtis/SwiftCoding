//
//  IntFrameworkOneTests.swift
//  IntFrameworkOneTests
//
//  Created by Steven Curtis on 23/02/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import IntFrameworkOne

class IntFrameworkOneTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSimple() {
        let myNum: Int = Int(int: 4)
        XCTAssertEqual(myNum.int, 4)
    }


}
