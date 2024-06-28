protocol UserRepositoryProtocol {
    func getUsers() async throws -> [User]
}

final class UserRepository {
    private let apiService: ListAPIServiceProtocol
    init(
        apiService: ListAPIServiceProtocol = ListAPIService()
    ) {
        self.apiService = apiService
    }
}

extension UserRepository: UserRepositoryProtocol {
    func getUsers() async throws -> [User] {
        let dataModels = try await apiService.getUsers()
        let domainModels = dataModels.map { User(username: $0.username) }
        return domainModels
    }
}
