//
//  CacheManagerProtocol.swift
//  CacheResponses
//
//  Created by Steven Curtis on 15/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

protocol CacheManagerProtocol {
    func fetchDataFromCache(request: URLRequest, completion: ((Data?)-> ()))
    func storeDataToCache(request: URLRequest, data: Data)
    subscript(request: URLRequest) -> Data? { get set }
}
