//
//  AnyNetworkManager.swift
//  ParseJsonNoType
//
//  Created by Steven Curtis on 06/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class AnyNetworkManager<U: URLSessionProtocol>: NetworkManagerProtocol {
    let session: U
    let fetchClosure: (URL, HTTPMethod, [String : String], String?, [String : Any]?, @escaping (Result<Data, Error>) -> Void) -> ()
    
    init<T: NetworkManagerProtocol>(manager: T) {
        fetchClosure = manager.fetch
        session = manager.session as! U
    }
    
    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String : Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetchClosure(url, method, headers, token, data, completionBlock)
    }
}
