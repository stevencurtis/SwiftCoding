import SwiftUI

@main
struct CheckboxComponentApp: App {
    var body: some Scene {
        WindowGroup {
            TermsView(viewModel: TermsViewModel())
        }
    }
}
