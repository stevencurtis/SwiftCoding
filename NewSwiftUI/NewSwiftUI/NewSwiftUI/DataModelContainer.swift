//
//  DataModelContainer.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import Foundation
import SwiftUI
import SwiftData

//@main
private struct WhatsNew2023: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Dog.self)
    }
    
    struct ContentView: View {
        var body: some View {
            Color.clear
        }
    }

    @Model
    class Dog {
        var name = ""
        var age = 1
    }
}
