//
//  LowCohesionSwiftUIApp.swift
//  LowCohesionSwiftUI
//
//  Created by Steven Curtis on 13/03/2023.
//

import SwiftUI

@main
struct LowCohesionSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(user: .init(name: "username", email: "useremail"))
        }
    }
}
