//
//  HTTPManagerTests.swift
//  BasicHTTPManagerTests
//
//  Created by Steven Curtis on 03/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import OperationQueueDependentAPICalls

// Use HTTPManagerMock to test the ViewController
class ViewControllerTests: XCTestCase {
    var httpManager: HTTPManagerMock<URLSessionMock>?
//    func testSuccessHTTPManagerResponse() {
//        let expect = expectation(description: #function)
//        let viewController = ViewController()
//        let urlSession = URLSessionMock()
//        let data = Data("TEsts12".utf8)
//        urlSession.data = data
//
//        // instantiate the HTTPManager
//        httpManager = HTTPManagerMock(session: urlSession)
//
//        // Call the function from the view controller
//        viewController.downloadData( httpManager!, completion: {result in
//            switch result {
//            case .success(let data):
//                let decodedString = (String(decoding: data, as: UTF8.self))
//                expect.fulfill()
//                XCTAssertEqual(decodedString, "This Succeeded")
//            case .failure:
//                XCTFail()
//            }
//
//        }
//        )
//
//        waitForExpectations(timeout: 3.0)
//    }

    
//    func testFailHTTPManagerResponse() {
//        let expect = expectation(description: #function)
//        let viewController = ViewController()
//        let urlSession = URLSessionMock()
//        
//        // instantiate the HTTPManager
//        httpManager = HTTPManagerMock(session: urlSession)
//        
//        // Call the function from the view controller
//        viewController.downloadData( httpManager!, completion: {result in
//            switch result {
//            case .success(let data):
//                let decodedString = (String(decoding: data, as: UTF8.self))
//                expect.fulfill()
//                XCTAssertEqual(decodedString, "This Succeeded")
//            case .failure:
//                XCTFail()
//            }
//        }
//        )
//        waitForExpectations(timeout: 3.0)
//    }
    
}
