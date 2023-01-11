//
//  ViewController.swift
//  LaunchTime
//
//  Created by Steven Curtis on 03/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
    
func measureThis() {
    var ar = [String]()
    for i in 0...1000000 {
        ar.append("New elem \(i)")
    }
}
