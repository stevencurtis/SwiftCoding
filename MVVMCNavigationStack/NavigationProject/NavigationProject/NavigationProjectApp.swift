import SwiftUI

@main
struct NavigationProjectApp: App {
    @StateObject private var coordinator = AppCoordinator(
        screenFactory: DefaultScreenFactory()
    )

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}



















