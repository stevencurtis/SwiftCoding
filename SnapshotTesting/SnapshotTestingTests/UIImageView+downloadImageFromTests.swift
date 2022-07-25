//
//  UIImageView+downloadImageFromTests.swift
//  SnapshotTestingTests
//
//  Created by Steven Curtis on 24/09/2020.
//

import XCTest
@testable import SnapshotTesting
import NetworkLibrary


class UIImageView_downloadImageFromTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testupdateImage() {
        let expectation = XCTestExpectation(description: #function)
        let mockNetwork = MockNetworkManager(session: URLSession.shared)
        let imageData = UIImage(named: "Disclosure.png", in: Bundle(for: type(of: self)), compatibleWith: nil)?.pngData()
        mockNetwork.outputData = imageData
        let imageView = MockImageView()
        imageView.finished = {
            expectation.fulfill()
            XCTAssertEqual(imageView.image?.pngData(), imageData)
        }
        imageView.downloadImageFrom(with: URL(string: "www.google.com")!, network: mockNetwork, contentMode: .redraw)
        XCTAssertEqual(true, mockNetwork.didFetch)
        wait(for: [expectation], timeout: 2.0)
    }

}
