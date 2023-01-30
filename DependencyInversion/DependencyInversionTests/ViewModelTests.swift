//
//  ViewModelTests.swift
//  DependencyInversionTests
//
//  Created by Steven Curtis on 20/01/2023.
//

import XCTest
@testable import DependencyInversion

class ViewModelTests: XCTestCase {
    func testViewModel() {
        let mockNetworkManager = MockNetworkManager(session: URLSession.shared)
        let vm = ViewModel(networkManager: mockNetworkManager)
        var resultData: Data?
        vm.resultClosure = { result in
            resultData = result
        }
        vm.fetch()
        XCTAssertNotNil(resultData)
    }
}
