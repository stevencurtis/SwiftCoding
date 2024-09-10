@testable import DynamicType
import XCTest

final class ContentViewModelTests: XCTestCase {
    func testFetchPeople() async {
        let expectation = XCTestExpectation()
        let mockService = MockService()
        let mockPerson = PersonDTO(height: "1", mass: "2", name: "3", birth_year: "4")
        mockService.people = PeopleDTO(results: [mockPerson])
        let sut = ContentViewModel(service: mockService)
        await sut.fetchPeople()
        
        withObservationTracking({ _ = sut.people }, onChange: {
            expectation.fulfill()
        })
        await fulfillment(of: [expectation])

        XCTAssertEqual(sut.people, [mockPerson.toDomain()])
    }
    
    func testLoadMoreContentIfNeeded() {
        let expectation = XCTestExpectation()
        let mockService = MockService()
        let initialPerson = PersonDTO(height: "height", mass: "mass", name: "name", birth_year: "birth_year")

        let mockPerson = PersonDTO(height: "1", mass: "2", name: "3", birth_year: "4")
        mockService.people = PeopleDTO(results: [initialPerson])
        
        let sut = ContentViewModel(service: mockService)
        sut.people = [mockPerson.toDomain()]
        sut.loadMoreContentIfNeeded(person: mockPerson.toDomain())
        
        withObservationTracking({ _ = sut.people }, onChange: {
            expectation.fulfill()
        })
        wait(for: [expectation])

        XCTAssertEqual(sut.people, [mockPerson.toDomain(), initialPerson.toDomain()])
    }
    
    func testIsLoadingInitialLoading() {
        let mockService = MockService()
        let sut = ContentViewModel(service: mockService)
        XCTAssertEqual(sut.isLoading, true)
    }
    
    func testIsLoadingBecomesFalse() async {
        let expectation = XCTestExpectation()
        
        let mockService = MockService()
        let sut = ContentViewModel(service: mockService)
        
        await sut.fetchPeople()
        
        withObservationTracking( { _ = sut.isLoading } , onChange: {
            expectation.fulfill()
        })
        
        await fulfillment(of: [expectation])
        
        XCTAssertEqual(sut.isLoading, false)
    }
}
