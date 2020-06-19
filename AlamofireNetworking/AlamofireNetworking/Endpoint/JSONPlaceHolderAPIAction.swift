//
//  JSONPlaceHolderAPIAction.swift
//  AlamofireNetworking
//
//  Created by Steven Curtis on 18/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import Alamofire

enum JSONPlaceHolderAPIAction {
    case getToDo(id: Int)
}

extension JSONPlaceHolderAPIAction: APIRouter {
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
        case .getToDo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getToDo(let id):
            return "todos/\(id)"
        }
    }
        
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
}
