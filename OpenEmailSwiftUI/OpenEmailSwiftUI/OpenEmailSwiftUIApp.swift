//
//  OpenEmailSwiftUIApp.swift
//  OpenEmailSwiftUI
//
//  Created by Steven Curtis on 07/11/2023.
//

import SwiftUI

@main
struct OpenEmailSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = ViewModel()
            ContentView(viewModel: viewModel)
        }
    }
}
