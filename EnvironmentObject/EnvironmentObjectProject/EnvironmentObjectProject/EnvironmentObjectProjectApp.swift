import SwiftUI

@main
struct EnvironmentObjectProjectApp: App {
    @StateObject private var session = UserSession()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
        }
    }
}
