//
//  NetworkManagerProtocol.swift
//  ParseJsonNoType
//
//  Created by Steven Curtis on 06/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }

    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String: Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void)
}
