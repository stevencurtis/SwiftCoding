//
//  NetworkOperationTests.swift
//  OperationQueueDependentAPICallsTests
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import OperationQueueDependentAPICalls

class NetworkOperationTests: XCTestCase {

    var networkOperation: NetworkOperation?
    
    override func setUpWithError() throws {
        networkOperation = NetworkOperation()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitial() {
        XCTAssert(networkOperation!.isReady)
    }
    
    func testExecuting() {
        XCTAssertFalse(networkOperation!.isExecuting)
    }
    
    func testFinished() {
        XCTAssertFalse(networkOperation!.isFinished)
    }
    
    func testStart() {
        networkOperation?.start()
        XCTAssert(networkOperation!.isExecuting)
    }

    func testCancelled() {
        networkOperation?.start()
        networkOperation?.cancel()
        XCTAssertFalse(networkOperation!.isExecuting)
    }

    func testCancelledBeforeStart() {
        networkOperation?.cancel()
        networkOperation?.start()
        XCTAssertFalse(networkOperation!.isExecuting)
    }
}
