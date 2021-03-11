//
//  ViewController.swift
//  hittest
//
//  Created by Steven Curtis on 26/11/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        subclassedView.parentView = self.view
        subclassedView.backgroundColor = .blue
        subclassedView.center = CGPoint(x: 0, y: 0)
        subclassedView.tag = 1
    }

    @IBAction func resetView(_ sender: UIButton) {
        subclassedView.center = self.view.center
    }
    
    @IBOutlet weak var subclassedView: SubclassedView!
}

