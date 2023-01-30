//  Created by Steven Curtis

import Foundation
import Combine

public protocol URLSessionProtocol {
    associatedtype dataTaskProtocolType: URLSessionDataTaskProtocol
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
    
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher
    func dataTaskPub(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

