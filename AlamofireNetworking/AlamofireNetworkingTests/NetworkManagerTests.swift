//
//  NetworkManagerTests.swift
//  AlamofireNetworkingTests
//
//  Created by Steven Curtis on 18/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import Alamofire
@testable import AlamofireNetworking

class NetworkManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNetworkManager() {
        let expect = expectation(description: #function)
        let mockRoute = APIRouterMock.get
        let data = jsonString.data(using: .utf8)
        
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [URLProtocolMock.self] + (configuration.protocolClasses ?? [])
        let session = Session(configuration: configuration)
        let networkManager = NetworkManager(session: session, router: mockRoute)
        
        networkManager.get(completionBlock: {response in
            let data = response.data
            let decoder = JSONDecoder()
            let model = try! decoder.decode(ToDoModel.self, from:data!)
            XCTAssertEqual(model.completed, true)
            XCTAssertEqual(model.id, 1)
            XCTAssertEqual(model.title, "Mr")
            XCTAssertEqual(model.userId, 2)
            expect.fulfill()
        })
        wait(for: [expect], timeout: 1.0)
    }
}
