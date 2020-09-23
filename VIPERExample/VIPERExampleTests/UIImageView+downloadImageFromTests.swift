//
//  UIImageView+downloadImageFromTests.swift
//  VIPERExampleTests
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import VIPERExample
import NetworkLibrary

class UIImageView_downloadImageFromTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
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


