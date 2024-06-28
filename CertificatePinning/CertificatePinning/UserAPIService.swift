import Foundation
import NetworkClient

protocol ListAPIServiceProtocol {
    func getUsers() async throws -> [UserDTO]
}

final class ListAPIService {
    private let networkClient: NetworkClient
    convenience init() {
        let pinningDelegate = PinningDelegate()
        let session = URLSession(configuration: .default, delegate: pinningDelegate, delegateQueue: nil)
        let networkClient = MainNetworkClient(urlSession: session)
        self.init(networkClient: networkClient)
    }
    
    init(networkClient: NetworkClient) {
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
