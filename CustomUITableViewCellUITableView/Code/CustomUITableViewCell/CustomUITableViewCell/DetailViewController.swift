//
//  DetailViewController.swift
//  CustomUITableViewCell
//
//  Created by Steven Curtis on 06/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var dataLabel: UILabel!
    var dataString: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = dataString {
            dataLabel.text = text
        }
    }
}

