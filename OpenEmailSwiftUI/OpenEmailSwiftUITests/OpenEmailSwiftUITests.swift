//
//  OpenEmailSwiftUITests.swift
//  OpenEmailSwiftUITests
//
//  Created by Steven Curtis on 07/11/2023.
//

import XCTest
@testable import OpenEmailSwiftUI

final class OpenEmailSwiftUITests: XCTestCase {
    func testEmail() throws {
        let expectedUrl = URL(string: "mailto:support@example.com")
        let mockApplicationURLOpener = MockApplicationURLOpener()
        let vm = ViewModel(openURL: mockApplicationURLOpener)
        vm.email()
        XCTAssertEqual(mockApplicationURLOpener.urlOpened, expectedUrl)
    }
    
    func testEmailWithSubject() throws {
        let expectedUrl = URL(string: "mailto:support@example.com?subject=Feedback")
        let mockApplicationURLOpener = MockApplicationURLOpener()
        let vm = ViewModel(openURL: mockApplicationURLOpener)
        vm.emailWithSubject()
        XCTAssertEqual(mockApplicationURLOpener.urlOpened, expectedUrl)
    }
    
    func testEmailWithSubjectAndBody() throws {
        let expectedUrl = URL(string: "mailto:support@example.com?subject=Feedback&body=I%20wanted%20to%20share%20some%20feedback%20about...'the%20issue'%20ok")
        let mockApplicationURLOpener = MockApplicationURLOpener()
        let vm = ViewModel(openURL: mockApplicationURLOpener)
        vm.emailWithSubjectAndBody()
        XCTAssertEqual(mockApplicationURLOpener.urlOpened, expectedUrl)
    }
}

final class MockApplicationURLOpener: OpenURLProtocol {
    var urlOpened: URL?
    func open(_ url: URL) {
        urlOpened = url
    }
}
