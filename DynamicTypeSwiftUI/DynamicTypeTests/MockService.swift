@testable import DynamicType

final class MockService: PeopleServiceProtocol {
    var people: PeopleDTO?
    func getPeople(page: String) async throws -> PeopleDTO? {
        people
    }
}
