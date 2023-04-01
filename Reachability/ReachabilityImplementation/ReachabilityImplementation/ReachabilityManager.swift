//
//  ReachabilityManager.swift
//  ReachabilityImplementation
//
//  Created by Steven Curtis on 04/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class ReachabilityManager: NSObject {
    static var sharedInstance: ReachabilityManagerProtocol = ReachabilityManager()
    
    var reachabilityStatus: Reachability.Connection = .cellular
    
    var isNetworkAvaliable: Bool {
        return reachabilityStatus != .unavailable
    }
    
    var reachability: ReachabilityProtocol = try! Reachability()
    
    @objc func reachabilityChanged(notification: Notification){
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
    
    func connectionCheck(completion: ((Bool) -> Void)? = nil) throws {
        try connectionCheck(notificationCenter: NotificationCenter.default, completion: completion)
    }
    
    func connectionCheck(
        notificationCenter: NotificationCenter = NotificationCenter.default,
        completion: ((Bool) -> Void)? = nil) throws {

        reachability.whenReachable = {reachability in
            completion?(true)
        }
        reachability.whenUnreachable = {reachability in
            completion?(false)
        }
        
        do{
            try reachability.startNotifier()
            NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: .reachabilityChanged, object: reachability)
        } catch {
            throw error
        }
    }
    
    func stopMonitoring() {
        try? reachability.startNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
