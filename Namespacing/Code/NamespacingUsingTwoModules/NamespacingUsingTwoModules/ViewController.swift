//
//  ViewController.swift
//  NamespacingUsingTwoModules
//
//  Created by Steven Curtis on 23/02/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import IntFrameworkOne
import IntFrameworkTwo

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let myNum: IntFrameworkTwo.Int = Int(int: 4)
        print (myNum)
    }


}

