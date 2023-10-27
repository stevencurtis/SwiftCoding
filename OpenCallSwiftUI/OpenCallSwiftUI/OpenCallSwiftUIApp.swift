//
//  OpenCallSwiftUIApp.swift
//  OpenCallSwiftUI
//
//  Created by Steven Curtis on 18/10/2023.
//

import SwiftUI

@main
struct OpenCallSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = ViewModel()
            ContentView(viewModel: viewModel)
        }
    }
}
