//
//  HTTPManagerMock.swift
//  BasicHTTPManagerTests
//
//  Created by Steven Curtis on 03/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import OperationQueueDependentAPICalls

class HTTPManagerMock <T: URLSessionProtocol>: HTTPManagerProtocol {
    var data: Data? = "This Succeeded".data(using: .utf8)
    var giveError: Bool = false
    
    func setData(withData data: Data) {
        self.data = data
    }
    
    
    func get(url: URL, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        if !giveError {
        if let dta = data {
            completionBlock(.success(dta))
        }
        } else {
            let err = NSError(domain: "001", code: 403, userInfo: [:])
            completionBlock(.failure(err))
        }
    }
    
    let session: T

    required init(session: T) {
      self.session = session
    }

}
