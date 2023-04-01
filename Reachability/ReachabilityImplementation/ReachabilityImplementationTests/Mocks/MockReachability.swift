//
//  MockReachability.swift
//  ReachabilityImplementationTests
//
//  Created by Steven Curtis on 04/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
@testable import ReachabilityImplementation

protocol  MockReachabilityAccessProtocol {
    func setReachable(set:Bool)
    func startThrows(willThrow: Bool)
    func setConnection(set: Reachability.Connection)
    func becomesAvaliable()
    var reachabilityStatus: Reachability.Connection { get }
}

typealias MockReachabilityProtocol = ReachabilityProtocol & MockReachabilityAccessProtocol

class MockReachability: MockReachabilityProtocol {
    var reachabilityStatus: Reachability.Connection = .cellular
    var whenReachable: Reachability.NetworkReachable?
    var whenUnreachable: Reachability.NetworkUnreachable?
    
    func becomesAvaliable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.whenReachable?( try! Reachability())
            })
    }
    
    func setConnection(set: Reachability.Connection) {
        connection = set
    }
    
    required init?(queueQos: DispatchQoS = .default, targetQueue: DispatchQueue? = nil) {
        connection = Reachability.Connection.unavailable
    }
    
    var connection: Reachability.Connection
    
    func startThrows(willThrow: Bool) {
        self.willThrow = willThrow
    }
    
    public typealias NetworkReachable = (MockReachability) -> Void
    public typealias NetworkUnreachable = (MockReachability) -> Void
    
    var reachable: Bool = true
    var willThrow: Bool = false
    func setReachable(set: Bool) {
        reachable = set
    }
    
    func stopNotifier() {}
    
    func startNotifier() throws {
        if willThrow{
            let error = NSError.init(domain: "", code: 000, userInfo: [:])
            throw error
        }
        DispatchQueue.main.async {
            if self.reachable {
                self.whenReachable?(try! Reachability())
            } else {
                self.whenUnreachable?(try! Reachability())
            }
        }
    }
}
