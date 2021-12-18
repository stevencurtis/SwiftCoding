//
//  ViewController.swift
//  Pickers
//
//  Created by Steven Curtis on 03/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func programmaticAction(_ sender: UIButton) {
        let viewController = SBPickerProgrammaticViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
