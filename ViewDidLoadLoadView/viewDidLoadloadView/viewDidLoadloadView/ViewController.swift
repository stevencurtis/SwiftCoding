//
//  ViewController.swift
//  viewDidLoadloadView
//
//  Created by Steven Curtis on 29/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var programmaticButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func programmaticButtonAction(_ sender: UIButton) {
        let newVC = ProgrammaticViewController()
        self.navigationController!.pushViewController(newVC, animated: true)
    }
    

}

