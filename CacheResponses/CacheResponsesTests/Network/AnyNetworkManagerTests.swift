//  Created by Steven Curtis

import XCTest
@testable import CacheResponses

class AnyNetworkManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var urlSession: MockURLSession?
    var networkManager: AnyNetworkManager<MockURLSession>?
    
    func testGetMethodNoBody() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
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
    
    func testSuccessfulGetURLResponse() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
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
    
    func testSuccessfulPatchURLResponse() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .patch, completionBlock: { result in
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
    
    func testSuccessfulPutURLResponse() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .put, completionBlock: { result in
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
    
    func testSuccessfulDeleteURLResponse() {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .delete, completionBlock: { result in
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
    
    func testFailureGetURLResponse() {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get, headers: [:], token: nil, completionBlock: {result in
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
    
    func testFailurePatchURLResponse() {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .patch, headers: [:], token: nil, completionBlock: {result in
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
    
    func testFailurePutURLResponse() {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .put, headers: [:], token: nil, completionBlock: {result in
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
    
    func testFailureDeleteURLResponse() {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .delete, completionBlock: {result in
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
    
    func testBadlyFormattedgetURLResponse() {
        urlSession = MockURLSession()
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
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
    
    func testBadlyFormattedputURLResponse() {
        urlSession = MockURLSession()
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
        let expectation = XCTestExpectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .put, headers: [:], token: nil, data: nil, completionBlock: { result in
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
    
    func testBadlyFormattedDeleteURLResponse() {
        urlSession = MockURLSession()
        networkManager = AnyNetworkManager(manager: NetworkManager(session: urlSession!))
        let expectation = XCTestExpectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .delete, headers: [:], token: nil, data: nil, completionBlock: { result in
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
