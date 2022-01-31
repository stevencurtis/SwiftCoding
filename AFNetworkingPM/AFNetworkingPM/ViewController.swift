//
//  ViewController.swift
//  AFNetworkingPM
//
//  Created by Steven Curtis on 17/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://httpbin.org/get").response { response in
            print(response)
        }
    }
}

