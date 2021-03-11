//
//  ClosureHTTPManager.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
import Alamofire

class HTTPManager {
    static let shared: HTTPManager = HTTPManager()

    enum HTTPError: Error {
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
        case noData
    }
    
    let evaluators = [
        "haveibeenpwned.com":
            PinnedCertificatesTrustEvaluator(certificates: [
                Certificates.pwned
                ])
    ]
    
    var session: Session
    private init() {
        session = Session(
            serverTrustManager: ServerTrustManager(evaluators: evaluators)
        )
    }
    
    public func get(urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {

        session = Session(
            serverTrustManager: ServerTrustManager(evaluators: evaluators)
        )
        
        session.request(urlString).responseJSON{ response in
            if let data = response.data {
                completionBlock(.success(data))
            } else {
                completionBlock(.failure(HTTPError.noData))
            }
        }
        
        // Simple AF.request
        //  AF.request(urlString).responseJSON{ response in
        //      completionBlock(.success(response.data!))
        //  }

    }

}
