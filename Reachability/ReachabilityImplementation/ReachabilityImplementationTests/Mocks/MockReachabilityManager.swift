//
//  MockReachabilityManager.swift
//  ReachabilityImplementationTests
//
//  Created by Steven Curtis on 04/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
@testable import ReachabilityImplementation

protocol MockReachabilityManagerAccessProtocol {
    func setReachable(isReachable: Bool)
}

typealias MockReachabilityManagerProtocol = ReachabilityManagerProtocol & MockReachabilityManagerAccessProtocol

class MockReachabilityManager: MockReachabilityManagerProtocol {
    func connectionCheck(notificationCenter: NotificationCenter, completion: ((Bool) -> Void)?) throws { }
    
    var isReachable = true
    var reachabilityStatus: Reachability.Connection = .cellular
    var reachability: ReachabilityProtocol = try! Reachability()
    static var sharedInstance: ReachabilityManagerProtocol = MockReachabilityManager()

    func setReachable(isReachable: Bool) {
        self.isReachable = isReachable
    }
    
    func reachabilityChanged(notification: Notification) {
        if let reachability = notification.object as? ReachabilityProtocol {
            switch reachability.connection {
            case .none:
                reachabilityStatus = .unavailable
            case .wifi:
                reachabilityStatus = .wifi
            case .cellular:
                reachabilityStatus = .cellular
            case .unavailable:
                reachabilityStatus = .unavailable
            }
        }
    }
    
    func connectionCheck(completion: ((Bool) -> Void)?) throws{
        reachability.whenReachable = { reachability in
            completion?(true)
        }
        reachability.whenUnreachable = { reachability in
            completion?(false)
        }
        if isReachable {
            reachability.whenReachable!(try Reachability())
        } else {
            reachability.whenUnreachable!(try Reachability())
        }
    }
    
    func connectionCheck(notificationCenter: Notification, completion: ((Bool) -> Void)?) throws {}
    
    func stopMonitoring() { }
}
