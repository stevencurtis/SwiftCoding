//
//  DataManagerTests.swift
//  OperationQueueDependentAPICallsTests
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import OperationQueueDependentAPICalls

class DataManagerTests: XCTestCase {

    var dataManager: DataManager?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let qm = QueueManager()
        dataManager = DataManager(withQueueManager: qm)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testeretrieveUserListThenUser() {
        let expectation = XCTestExpectation(description: #function)
        dataManager?.retrieveUserListThenUser(completionBlock: { data in
            XCTAssertEqual(data, userModelResponseStruct)
            expectation.fulfill()

         })
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testdecodeUserList() {
        let expectation = XCTestExpectation(description: #function)
        dataManager?.retrieveUserList(completionBlock: {model in
            XCTAssertEqual(model, listResponseStruct)
            expectation.fulfill()
        }
        )
        wait(for: [expectation], timeout: 3.0)
    }
    
}
