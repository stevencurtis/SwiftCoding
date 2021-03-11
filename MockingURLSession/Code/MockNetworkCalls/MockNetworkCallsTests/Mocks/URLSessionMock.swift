//
//  URLSessionMock.swift
//  NYTTests
//
//  Created by Steven Curtis on 08/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
@testable import MockNetworkCalls

// Failed Attempt 1
//class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
//    private let closure: () -> Void
//    init(closure: @escaping () -> Void) {
//        self.closure = closure
//    }
//    // override resume and call the closure
//
//    func resume() {
//        closure()
//    }
//}
//
//class URLSessionMock: URLSessionProtocol {
//    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
//    // data and error can be set to provide data or an error
//    var data: Data?
//    var error: Error?
//    func dataTask(
//        with url: URL,
//        completionHandler: @escaping CompletionHandler
//        ) -> URLSessionDataTask {
//        let data = self.data
//        let error = self.error
//        return URLSessionDataTaskMock {
//            completionHandler(data, nil, error)
//        } as! URLSessionDataTask
//    }
//}

// Second Attempt
class DataTaskMock: URLSessionDataTask {
    override func resume() { }
}

class URLSessionMock: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    // data and error can be set to provide data or an error
    var data: Data?
    var error: Error?
    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
        ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        defer { completionHandler(data, nil, error) }
        return DataTaskMock()
    }
}


