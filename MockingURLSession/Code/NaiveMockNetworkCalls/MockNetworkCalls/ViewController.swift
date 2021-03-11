//
//  ViewController.swift
//  MockNetworkCalls
//
//  Created by Steven Curtis on 31/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData(URLSession.shared, completionBlock: {response in
            print (response)
        })
    }

    func downloadData(_ session: URLSession, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: "http://ipv4.download.thinkbroadband.com/10MB.zip") {
            let task = session.dataTask(with: url, completionHandler: {data , urlresponse, error in
                if let data = data {
                    completionBlock(.success(data))
                }
            }
            )
            task.resume()
        }
    }
    
}

