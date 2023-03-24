//
//  ExchangeTimer.swift
//  ExchangeAndRates
//
//  Created by Steven Curtis on 17/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

final class ExchangeTimer: TimerProtocol {
    private var callback: (() -> Void)?

    func invalidate() {
        timer?.invalidate()
    }

    private var timer: Timer?

    func createScheduledTimer(withInterval interval: TimeInterval) {
        timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(timerCallback),
            userInfo: nil,
            repeats: true)
    }

    func register(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    @objc func timerCallback() {
        callback?()
    }
}
