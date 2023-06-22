//
//  MeetSwiftDataApp.swift
//  MeetSwiftData
//
//  Created by Steven Curtis on 22/06/2023.
//

import SwiftUI
import SwiftData

@main
struct MeetSwiftDataApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
