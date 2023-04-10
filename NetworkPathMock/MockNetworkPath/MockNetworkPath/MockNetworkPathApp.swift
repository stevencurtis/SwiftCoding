//
//  MockNetworkPathApp.swift
//  MockNetworkPath
//
//  Created by Steven Curtis on 09/04/2023.
//

import SwiftUI

@main
struct MockNetworkPathApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(networkPathMonitor: NetworkPathMonitor())
        }
    }
}
