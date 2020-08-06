//
//  LoginViewModelTests.swift
//  CombineURLSessionTests
//
//  Created by Steven Curtis on 10/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import Combine
@testable import CombineURLSession

class LoginViewModelTests: XCTestCase {

    var lvm: LoginViewModel<HTTPManagerMock<URLSessionMock>>?
    
    override func setUpWithError() throws {
        let urlSession = URLSessionMock()
        let nm = HTTPManagerMock(session: urlSession)
        let ud = UserDataManagerMock()
        lvm = LoginViewModel(networkManager: nm, userdatamanager: ud)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private var cancellables: Set<AnyCancellable> = []

    func testLVMPasswordFail() {
        passwordLength = 5
        let expect = expectation(description: #function)
        lvm?.password = "test"
        lvm?.validLengthPassword.sink(receiveValue: {res in
            XCTAssertEqual(res, false)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testLVMPasswordPass() {
        passwordLength = 4
        let expect = expectation(description: #function)
        lvm?.password = "testing"
        lvm?.validLengthPassword.sink(receiveValue: {res in
            XCTAssertEqual(res, true)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testLVMUsernameFail() {
        passwordLength = 5
        let expect = expectation(description: #function)
        lvm?.username = "test"
        lvm?.validLengthUsername.sink(receiveValue: {res in
            XCTAssertEqual(res, false)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testLVMUsernamePass() {
        passwordLength = 4
        let expect = expectation(description: #function)
        lvm?.username = "testing"
        lvm?.validLengthUsername.sink(receiveValue: {res in
            XCTAssertEqual(res, true)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testLVMUservalidationFail() {
        passwordLength = 5
        let expect = expectation(description: #function)
        lvm?.password = "test"
        lvm?.username = "test"
        lvm?.userValidation.sink(receiveValue: {res in
            XCTAssertEqual(res, false)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testLVMUservalidationFailPW() {
        passwordLength = 5
        let expect = expectation(description: #function)
        lvm?.password = ""
        lvm?.username = "test"
        lvm?.userValidation.sink(receiveValue: {res in
            XCTAssertEqual(res, false)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testLVMUservalidationFailUsername() {
        passwordLength = 5
        let expect = expectation(description: #function)
        lvm?.password = "test"
        lvm?.username = ""
        lvm?.userValidation.sink(receiveValue: {res in
            XCTAssertEqual(res, false)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testLVMUservalidationPass() {
        passwordLength = 4
        let expect = expectation(description: #function)
        lvm?.password = "testing"
        lvm?.username = "testing"
        lvm?.userValidation.sink(receiveValue: {res in
            XCTAssertEqual(res, true)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    // this will only work when we call login() - this calls the mock not the real
    // http manager
    func testLoginPass() {
        let expect = expectation(description: #function)
        lvm?.shouldNav.sink(receiveValue: {res in
            XCTAssertEqual(res, true)
            expect.fulfill()
        }).store(in: &cancellables)
        lvm?.login()
        waitForExpectations(timeout: 2.0)
    }
}
