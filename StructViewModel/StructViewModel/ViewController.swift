//
//  ViewController.swift
//  StructViewModel
//
//  Created by Steven Curtis on 19/10/2020.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: ViewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.testFunction()
    }
}

