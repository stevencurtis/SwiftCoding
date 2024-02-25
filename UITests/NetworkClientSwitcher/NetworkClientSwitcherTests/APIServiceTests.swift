@testable import NetworkClientSwitcher
import NetworkClient
import XCTest

final class APIServiceTests: XCTestCase {
    private var sut: APIService!
    private var mockNetworkClient: MockNetworkClient!
    override func setUp() {
        super.setUp()
        sut = APIService()
    }
    
    func testPerformRequestSuccess() async {
        // Given
        let mockNetworkClient = MockNetworkClient()
        let userRequest = UserRequest()
        let mockUsers = [UserDTO(id: 1, username: "name")]
        
        // When
        mockNetworkClient.fetchAsyncResult = mockUsers

        do {
            let response = try await sut.performRequest(
                api: .users,
                method: .get(),
                request: userRequest,
                networkClient: mockNetworkClient
            )
            // Then
            XCTAssertNotNil(response)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
