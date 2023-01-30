//  Created by Steven Curtis


import Foundation
@testable import DependencyInversion

// the MockHTTPManager does not use the session within the response
public class MockNetworkManager <T: URLSessionProtocol>: NetworkManagerProtocol {
    public func cancel() { }
    
    var outputData = emptyString.data(using: .utf8)
    var willSucceed = true
    public let session: T

    required init(session: T) {
      self.session = session
    }
    
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String : Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        if let dta = outputData {
            if willSucceed {
                completionBlock(.success(dta))
            } else {
                completionBlock(.failure(ErrorModel(errorDescription: "Error from Mock HTTPManager")))
            }
        }
    }
}

