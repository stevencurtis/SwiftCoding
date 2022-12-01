//
//  SecondViewController.swift
//  StructViewModel
//
//  Created by Steven Curtis on 19/10/2020.
//

import UIKit

class SecondViewController: UIViewController {
    var viewModel: SecondViewModel = SecondViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.testFunction()
    }
}
