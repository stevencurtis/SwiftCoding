//
//  InformationViewController.swift
//  DIIOS12
//
//  Created by Steven Curtis on 25/09/2020.
//

import UIKit

class InformationViewController: UIViewController {
    var item: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        print (item!)
    }
}
