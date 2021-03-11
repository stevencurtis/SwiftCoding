//
//  ViewController.swift
//  BasicHittestPoint
//
//  Created by Steven Curtis on 15/11/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var specialView: SubclassedView!
    
    @IBOutlet weak var specialSubView: SubclassedView!
    
    @IBAction func resetView(_ sender: UIButton) {
        specialView.center = self.view.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        specialView.parentView = self.view
        specialView.backgroundColor = .blue
        specialView.center = CGPoint(x: 0, y: 0)
        specialView.tag = 1
        specialSubView.backgroundColor = .red
        specialSubView.parentView = specialView
        specialSubView.tag = 2
    }
    
    
}


