//
//  AlamofireNetworkingTests.swift
//  AlamofireNetworkingTests
//
//  Created by Steven Curtis on 17/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import Alamofire
@testable import AlamofireNetworking

class AlamofireNetworkingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSuccessfulResponse() {
        let expect = expectation(description: #function)
        let data = jsonString.data(using: .utf8)

        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [URLProtocolMock.self] + (configuration.protocolClasses ?? [])

        let session = Session(configuration: configuration)
        
        session.request(URL(fileURLWithPath: "")).responseData(completionHandler: {response in
            switch response.result {
            case .success(let data):
                print (data)
                let decoder = JSONDecoder()
                let model = try! decoder.decode(ToDoModel.self, from:data)
                XCTAssertEqual(model.completed, true)
                XCTAssertEqual(model.id, 1)
                XCTAssertEqual(model.title, "Mr")
                XCTAssertEqual(model.userId, 2)
                expect.fulfill()
            case .failure(let error):
                print (error)
                XCTFail()
            }
        })
        wait(for: [expect], timeout: 1.0)
    }

}
