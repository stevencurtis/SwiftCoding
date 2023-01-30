//
//  DetailViewModelTests.swift
//  LazyNavigationLinkTests
//
//  Created by Steven Curtis on 10/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import Combine
@testable import LazyNavigationLink

class DetailViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    var detailViewModel: DetailViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModel() {
        let expectation = XCTestExpectation(description: #function)
        let inputString = "Test String"
        detailViewModel = DetailViewModel(text: inputString)
        detailViewModel?.$text
            .eraseToAnyPublisher()
            .sink(receiveValue: { val in
                expectation.fulfill()
                XCTAssertEqual(val, inputString)
            }).store(in: &cancellables)
        wait(for: [expectation], timeout: 3.0)
    }

}
