//
//  URLSessionProtocol.swift
//  ExtensionViewController
//
//  Created by Steven Curtis on 27/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
