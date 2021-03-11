//
//  DelegationHTTPManager.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

protocol DelegationHTTPDelegate: class {
    func didDownloadBreaches(_ data: Data) // called when the manager has completed downloading all the breaches
}

class DelegationHTTPManager {
    static let shared: DelegationHTTPManager = DelegationHTTPManager()
    var delegate : DelegationHTTPDelegate? = nil
    
    public func get (urlString: String) {
        let url = URL(string: urlString)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                self.delegate!.didDownloadBreaches(data!)
            })
            task.resume()
        }
    }
}
