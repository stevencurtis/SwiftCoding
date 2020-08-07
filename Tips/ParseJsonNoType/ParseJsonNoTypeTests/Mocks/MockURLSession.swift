//
//  MockURLSession.swift
//  ParseJsonNoTypeTests
//
//  Created by Steven Curtis on 06/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import ParseJsonNoType

class MockURLSession: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    // data and error can be set to provide data or an error
    var data: Data?
    var error: Error?

    func dataTask(with request: URLRequest,
                  completionHandler:
        @escaping (Data?, URLResponse?, Error?) -> Void) ->
        MockURLSessionDataTask {
            let data = self.data
            let error = self.error
            let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!

            return MockURLSessionDataTask {
                completionHandler(data, response, error)
            }
    }

    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
        ) -> MockURLSessionDataTask {
        let data = self.data
        let error = self.error
        return MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
    }
}
