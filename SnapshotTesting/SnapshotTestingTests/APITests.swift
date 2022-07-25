//
//  APITests.swift
//  SnapshotTestingTests
//
//  Created by Steven Curtis on 24/09/2020.
//

import XCTest
@testable import SnapshotTesting


class APITests: XCTestCase {
    func testAPI() {
        XCTAssertEqual(API.photos.url, URL(string: "https://jsonplaceholder.typicode.com/photos")!)
    }
}
