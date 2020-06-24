//
//  HTTPManagerMock.swift
//  BasicHTTPManagerTests
//
//  Created by Steven Curtis on 03/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import HorizontalCollection

//class HTTPManagerMock <T: URLSessionProtocol>: HTTPManagerProtocol {
  
class HTTPManagerMock: HTTPManagerProtocol {

    func get(url: URL, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        if let dta = "This Succeeded".data(using: .utf8) {
            completionBlock(.success(dta))
        }
    }
    
//    let session: T
//
//    required init(session: aType) {
//      self.session = session
//    }

}
