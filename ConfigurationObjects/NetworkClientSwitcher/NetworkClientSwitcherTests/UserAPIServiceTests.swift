@testable import NetworkClientSwitcher
import NetworkClient
import XCTest

final class UserAPIServiceTests: XCTestCase {
    private var sut: UserAPIService!
    private var mockNetworkClient: MockNetworkClient!
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        sut = UserAPIService(networkClient: mockNetworkClient)
    }

    override func tearDown() {
        mockNetworkClient = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetUsersSuccess() async {
        // Given
        let mockComments = [UserDTO(id: 1, username: "name")]
        mockNetworkClient.fetchAsyncResult = mockComments
        // When
        let users = try? await sut.getUsers()
        // Then
        XCTAssertEqual(users?.count, mockComments.count)
        XCTAssertEqual(users?[0].id, mockComments[0].id)
        XCTAssertEqual(users?[0].username, mockComments[0].username)
    }
    
    func testGetUsersFailureNoData() async {
        // Given
        let expectedError = APIError.noData
        let mockError: APIResponse<APIError> = .failure(expectedError)
        mockNetworkClient.fetchAsyncResult = mockError
        do {
            // When
            let _  = try await sut.getUsers()
            // Then
            XCTFail("Expected to throw error, but did not throw")
        } catch {
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }

    func testGeUsersFailureParseResponse() async {
        // Given
        let expectedError = APIError.parseResponse(errorMessage: "Could not parse data")
        let mockError: APIResponse<APIError> = .failure(expectedError)
        mockNetworkClient.fetchAsyncResult = mockError
        do {
            // When
            let _  = try await sut.getUsers()
            // Then
            XCTFail("Expected to throw error, but did not throw")
        } catch {
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }

    func testGetUsersFailureNetwork() async {
        // Given
        let expectedError = APIError.network(errorMessage: "Network unavailable")
        let mockError: APIResponse<APIError> = .failure(expectedError)
        mockNetworkClient.fetchAsyncResult = mockError
        do {
            // When
            let _  = try await sut.getUsers()
            // Then
            XCTFail("Expected to throw error, but did not throw")
        } catch {
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }

    func testGetUsersFailureHTTPError() async {
        // Given
        let expectedError = APIError.httpError(.badRequest)
        let mockError: APIResponse<APIError> = .failure(expectedError)
        mockNetworkClient.fetchAsyncResult = mockError
        do {
            // When
            let _  = try await sut.getUsers()
            // Then
            XCTFail("Expected to throw error, but did not throw")
        } catch {
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }

    func testGetUsersFailureInvalidResponse() async {
        // Given
        let expectedError = APIError.invalidResponse(nil, nil)
        let mockError: APIResponse<APIError> = .failure(expectedError)
        mockNetworkClient.fetchAsyncResult = mockError
        do {
            // When
            let _  = try await sut.getUsers()
            // Then
            XCTFail("Expected to throw error, but did not throw")
        } catch {
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }
    
    func testGetUsersFailureUnknown() async {
        // Given
        let expectedError = APIError.unknown
        let mockError: APIResponse<APIError> = .failure(expectedError)
        mockNetworkClient.fetchAsyncResult = mockError
        do {
            // When
            let _  = try await sut.getUsers()
            // Then
            XCTFail("Expected to throw error, but did not throw")
        } catch {
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }
}
