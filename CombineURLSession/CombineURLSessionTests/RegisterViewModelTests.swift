//
//  RegisterViewModelTests.swift
//  CombineURLSessionTests
//
//  Created by Steven Curtis on 13/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import Combine
@testable import CombineURLSession


class RegisterViewModelTests: XCTestCase {
    
    var rvm: RegistrationViewModel<HTTPManagerMock<URLSessionMock>>?
    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        let urlSession = URLSessionMock()
        let nm = HTTPManagerMock(session: urlSession)
        let ud = UserDataManagerMock()
        rvm = RegistrationViewModel(networkManager: nm, userdatamanager: ud)
    }

    override func tearDownWithError() throws {
    }

    func testLVMPasswordFail() {
        passwordLength = 5
        let expect = expectation(description: #function)
        rvm?.password = "test"
        rvm?.validLengthPassword.sink(receiveValue: {res in
            XCTAssertEqual(res, false)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testLVMPasswordPass() {
        passwordLength = 4
        let expect = expectation(description: #function)
        rvm?.password = "testing"
        rvm?.validLengthPassword.sink(receiveValue: {res in
            XCTAssertEqual(res, true)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testRegister() {
        let expect = expectation(description: #function)
        rvm?.shouldNav.sink(receiveValue: {res in
            XCTAssertEqual(res, true)
            expect.fulfill()
        }).store(in: &cancellables)
        rvm?.register()
        waitForExpectations(timeout: 2.0)
    }
    
    func testvalidMatchPasswordPass() {
        let expect = expectation(description: #function)
        rvm?.password = "testing"
        rvm?.repeatPassword = "testing"
        
        rvm?.validMatchPassword.sink(receiveValue: {res in
            XCTAssertEqual(res, true)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testvalidMatchPasswordFail() {
        let expect = expectation(description: #function)
        rvm?.password = "testing"
        rvm?.repeatPassword = "tes"
        
        rvm?.validMatchPassword.sink(receiveValue: {res in
            XCTAssertEqual(res, false)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testvalidPasswordFail() {
        let expect = expectation(description: #function)
        rvm?.password = "testing"
        rvm?.repeatPassword = "tes"
        
        rvm?.validPassword.sink(receiveValue: {res in
            XCTAssertEqual(res, false)
            expect.fulfill()
        }).store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }

}
