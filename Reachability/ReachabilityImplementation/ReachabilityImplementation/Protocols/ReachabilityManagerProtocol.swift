//
//  ReachabilityManagerProtocol.swift
//  ReachabilityImplementation
//
//  Created by Steven Curtis on 04/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

public protocol ReachabilityManagerProtocol {
    static var sharedInstance: ReachabilityManagerProtocol { get }
    func connectionCheck(notificationCenter: NotificationCenter, completion: ((Bool) -> Void)?) throws
    func connectionCheck(completion: ((Bool) -> Void)?) throws
    func stopMonitoring()
    var reachability: ReachabilityProtocol { get set }
    func reachabilityChanged(notification: Notification)
    var reachabilityStatus: Reachability.Connection { get }
}
