//
//  EnvironmentPropertyWrapperApp.swift
//  EnvironmentPropertyWrapper
//
//  Created by Steven Curtis on 14/06/2023.
//

import SwiftUI

@main
struct MyApp: App {
    var settings = UserSettings()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(settings)
        }
    }
}
