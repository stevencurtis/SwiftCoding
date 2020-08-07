//
//  MockNetworkManager.swift
//  ParseJsonNoTypeTests
//
//  Created by Steven Curtis on 06/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import ParseJsonNoType


// the MockHTTPManager does not use the session within the response
class MockNetworkManager <T: URLSessionProtocol>: NetworkManagerProtocol {
    var outputData = emptyString.data(using: .utf8)
    var willSucceed = true
    let session: T

    required init(session: T) {
      self.session = session
    }
    
    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String : Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        if let dta = outputData {
            if willSucceed {
                completionBlock(.success(dta))
            } else {
                completionBlock(.failure(ErrorModel(errorDescription: "Error from Mock HTTPManager")))
            }
        }
    }
}
