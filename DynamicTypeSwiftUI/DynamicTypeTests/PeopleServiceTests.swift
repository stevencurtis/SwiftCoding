@testable import DynamicType
import NetworkClient
import NetworkClientTestUtilities
import XCTest

final class PeopleServiceTests: XCTestCase {
    func testPeopleReturnsPeople() async {
        let mockNetworkClient = MockNetworkClient()
        let mockPeople = PeopleDTO(results: [PersonDTO(height: "1", mass: "2", name: "3", birth_year: "4")])
        mockNetworkClient.fetchResult = MockSuccess(result: mockPeople)
        let sut = PeopleService(networkClient: mockNetworkClient)
        
        let people = try? await sut.getPeople(page: "1")
        
        XCTAssertEqual(people?.results, mockPeople.results)
    }
    
    func testPeopleError() async {
        let mockNetworkClient = MockNetworkClient()
        
        let mockError = APIError.unknown
        mockNetworkClient.fetchResult = MockFailure(error: mockError)
        
        let sut = PeopleService(networkClient: mockNetworkClient)

        do {
            _ = try await sut.getPeople(page: "1")
            XCTFail()
        } catch {
            XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
        }
    }
}

extension PersonDTO: Equatable {
    static public func == (lhs: PersonDTO, rhs: PersonDTO) -> Bool {
        lhs.name == rhs.name && lhs.birth_year == rhs.birth_year
    }
}
