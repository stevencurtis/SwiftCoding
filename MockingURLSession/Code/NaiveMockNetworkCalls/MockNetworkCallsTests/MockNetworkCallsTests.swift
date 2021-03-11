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

    // We can instantiate the viewcontroller from the storyboard as an alternative
//    func testFromStoryBoard() {
//        let exp = expectation(description: "Loading URL")
//         let vc = (UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "viewcontroller") as! ViewController)
//        vc.downloadData(URLSession.shared, completionBlock: {data in
//            print (data)
//            exp.fulfill()
//        })
//        waitForExpectations(timeout: 10)
//    }

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
