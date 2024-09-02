import SwiftUI

@main
struct TestObservationOldWayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel(service: PostService()))
        }
    }
}
