//
//  HTTPManagerTests.swift
//  CombineURLSessionTests
//
//  Created by Steven Curtis on 10/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import Combine
@testable import CombineURLSession

class HTTPManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var urlSession: URLSessionMock?
    var httpManager: HTTPManager<URLSessionMock>?
    
    var publisher: AnyCancellable?
    var pst: Publishers.ReceiveOn<AnyPublisher<RegisterModel, Error>, DispatchQueue>?
    
    // Replace HTTPManager's session with a mock - testing http manager (Success)
    func testSuccessfulURLResponse() {
        urlSession = URLSessionMock()
        httpManager = HTTPManager(session: urlSession!)
        let expect = expectation(description: #function)
        let url = URL(string: "https://www.testurl.com")
        pst =
            httpManager?.post(url: url!,
                              headers: ["Content-Type": "application/x-www-form-urlencoded"],
                              data: "email=eve.holt@reqres.in&password=cityslicka".data(using: .utf8)!)
                .receive(on: DispatchQueue.main)
        
        publisher = pst!.sink(receiveCompletion: {comp in
        }, receiveValue: {val in
            XCTAssertEqual(val, RegisterModel(id: 99, token: "QpwL5tke4Pnpja7X4"))
            expect.fulfill()
        })
        waitForExpectations(timeout: 4.0)
    }
    
    // Replace HTTPManager's session with a mock - testing http manager (Success)
    func testFailureURLResponse() {
        urlSession = URLSessionMock()
        urlSession?.jsonName = "RegisterSuccessNot.json"
        
        httpManager = HTTPManager(session: urlSession!)
        let expect = expectation(description: #function)
        let url = URL(string: "https://www.testurl.com")
        
        pst =
            httpManager?.post(url: url!,
                              headers: ["Content-Type": "application/x-www-form-urlencoded"],
                              data: "email=eve.holt@reqres.in&password=cityslicka".data(using: .utf8)!)
                .receive(on: DispatchQueue.main)
        publisher = pst!.sink(receiveCompletion: {
            print ($0)
            switch $0 {
                case .finished: break
                case .failure(let error):
                    XCTAssertEqual ( (error as NSError).code, 4864 )
            }
            expect.fulfill()
        }, receiveValue: {val in
            XCTFail()
        })
        waitForExpectations(timeout: 4.0)
    }
    
    
    
}
