//
//  URLSessionProtocol.swift
//  BasicHTTPManager
//
//  Created by Steven Curtis on 07/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

// Use an associatedtype to make the protocol generic
protocol URLSessionProtocol {
    associatedtype dataTaskProtocolType: URLSessionDataTaskProtocol
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
}
