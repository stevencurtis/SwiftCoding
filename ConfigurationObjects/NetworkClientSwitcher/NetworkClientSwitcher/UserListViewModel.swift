import SwiftUI

@MainActor
final class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService: ListAPIServiceProtocol

    init(apiService: ListAPIServiceProtocol = UserAPIService()) {
        self.apiService = apiService
    }

    func loadUsers() async {
        defer {
            isLoading = false
        }
        isLoading = true
        do {
            let fetchedUsers = try await apiService.getUsers()
            users = fetchedUsers.map(User.init)
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load users: \(error.localizedDescription)"
        }
    }
}
