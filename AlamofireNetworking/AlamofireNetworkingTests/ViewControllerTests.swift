//
//  ViewControllerTests.swift
//  AlamofireNetworkingTests
//
//  Created by Steven Curtis on 18/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import Alamofire
@testable import AlamofireNetworking

class ViewControllerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewControllerSuccess() {
        let expect = expectation(description: #function)
        let viewController = ViewController()
        
        let data = jsonString.data(using: .utf8)
        
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [URLProtocolMock.self] + (configuration.protocolClasses ?? [])
        
        let session = Session(configuration: configuration)
        
        let networkManager = NetworkManager(
            session: session,
            router: JSONPlaceHolderAPIAction.getToDo(id: 2))
        
        viewController.downloadData(networkManager, completion: { response in
            let expectedModel = jsonString.data(using: .utf8)
            
            switch response {
            case .failure:
                XCTFail()
            case .success(let data):
                XCTAssertEqual(expectedModel, data)
                expect.fulfill()
            }
        })
        wait(for: [expect], timeout: 1.0)
    }
    
    func testViewControllerSuccessMockRouter() {
        let expect = expectation(description: #function)
        let viewController = ViewController()
        let mockRoute = APIRouterMock.get
        
        let data = jsonString.data(using: .utf8)
        
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [URLProtocolMock.self] + (configuration.protocolClasses ?? [])
        
        let session = Session(configuration: configuration)
        
        let networkManager = NetworkManager(
            session: session,
            router: mockRoute)
        
        viewController.downloadData(networkManager, completion: { response in
            let expectedModel = jsonString.data(using: .utf8)
            
            switch response {
            case .failure:
                XCTFail()
            case .success(let data):
                XCTAssertEqual(expectedModel, data)
                expect.fulfill()
            }
        })
        wait(for: [expect], timeout: 1.0)
    }
    
    func testViewControllerFailure() {
        let expect = expectation(description: #function)
        let viewController = ViewController()
        
        URLProtocolMock.requestHandler = { request in
            throw NSError.init(domain: "", code: 400, userInfo: [:])
        }
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [URLProtocolMock.self] + (configuration.protocolClasses ?? [])
        
        let session = Session(configuration: configuration)
        
        let networkManager = NetworkManager(
            session: session,
            router: JSONPlaceHolderAPIAction.getToDo(id: 2))
        
        viewController.downloadData(networkManager, completion: { response in
            switch response {
            case .failure(let error):
                XCTAssertNotNil(error)
                expect.fulfill()
            case .success:
                XCTFail()
            }
        })
        wait(for: [expect], timeout: 1.0)
    }
}
