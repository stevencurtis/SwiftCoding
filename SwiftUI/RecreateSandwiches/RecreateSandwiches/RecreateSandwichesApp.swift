//
//  RecreateSandwichesApp.swift
//  RecreateSandwiches
//
//  Created by Steven Curtis on 09/10/2020.
//

import SwiftUI

@main
struct RecreateSandwichesApp: App {
    @StateObject private var store = testData
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
