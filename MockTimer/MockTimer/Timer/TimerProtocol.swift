//
//  TimerProtocol.swift
//  ExchangeAndRates
//
//  Created by Steven Curtis on 17/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

protocol TimerProtocol {
    func register(callback: @escaping () -> Void)
    func createScheduledTimer(withInterval interval: TimeInterval)
    func invalidate()
}
