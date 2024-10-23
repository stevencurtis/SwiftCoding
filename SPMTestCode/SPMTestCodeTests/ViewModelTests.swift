@testable import SPMTestCode
import NetworkClient
import NetworkClientTestUtilities
import XCTest

final class ViewModelTests: XCTestCase {
    func testViewModel() {
        let mockResult = [TodoDTO(
            userId: 1,
            id: 2,
            title: "title",
            completed: true
        )]
        let mockNetworkClient = MockNetworkClient()
        mockNetworkClient.fetchResult = MockSuccess(
            result: mockResult
        )

        let viewModel = ViewModel(networkClient: mockNetworkClient)
        viewModel.fetchToDos()
        
        XCTAssertTrue(mockNetworkClient.fetchResultCalled)
    }
}
