//
//  ViewController.swift
//  WhichThread
//
//  Created by Steven Curtis on 01/10/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Thread().threadName)
        DispatchQueue.global(qos: .background).async {
            print(Thread().threadName)
        }
    }
}
