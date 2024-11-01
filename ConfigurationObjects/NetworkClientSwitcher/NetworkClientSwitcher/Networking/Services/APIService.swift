import Foundation
import NetworkClient

final class APIService {
    func performRequest<T>(
        api: API,
        method: HTTPMethod,
        request: T,
        networkClient: NetworkClient
    ) async throws -> T.ResponseDataType where T: APIRequest {
        do {
            guard let response = try await networkClient.fetch(
                api: api,
                method: method,
                request: request
            ) else {
                throw APIError.noData
            }
            return response
        }
    }
}
