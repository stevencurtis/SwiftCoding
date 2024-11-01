import NetworkClient
import SwiftUI

struct UserListView: View {
    @ObservedObject private var viewModel = UserListViewModel()
    
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List(viewModel.users, id: \.id) { user in
                 Text(user.username)
            }
            .onAppear {
                Task {
                    await viewModel.loadUsers()
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .alert(
                "Error",
                isPresented: Binding<Bool>.constant(
                    viewModel.errorMessage != nil
                ),
                presenting: viewModel.errorMessage
            ) { _ in
                Button("OK", role: .cancel) { }
            } message: { detail in
                Text(detail)
            }
        }
    }
}
typealias UserRequest = BasicRequest<[UserDTO]>

#Preview {
    UserListView(viewModel: UserListViewModel())
}
