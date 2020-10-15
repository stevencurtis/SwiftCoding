//
//  NetworkManagerCacheTests.swift
//  CacheResponsesTests
//
//  Created by Steven Curtis on 15/10/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import CacheResponses


class NetworkManagerCacheTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    var urlSession: MockURLSession?
    var networkManager: NetworkManager<MockURLSession>?
    
    func testGetMethodNoBodyCacheReturns() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        let cacheManager = MockCacheManager()
        cacheManager.willReturn = true
        cacheManager.fetchData = Data("TEsts12".utf8)
        networkManager = NetworkManager(session: urlSession!, cacheManager: cacheManager)
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, completionBlock: { result in
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
    
    func testGetMethodNoBodyCacheNotReturns() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        let cacheManager = MockCacheManager()
        cacheManager.willReturn = false
        networkManager = NetworkManager(session: urlSession!, cacheManager: cacheManager)
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, completionBlock: { result in
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

}
