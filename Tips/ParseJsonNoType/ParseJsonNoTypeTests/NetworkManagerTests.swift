//
//  NetworkManagerTests.swift
//  ParseJsonNoTypeTests
//
//  Created by Steven Curtis on 06/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import ParseJsonNoType


class NetworkManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    var urlSession: MockURLSession?
    var networkManager: NetworkManager<MockURLSession>?
    
    func testSuccessfulURLResponse() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = NetworkManager(session: urlSession!)
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, data: nil, completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, "TEsts12")
                expect.fulfill()
            case .failure:
                XCTFail()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    
    func testFailureURLResponse() {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = NetworkManager(session: urlSession!)
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, data: [:], completionBlock: {result in
            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 101)
                expect.fulfill()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testBadlyFormattedURLResponse() {
        urlSession = MockURLSession()
        networkManager = NetworkManager(session: urlSession!)
        let expectation = XCTestExpectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, data: nil, completionBlock: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
}
