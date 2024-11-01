import SwiftUI

@main
struct NetworkClientSwitcherApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: UserListViewModel())
        }
    }
}
