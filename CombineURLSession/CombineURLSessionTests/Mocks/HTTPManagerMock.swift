//
//  HTTPManagerMock.swift
//  BasicHTTPManagerTests
//
//  Created by Steven Curtis on 03/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import Combine
@testable import CombineURLSession

class HTTPManagerMock <T: URLSessionProtocol>: HTTPManagerProtocol {
    let session: T

    required init(session: T) {
      self.session = session
    }
    
    func post<T>(url: URL, headers: [String : String], data: Data) -> AnyPublisher<T, Error> where T: Decodable {
        
        var request = URLRequest(
            url: URL(string: "www.fakeweb.com")!,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 2.0)
        
        request.httpMethod = "Post"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        // let session = URLSessionMock()
        return session.response(for: request)
            .map { $0.data }
            .decode(type: T.self,
                    decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
