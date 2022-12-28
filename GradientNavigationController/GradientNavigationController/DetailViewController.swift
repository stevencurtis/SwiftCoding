//
//  DetailViewController.swift
//  GradientNavigationController
//
//  Created by Steven Curtis on 17/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var data: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue
        print ("data \(data)")
    }

}
