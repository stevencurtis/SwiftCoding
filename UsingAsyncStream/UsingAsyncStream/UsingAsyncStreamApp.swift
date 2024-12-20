//
//  UsingAsyncStreamApp.swift
//  UsingAsyncStream
//
//  Created by Steven Curtis on 25/10/2024.
//

import SwiftUI

@main
struct UsingAsyncStreamApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView(timerViewModel: TimerViewModel())
        }
    }
}
