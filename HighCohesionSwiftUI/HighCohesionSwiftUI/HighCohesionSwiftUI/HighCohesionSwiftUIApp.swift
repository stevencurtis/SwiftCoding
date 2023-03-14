//
//  HighCohesionSwiftUIApp.swift
//  HighCohesionSwiftUI
//
//  Created by Steven Curtis on 13/03/2023.
//

import SwiftUI

@main
struct HighCohesionSwiftUIApp: App {
    let userStore = UserStore()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(userStore: userStore))
        }
    }
}
