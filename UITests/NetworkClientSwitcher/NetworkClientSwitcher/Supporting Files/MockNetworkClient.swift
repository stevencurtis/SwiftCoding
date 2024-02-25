#if DEBUG
import Foundation
import NetworkClient

final class MockNetworkClient: NetworkClient {
    var fetchAsyncResult: Any?
    var fetchCompletionResult: APIResponse<Any?>?
    private(set) var fetchAsyncCalled = false
    private(set) var fetchCompletionCalled = false
    
    func fetch<T>(
        api: URLGenerator,
        method: HTTPMethod,
        request: T
    ) async throws -> T.ResponseDataType? where T: APIRequest {
        fetchAsyncCalled = true
        if let error = try (fetchAsyncResult as? APIResponse<APIError>)?.result.get() {
            throw error
        }
        if let result = fetchAsyncResult as? T.ResponseDataType {
            return result
        }
        switch api.url {
        case API.users.url:
            return mockUsers() as? T.ResponseDataType
        default:
            return nil
        }
    }
    
    func fetch<T>(
        api: URLGenerator,
        method: HTTPMethod,
        request: T,
        completionQueue: DispatchQueue,
        completionHandler: @escaping (APIResponse<T.ResponseDataType?>) -> Void
    ) -> URLSessionTask? where T: APIRequest {
        fetchCompletionCalled = true
        if let result = fetchCompletionResult as? APIResponse<T.ResponseDataType?> {
            completionQueue.async {
                completionHandler(result)
            }
        }
        return nil
    }
    
    private func mockUsers() -> [UserDTO] {
        [
            UserDTO(id: 1, username: "Username One"),
            UserDTO(id: 2, username: "Username Two")
        ]
    }
}
#endif
