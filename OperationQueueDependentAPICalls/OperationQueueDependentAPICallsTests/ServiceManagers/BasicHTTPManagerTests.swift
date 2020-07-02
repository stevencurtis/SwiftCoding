//
//  HTTPManagerTests.swift
//  BasicHTTPManagerTests
//
//  Created by Steven Curtis on 03/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import OperationQueueDependentAPICalls

class BasicHTTPManagerTests: XCTestCase {
    
    var urlSession: URLSessionMock?

    func testSuccessHTTPManagerResponse() {
        let urlSession = URLSessionMock()
        let data = Data("TEsts12".utf8)
        urlSession.data = data
        let httpManager = HTTPManager(session: urlSession)
        let url = URL(string: "testURL")!
        
        httpManager.get(url: url, completionBlock: {result in
            switch result {
            case .failure:
                XCTFail()
            case .success(let success):
                let decodedString = (String(decoding: success, as: UTF8.self))
                XCTAssertEqual(decodedString, "TEsts12")
            }
        })
    }
    
    func testFailureHTTPManagerResponse() {
        let urlSession = URLSessionMock()
        let httpManager = HTTPManager(session: urlSession)
        let url = URL(string: "testURL")!
        
        httpManager.get(url: url, completionBlock: {result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(0, (error as NSError).code)
            case .success:
                XCTFail()
            }
        })
    }

}
