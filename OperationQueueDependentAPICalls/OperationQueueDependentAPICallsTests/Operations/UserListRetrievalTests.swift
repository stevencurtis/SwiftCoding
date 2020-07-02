//
//  UserListRetrievalTests.swift
//  OperationQueueDependentAPICallsTests
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import OperationQueueDependentAPICalls

class UserListRetrievalTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() {
        let expectation = XCTestExpectation(description: #function)
        
        let url = URL(string: "testurl")
        let urlSessionMock = URLSessionMock()
        let httpManagerMock = HTTPManagerMock(session: urlSessionMock)
        httpManagerMock.data = listResponse
        let list = UserListRetrievalOperation(url: url, httpManager: httpManagerMock)
        list.completionHandler = {result in
            switch result {
            case .failure:
                XCTFail()
            case .success(let data):                
                XCTAssertEqual(data.count, listResponse?.count)
                expectation.fulfill()
            }
        }
        list.main()
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testError() {
        let expectation = XCTestExpectation(description: #function)
        
        let url = URL(string: "testurl")
        let urlSessionMock = URLSessionMock()
        let httpManagerMock = HTTPManagerMock(session: urlSessionMock)
        httpManagerMock.data = listResponse
        httpManagerMock.giveError = true
        let list = UserListRetrievalOperation(url: url, httpManager: httpManagerMock)
        list.completionHandler = {result in
            switch result {
            case .failure:
                XCTAssertEqual((list.error!  as NSError).code, 403)
                expectation.fulfill()
            case .success:
                XCTFail()
            }
        }
        list.main()
        wait(for: [expectation], timeout: 3.0)
    }
}
