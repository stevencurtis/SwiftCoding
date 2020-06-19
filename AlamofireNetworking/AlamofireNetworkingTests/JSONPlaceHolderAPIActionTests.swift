//
//  JSONPlaceHolderAPIAction.swift
//  AlamofireNetworkingTests
//
//  Created by Steven Curtis on 18/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import Alamofire
@testable import AlamofireNetworking

class JSONPlaceHolderAPIActionTests: XCTestCase {
    func testAPI() {
        let router = JSONPlaceHolderAPIAction.getToDo(id: 8)
        XCTAssertEqual(router.urlRequest?.description, "https://jsonplaceholder.typicode.com/todos/8")
    }
}
