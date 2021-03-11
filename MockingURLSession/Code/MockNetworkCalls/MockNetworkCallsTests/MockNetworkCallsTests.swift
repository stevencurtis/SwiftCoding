//
//  MockNetworkCallsTests.swift
//  MockNetworkCallsTests
//
//  Created by Steven Curtis on 31/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import MockNetworkCalls

class MockNetworkCallsTests: XCTestCase {

    func testDownloadUnreliable() {
        let exp = expectation(description: "Loading URL")
        let vc = ViewController()
        vc.downloadData(URLSession.shared, completionBlock: {data in
            exp.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    
    func testUsingSimpleMock() {
        let mockSession = URLSessionMock()
        mockSession.data = "testData".data(using: .ascii)
        let exp = expectation(description: "Loading URL")
        let vc = ViewController()
        vc.downloadData(mockSession, completionBlock: {data in
            exp.fulfill()
        })
        waitForExpectations(timeout: 0.1)
    }

}
