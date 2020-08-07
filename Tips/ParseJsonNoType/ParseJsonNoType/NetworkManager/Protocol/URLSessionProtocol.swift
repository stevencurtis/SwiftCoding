//
//  URLSessionProtocol.swift
//  ParseJsonNoType
//
//  Created by Steven Curtis on 06/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    associatedtype dataTaskProtocolType: URLSessionDataTaskProtocol
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
}
