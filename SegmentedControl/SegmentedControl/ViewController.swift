//
//  ViewController.swift
//  SegmentedControl
//
//  Created by Steven Curtis on 11/11/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    
}

