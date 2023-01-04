//
//  AnyNetworkManager.swift
//  hiring-mobile-test
//
//  Created by Steven Curtis on 26/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class AnyNetworkManager<U: URLSessionProtocol>: NetworkManagerProtocol {
    let session: U
    let closure: (URL, @escaping (Result<Data, Error>) -> Void) -> Void

    func get(url: URL, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        closure(url, completionBlock)
    }

    init<T: NetworkManagerProtocol>(manager: T) {
        closure = manager.get
        session = manager.session as! U
    }
}
