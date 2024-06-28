final class ViewModel {
    private let userInteractor: UserInteractorProtocol
    init(
        userInteractor: UserInteractorProtocol = UserInteractor()
    ) {
        self.userInteractor = userInteractor
    }
    func getUsers() {
        Task {
            let users = try await userInteractor.getList()
            print(users)
        }
    }
}
