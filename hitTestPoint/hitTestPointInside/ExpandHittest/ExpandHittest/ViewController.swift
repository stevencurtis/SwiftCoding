//
//  ViewController.swift
//  ExpandHittest
//
//  Created by Steven Curtis on 25/11/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var specialView: SubclassedView!
    
    @IBAction func resetView(_ sender: UIButton) {
        specialView.center = self.view.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        specialView.parentView = self.view
        specialView.backgroundColor = .blue
        specialView.center = CGPoint(x: 0, y: 0)
        specialView.tag = 1

    }


}

