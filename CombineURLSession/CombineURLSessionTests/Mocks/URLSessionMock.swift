//
//  MockURLSession.swift
//  BasicHTTPManagerTests
//
//  Created by Steven Curtis on 07/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import Combine
@testable import CombineURLSession

class URLSessionMock: URLSessionProtocol {
    var jsonName = "RegisterSuccess.json"
    func response(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let file = Bundle(for: type(of: self)).path(forResource: jsonName, ofType: nil)!

        let url = URL(fileURLWithPath: file)
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }

    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    // data and error can be set to provide data or an error
    var data: Data?
    var error: Error?
}
