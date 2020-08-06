//
//  KeyChainManagerTests.swift
//  KeychainImplementationTests
//
//  Created by Steven Curtis on 14/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import CombineURLSession

class KeyChainManagerTests: XCTestCase {
    
    /// Test saving in the keychain manager
    func testKCSave() {
        let exp = expectation(description: "save")
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        if let dta = "testData".data(using: .utf16) {
            let ret = manager.save(key: "test", data: dta )
            if let elementdata = mockKeyChain.element["test"], let data = elementdata as? Data {
                XCTAssertEqual(ret, 0)
                XCTAssertEqual(dta, data)
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 1.0)
    }
    
    /// Test saving in the keychain manager
    func testKCSaveEmpty() {
        let exp = expectation(description: "save")
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        if let dta = "".data(using: .utf16) {
            let ret = manager.save(key: "test", data: dta )
            if let elementdata = mockKeyChain.element["test"], let data = elementdata as? Data {
                XCTAssertEqual(ret, 0)
                XCTAssertEqual(dta, data)
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 1.0)
    }
    
    /// test loading in the keychain manager
    func testKCLoad() {
        let exp = expectation(description: "load")
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        
        if let data = "testData".data(using: .utf16) {
            // update the mockKeyChain without testing the process of saving
            mockKeyChain.element["test"] = data
            let t = manager.load(key: "test")
            XCTAssertEqual(data, t)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    /// test loading in the keychain manager
    func testKCLoadEmpty() {
        let exp = expectation(description: "load")
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        
        if let data = "".data(using: .utf16) {
            // update the mockKeyChain without testing the process of saving
            mockKeyChain.element["test"] = data
            let t = manager.load(key: "test")
            XCTAssertEqual(data, t)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    /// Tests the roundtrip of saving and loading, technically should not be tested
    func testKCSaveLoad() {
        let exp = expectation(description: "saveload")
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        if let data = "testData".data(using: .utf16) {
            let ret = manager.save(key: "test", data: data )
            if let expectedData = mockKeyChain.element["test"] as? Data {
                XCTAssertEqual(expectedData, data)
                XCTAssertEqual(ret, 0)
                exp.fulfill()
            } else {
                XCTFail()
            }
        }
        waitForExpectations(timeout: 1.0)
    }
    
    /// test deleting in the keychain manager
    func testKCDelete() {
        let exp = expectation(description: "delete")
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        if let data = "testData".data(using: .utf16) {
            // update the mockKeyChain without testing the process of saving
            mockKeyChain.element["test"] = data
            let t = try? manager.delete(key: "test")
            XCTAssertEqual(0, t)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    /// test deleting in the keychain manager an element that does not exist
    func testKCDeleteMissing() {
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        let t = try? manager.delete(key: "test")
        XCTAssertEqual(nil, t)
    }
    
    /// test deleting in the keychain manager
    func testKCDeleteWithData() {
        let exp = expectation(description: "delete")
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        
        if let data = "testData".data(using: .utf16) {
            // update the mockKeyChain without testing the process of saving
            mockKeyChain.element["test"] = data
            let t = try? manager.delete(key: "test", data: data)
            XCTAssertEqual(0, t)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    /// test deleting in the keychain manager an element that does not exist
    func testKCDeleteMissingWithData() {
        let exp = expectation(description: "delete")
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        if let data = "testData".data(using: .utf16) {
            let t = try? manager.delete(key: "test", data: data)
            XCTAssertEqual(0, t)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }

    
    //-------------------------------- Test Queries --------------------------------//
    
    
    func testSaveQuery() {
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        guard let dta = "A Test String".data(using: .utf16) else { XCTFail(); return }
        let query = manager.createSaveQuery(key: "Test", data: dta )
        
        let exampleDictionary: [String: Any] = [
            "v_Data": dta,
            "class": "genp",
            "acct": "Test",
        ]
        
        XCTAssertTrue(query == exampleDictionary)
    }
    
    func testSaveQueryNoData() {
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        guard let dta = "".data(using: .utf16) else { XCTFail(); return }
        let query = manager.createSaveQuery(key: "Test", data: dta )
        
        let exampleDictionary: [String: Any] = [
            "v_Data": dta,
            "class": "genp",
            "acct": "Test",
        ]
        
        XCTAssertTrue(query == exampleDictionary)
    }
    
    func testLoadQuery() {
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        let query = manager.createSearchQuery(key: "A Test String")
        let exampleDictionary: [String: Any] = [
            "m_Limit": kSecMatchLimitOne,
            "class": "genp" as CFString,
            "acct": "A Test String",
            "r_Data": kCFBooleanTrue!,
        ]
        XCTAssertTrue(query == exampleDictionary)
    }
    
    func testLoadQueryNoKey() {
        let mockKeyChain = KeyChainMock()
        let manager = KeyChainManager(mockKeyChain)
        let query = manager.createSearchQuery(key: "")
        let exampleDictionary: [String: Any] = [
            "m_Limit": kSecMatchLimitOne,
            "class": "genp" as CFString,
            "acct": "",
            "r_Data": kCFBooleanTrue!,
        ]
        XCTAssertTrue(query == exampleDictionary)
    }
}
