//
//  ContentViewModelTests.swift
//  LazyNavigationLinkTests
//
//  Created by Steven Curtis on 10/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import Combine
@testable import LazyNavigationLink

class ContentViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private var cancellables: Set<AnyCancellable> = []
    var contentViewModel: ContentViewModel?
    
    func testModel() {
        let expectation = XCTestExpectation(description: #function)
        contentViewModel = ContentViewModel()
        var results: [[String]] = []
        
        contentViewModel?.$animals
            .eraseToAnyPublisher()
            .sink(receiveValue: { val in
                results.append(val)
                if results.count == 2 {
                    expectation.fulfill()
                }
            }).store(in: &cancellables)
        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(results, [["🦒", "🦮", "🐖", "🦔", "🦓", "🦢", "🦋"],
                                 ["🦒", "🦒", "🦒" , "🦒", "🦒", "🦒", "🦒"]])
    }

}
