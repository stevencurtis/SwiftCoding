//
//  CacheTest.swift
//  CacheResponsesTests
//
//  Created by Steven Curtis on 15/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import CacheResponses

class CacheTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    var urlSession: MockURLSession?
    var networkManager: AnyNetworkManager<MockURLSession>?
    
    // check whether the cache would return data - should be in the test for Network Manager
    func testGetMethodNoBody() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        let mockCache = MockCacheManager()
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!, cacheManager: mockCache))
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
    
    func testCache() {
        let expect = expectation(description: #function)
        let cache = CacheManagerNSCache.shared
        let data = Data("TEsts12".utf8)
        let url = URL(string: "www.testurl.com")
        let request = URLRequest(url: url!)
        cache.storeDataToCache(request: request, data: data)
        cache.fetchDataFromCache(request: request, completion: { returnedData in
            XCTAssertEqual(data, returnedData)
            expect.fulfill()
        })
        waitForExpectations(timeout: 3.0)
    }
}
