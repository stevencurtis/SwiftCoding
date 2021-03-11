//
//  URLSessionProtocol.swift
//  MockNetworkCalls
//
//  Created by Steven Curtis on 01/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    associatedtype dta: URLSessionDataTaskProtocol
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dta
}
