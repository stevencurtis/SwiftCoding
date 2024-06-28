protocol UserInteractorProtocol {
    func getList() async throws -> [User]
}

final class UserInteractor {
    private let listRepository: UserRepositoryProtocol

    init(
        userRepository: UserRepositoryProtocol = UserRepository()
    ) {
        self.listRepository = userRepository
    }
}

extension UserInteractor: UserInteractorProtocol {
    func getList() async throws -> [User] {
        try await listRepository.getUsers()
    }
}
