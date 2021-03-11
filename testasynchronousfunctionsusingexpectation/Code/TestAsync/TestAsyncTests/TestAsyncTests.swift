//
//  TestAsyncTests.swift
//  TestAsyncTests
//
//  Created by Steven Curtis on 31/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import TestAsync

class TestAsyncTests: XCTestCase {

    func testDelay() {
        let exp = expectation(description: "\(#function)")
        messageAfterDelay(message: "myMessage", time: 1.0, completion: {message in
            XCTAssertEqual(message, "myMessage")
            exp.fulfill()
        })
        waitForExpectations(timeout: 3)
    }

}
