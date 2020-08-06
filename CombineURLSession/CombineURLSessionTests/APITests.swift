//
//  APITests.swift
//  CombineURLSessionTests
//
//  Created by Steven Curtis on 10/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import CombineURLSession

class APITests: XCTestCase {
    func testLogin() {
        XCTAssertEqual(API.login.url!, URL(string:"https://reqres.in/api/login"))
    }
    
    func testRegister() {
        XCTAssertEqual(API.register.url!, URL(string:"https://reqres.in/api/register"))
    }
}
