//
//  ViewModel.swift
//  ReachabilityImplementation
//
//  Created by Steven Curtis on 30/03/2023.
//  Copyright © 2023 Steven Curtis. All rights reserved.
//

import Foundation

class ViewModel {
    let reachabilityManager: ReachabilityManagerProtocol
    init(
        reachabilityManager: ReachabilityManagerProtocol = ReachabilityManager.sharedInstance
    ) {
        self.reachabilityManager = reachabilityManager
    }

    func setupReachability(closure: @escaping (Bool) -> ()) {
        try? reachabilityManager.connectionCheck(completion: { reachable in
            closure(reachable)
        })
    }
}
