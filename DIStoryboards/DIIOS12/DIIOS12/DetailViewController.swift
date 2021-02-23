//
//  DetailViewController.swift
//  DIIOS12
//
//  Created by Steven Curtis on 25/09/2020.
//

import UIKit

class DetailViewController: UIViewController {
    var item: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        // Will crash if the item is not set
        print (item!)
    }
}
