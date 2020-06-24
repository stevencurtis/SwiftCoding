//
//  MockURLSession.swift
//  BasicHTTPManagerTests
//
//  Created by Steven Curtis on 07/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import HorizontalCollection

class URLSessionMock: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    // data and error can be set to provide data or an error
    var data: Data?
    var error: Error?
    
    func dataTask(with request: URLRequest,
                  completionHandler:
        @escaping (Data?, URLResponse?, Error?) -> Void) ->
        URLSessionDataTaskMock {
            let data = self.data
            let error = self.error
            return URLSessionDataTaskMock{
                completionHandler(data, nil, error)
            }
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
        ) -> URLSessionDataTaskMock {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock{
            completionHandler(data, nil, error)
        }
    }
}
