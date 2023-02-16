//
//  FuturesBasicTests.swift
//  FuturesBasicTests
//
//  Created by Steven Curtis on 19/09/2021.
//

import Combine
import XCTest
@testable import FuturesBasic

final class FuturesBasicTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    let viewModel = ViewModel()
    
    func testReceiveCompletion() {
        let expect = expectation(description: #function)
        viewModel.download()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        expect.fulfill()
                    case .failure:
                        XCTFail()
                    }
                },
                receiveValue: { _ in})
            .store(in: &subscriptions)
        
        waitForExpectations(timeout: 3)
    }
    
    func testReceiveValue() {
        let expect = expectation(description: #function)
        let expected: Users = .init(
            page: 0,
            perPage: 0,
            total: 0,
            totalPages: 0,
            data: [],
            support: .init(url: "", text: "")
        )
        viewModel.download()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    XCTAssertEqual(expected, $0)
                    expect.fulfill()
                })
            .store(in: &subscriptions)
        
        waitForExpectations(timeout: 3)
    }
}
