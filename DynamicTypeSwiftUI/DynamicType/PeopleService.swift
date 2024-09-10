import NetworkClient

protocol PeopleServiceProtocol {
    func getPeople(page: String) async throws -> PeopleDTO?
}

final class PeopleService: PeopleServiceProtocol {
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient = MainNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getPeople(page: String) async throws -> PeopleDTO? {
        let request = PeopleRequest()
        let people = try await networkClient.fetch(
            api: API.people(
                page: page
            ),
            request: request
        )
        return people
    }
}
