//
//  ReachabilityManagerTests.swift
//  ReachabilityImplementationTests
//
//  Created by Steven Curtis on 05/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
@testable import ReachabilityImplementation

class ReachabilityManagerTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testReachabilityCheckAddNotification() {
        let expectation = XCTestExpectation(description: #function)
        let mr = MockReachability()
        mr?.setReachable(set: false)
        ReachabilityManager.sharedInstance.reachability = mr!
        try? ReachabilityManager.sharedInstance.connectionCheck(completion: {res in
            XCTAssertFalse(res)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 4.0)
    }
    
    func testConnectionWhenReachable() {
        let expectation = XCTestExpectation(description: #function)
        guard let mr = MockReachability() else {XCTFail("MockReachability returned nil"); return}
        mr.setReachable(set: false)
        mr.becomesAvaliable()
        ReachabilityManager.sharedInstance.reachability = mr
        try? ReachabilityManager.sharedInstance.connectionCheck(completion: {res in
            if res {
                XCTAssertTrue(res)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 4.0)
    }

    func testConnectionThrows() {
        let expectation = XCTestExpectation(description: #function)
        let mr = MockReachability()
        mr?.startThrows(willThrow: true)
        ReachabilityManager.sharedInstance.reachability = mr!
        do {
            try ReachabilityManager.sharedInstance.connectionCheck(completion: {res in
            })
        } catch {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 4.0)
    }

    func testReachabilityChangedWiFi() {
        let mr = MockReachability()
        mr?.setConnection(set: .wifi)
        ReachabilityManager.sharedInstance.reachability = mr!
        try? ReachabilityManager.sharedInstance.connectionCheck(completion: nil)
        let notification = Notification(name: .reachabilityChanged, object: mr, userInfo: [:])
        ReachabilityManager.sharedInstance.reachabilityChanged(notification: notification)
        XCTAssertEqual(ReachabilityManager.sharedInstance.reachabilityStatus, .wifi)
    }

    func testReachabilityChangedCellular() {
        let mr = MockReachability()
        mr!.setConnection(set: .cellular)
        ReachabilityManager.sharedInstance.reachability = mr!
        try? ReachabilityManager.sharedInstance.connectionCheck(completion: nil)
        let notification = Notification(name: .reachabilityChanged, object: mr, userInfo: [:])
        ReachabilityManager.sharedInstance.reachabilityChanged(notification: notification)
        XCTAssertEqual(ReachabilityManager.sharedInstance.reachabilityStatus, .cellular)
    }
}
