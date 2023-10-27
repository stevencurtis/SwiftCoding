//
//  OpenCallSwiftUITests.swift
//  OpenCallSwiftUITests
//
//  Created by Steven Curtis on 18/10/2023.
//

import XCTest
@testable import OpenCallSwiftUI

final class OpenCallSwiftUITests: XCTestCase {
    func testCall() throws {
        let expectedUrl = URL(string: "tel://08000480408")
        let mockApplicationURLOpener = MockApplicationURLOpener()
        let vm = ViewModel(openURL: mockApplicationURLOpener)
        vm.callNumber()
        XCTAssertEqual(mockApplicationURLOpener.urlOpened, expectedUrl)
    }
}

final class MockApplicationURLOpener: OpenURLProtocol {
    var urlOpened: URL?
    func open(_ url: URL) {
        urlOpened = url
    }
}
