//
//  TightlyCoupledHTTPManager.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class TightlyCoupledHTTPManager {
    var data = Data()
    public func get(urlString: String) {
        let url = URL(string: urlString)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                self.data = data!
                print (data!)
            })
            task.resume()
        }
    }    
}
