//
//  ViewController.swift
//  ProtocolDelegateMemoryLeak
//
//  Created by Steven Curtis on 22/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func moveVCAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showVC", sender: sender)
    }

}

