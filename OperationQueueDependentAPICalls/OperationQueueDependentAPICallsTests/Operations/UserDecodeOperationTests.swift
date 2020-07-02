//
//  UserDecodeOperationTests.swift
//  OperationQueueDependentAPICallsTests
//
//  Created by Steven Curtis on 12/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import OperationQueueDependentAPICalls

class UserDecodeOperationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() {
        let expectation = XCTestExpectation(description: #function)
        let urlSessionMock = URLSessionMock()
        let httpManagerMock = HTTPManagerMock(session: urlSessionMock)
        httpManagerMock.data = listResponse
        let operation = UserDecodeOperation()
        operation.dataFetched = userModelResponse
        operation.completionHandler = {result in
            XCTAssertEqual(result, userModelResponseStruct)
            expectation.fulfill()
        }
        operation.main()
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testErrorHandler() {
        let expectation = XCTestExpectation(description: #function)
        let operation = UserDecodeOperation()
        operation.dataFetched = "".data(using: .utf8)
        operation.completionHandler = {data in
            XCTAssertEqual(operation.error?.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
            expectation.fulfill()
        }
        operation.start()
        wait(for: [expectation], timeout: 3.0)
    }
}
