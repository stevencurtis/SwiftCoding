//
//  ReachabilityTests.swift
//  ReachabilityImplementationTests
//
//  Created by Steven Curtis on 05/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
@testable import ReachabilityImplementation

class ReachabilityTests: XCTestCase {
    var mock: ReachabilityManagerProtocol!
    
    override func setUp() {
        super.setUp()
        mock = MockReachabilityManager.sharedInstance
    }
    
    func testViewModel_isTrue() {
        let expected = true
        (mock as! MockReachabilityManagerProtocol).setReachable(isReachable: true)
        let viewModel = ViewModel(reachabilityManager: mock)
        try? viewModel.reachabilityManager.connectionCheck(completion: {
            XCTAssertEqual($0, expected)
        })
    }
    
    func testViewModel_isFalse() {
        let expected = false
        (mock as! MockReachabilityManagerProtocol).setReachable(isReachable: false)
        let viewModel = ViewModel(reachabilityManager: mock)
        try? viewModel.reachabilityManager.connectionCheck(completion: {
            XCTAssertEqual($0, expected)
        })
    }
}
