import Foundation
import NetworkClient

protocol ListAPIServiceProtocol {
    func getUsers() async throws -> [UserDTO]
}

final class UserAPIService {
    private let networkClient: NetworkClient
    init(
        networkClient: NetworkClient = APIFactory.makeDefault()
    ) {
        self.networkClient = networkClient
    }
}

extension UserAPIService: ListAPIServiceProtocol {
    func getUsers() async throws -> [UserDTO] {
        let userRequest = UserRequest()
        let api = API.users
        let users = try await APIService().performRequest(
            api: api,
            method: .get(),
            request: userRequest,
            networkClient: networkClient
        )
        return users
    }
}
