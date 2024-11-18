import SwiftUI

struct UserView: View {
    let viewModel: UserViewModel

    var body: some View {
        Text("User Profile: \(viewModel.user.name)")
    }
}
