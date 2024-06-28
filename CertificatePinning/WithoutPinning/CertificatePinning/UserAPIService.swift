import NetworkClient

protocol ListAPIServiceProtocol {
    func getUsers() async throws -> [UserDTO]
}

final class ListAPIService {
    private let networkClient: NetworkClient
    init(
        networkClient: NetworkClient = MainNetworkClient()
    ) {
        self.networkClient = networkClient
    }
}

extension ListAPIService: ListAPIServiceProtocol {
    func getUsers() async throws -> [UserDTO] {
        let userRequest = UserRequest()
        let api = API.users
        let users = try await APIService().performRequest(
            api: api,
            request: userRequest,
            networkClient: networkClient
        )
        return users
    }
}
