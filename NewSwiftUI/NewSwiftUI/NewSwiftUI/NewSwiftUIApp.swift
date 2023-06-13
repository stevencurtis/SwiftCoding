//
//  NewSwiftUIApp.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftData
import SwiftUI

@main
private struct NewSwiftUIApp: App {
    @State private var currentUser: User?
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(currentUser)
        }
    }
    struct ContentView: View {
        var body: some View {
            Color.clear
        }
    }

    struct ProfileView: View {
        @Environment(User.self) private var currentUser: User?

        var body: some View {
            if let currentUser {
                UserDetails(user: currentUser)
            } else {
                Button("Log In") { }
            }
        }
    }

    struct UserDetails: View {
        var user: User

        var body: some View {
            Text("Hello, \(user.name)")
        }
    }

    @Observable final class User: Identifiable {
        var id = UUID()
        var name = ""
    }
}
