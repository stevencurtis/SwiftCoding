//  Created by Steven Curtis

import Foundation
import Combine

extension URLSession: URLSessionProtocol {
    public func dataTaskPub(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
