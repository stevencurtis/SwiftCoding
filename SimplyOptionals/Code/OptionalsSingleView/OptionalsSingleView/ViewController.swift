//
//  ViewController.swift
//  OptionalsSingleView
//
//  Created by Steven Curtis on 27/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = "test"
    }
}

