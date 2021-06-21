//
//  ViewController.swift
//  SubclassOrExtend
//
//  Created by Steven Curtis on 03/12/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var subclassedButton: SubclassedUIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        subclassedButton.addTarget(self, action: #selector(subclassedPressed), for: .touchUpInside)
    }
    
    @objc func subclassedPressed() {
        print ("subclassed button pressed")
    }


}

