//
//  ViewController.swift
//  Namespacing
//
//  Created by Steven Curtis on 19/02/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
     struct Int {
        var int: Swift.Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // let myNum: Swift.Int = 4
        let myNum: Int = Int(int: 4)

        print ("\(myNum)")
    }


}

