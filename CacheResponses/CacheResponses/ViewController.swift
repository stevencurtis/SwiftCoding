//
//  ViewController.swift
//  CacheResponses
//
//  Created by Steven Curtis on 15/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var networkManager: AnyNetworkManager<URLSession>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
    }
    
    @IBAction func networkCallAction(_ sender: UIButton) {
        self.makeNetworkCall()
    }
    
    func makeNetworkCall() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        self.networkManager?.fetch(url: url, method: .get, completionBlock: { response in
            switch response {
            case .failure(let error):
                print (error)
            case .success(let data):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let jsonDict = jsonObject as? NSDictionary {
                        // print (jsonDict)
                    }
                    if let jsonArray = jsonObject as? NSArray {
                        // print (jsonArray)
                    }
                } catch {
                    // error handling
                }
            }
        }
        )
    }
    
}

