//
//  SandwichStoreTests.swift
//  RecreateSandwichesTests
//
//  Created by Steven Curtis on 04/04/2023.
//

@testable import RecreateSandwiches
import XCTest

final class SandwichStoreTests: XCTestCase {
    func testInitializerEmpty() {
        let sut = SandwichStore()
        XCTAssertTrue(sut.sandwiches.isEmpty)
    }

    func testInitializer() {
        let sut = SandwichStore(sandwiches: data)
        XCTAssertTrue(sut.sandwiches.count == 2)
        XCTAssertEqual(sut.sandwiches, data)
    }
}
