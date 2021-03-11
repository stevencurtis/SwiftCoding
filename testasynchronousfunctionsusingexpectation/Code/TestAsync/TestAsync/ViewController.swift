//
//  ViewController.swift
//  TestAsync
//
//  Created by Steven Curtis on 31/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        messageAfterDelay(message: "message", time: 2.0, completion: { message in
            print (message)
        })
    }

}
