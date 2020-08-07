//
//  ViewController.swift
//  ParseJsonNoType
//
//  Created by Steven Curtis on 06/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkManager(session: URLSession.shared)
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/8")!
        
        networkManager.fetch(url: url, method: .get, headers: [:], token: nil, data: nil, completionBlock: { result in
            
            switch result {
            case .success(let data):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let jsonDict = jsonObject as? NSDictionary {
                        print (jsonDict)
                    }
                    if let jsonArray = jsonObject as? NSArray {
                        print (jsonArray)
                    }
                } catch {
                    // error handling
                }
            case .failure(let error):
                print (error)
            }
        })
    }
}
