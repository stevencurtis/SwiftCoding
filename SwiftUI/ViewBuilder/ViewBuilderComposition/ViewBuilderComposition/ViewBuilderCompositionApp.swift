//
//  ViewBuilderCompositionApp.swift
//  ViewBuilderComposition
//
//  Created by Steven Curtis on 17/08/2023.
//

import SwiftUI

@main
struct ViewBuilderCompositionApp: App {
    let user = User(name: "Steve", bio: "iOS Developer")
    var body: some Scene {
        WindowGroup {
            ContentView(user: user)
        }
    }
}
