//
//  SimpleHTTPManager.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class HTTPManager {
    static let shared: HTTPManager = HTTPManager()
    public func get (urlString: String, completionBlock: @escaping ((Data?) -> Void)) {
        let url = URL(string: urlString)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                completionBlock(data)
            })
            task.resume()
        }
    }
}
