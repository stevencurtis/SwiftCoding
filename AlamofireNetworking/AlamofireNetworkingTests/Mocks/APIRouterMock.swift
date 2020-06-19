//
//  APIRouterMock.swift
//  AlamofireNetworkingTests
//
//  Created by Steven Curtis on 18/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import Alamofire
@testable import AlamofireNetworking

enum APIRouterMock {
    case get
}

extension APIRouterMock: APIRouter {
    var actionParameters: [String : Any] {
        [:]
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    var authHeader: HTTPHeaders? {
        return [:]
    }
    
    // HTTPMethod is declared by Alamofire
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .get:
            return "get"
        }
    }
        
    var baseURL: String {
        return "https://mockedsite.com/"
    }
}
