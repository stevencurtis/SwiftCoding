//
//  ReachabilityProtocol.swift
//  ReachabilityImplementation
//
//  Created by Steven Curtis on 04/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

public protocol ReachabilityProtocol {
    var whenReachable: Reachability.NetworkReachable? { get set }
    var whenUnreachable: Reachability.NetworkUnreachable? { get set }
    func startNotifier() throws
    func stopNotifier()
    var connection: Reachability.Connection { get }
}
