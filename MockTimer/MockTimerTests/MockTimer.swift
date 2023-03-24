//
//  MockTimer.swift
//  ExchangeAndRatesTests
//
//  Created by Steven Curtis on 17/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import MockTimer

class MockTimer: TimerProtocol {
    var callback: (() -> Void)?
    var invalidated: Bool = false
    var repeats = 5
    func createScheduledTimer(withInterval interval: TimeInterval) {
        for _ in 0..<repeats {
            if let callback = callback {
                callback()
            }
        }
    }

    func register(callback: @escaping () -> Void) {
        self.callback = callback
    }

    func createScheduledTimer() { }

    func invalidate() {
        invalidated = true
    }
}
