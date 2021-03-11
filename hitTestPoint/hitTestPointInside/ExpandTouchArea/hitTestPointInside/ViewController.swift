//
//  ViewController.swift
//  hitTestPointInside
//
//  Created by Steven Curtis on 12/11/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



    @IBOutlet weak var specialView: SubclassedView!
    

    @IBAction func layoutOne(_ sender: UIButton) {
        specialView.center = self.view.center
    }
    
    
    @IBAction func layoutTwo(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        specialView.backgroundColor = .blue
        specialView.parentView = self.view
        specialView.tag = 1
        specialView.center = CGPoint(x: 0, y: 0)

    }
    


}

