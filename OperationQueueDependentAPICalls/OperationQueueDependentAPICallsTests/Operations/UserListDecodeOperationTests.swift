//
//  UserListDecodeOperationTests.swift
//  OperationQueueDependentAPICallsTests
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import OperationQueueDependentAPICalls


class UserListDecodeOperationTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userListDecodeOperation = UserListDecodeOperation()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var userListDecodeOperation : UserListDecodeOperation?

    func testCompletionHandler() {
        let expectation = XCTestExpectation(description: #function)
        userListDecodeOperation?.dataFetched = listResponse
        userListDecodeOperation!.completionHandler = {data in
            XCTAssertEqual(data, listResponseStruct)
            expectation.fulfill()
        }
        userListDecodeOperation?.start()
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testErrorHandler() {
        let expectation = XCTestExpectation(description: #function)
        userListDecodeOperation?.dataFetched = "".data(using: .utf8)
        userListDecodeOperation?.completionHandler = {data in
            XCTAssertEqual(self.userListDecodeOperation?.error?.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
            expectation.fulfill()
        }
        userListDecodeOperation?.start()
        wait(for: [expectation], timeout: 3.0)
    }
}
