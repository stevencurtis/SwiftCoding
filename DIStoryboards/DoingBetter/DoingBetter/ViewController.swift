//
//  ViewController.swift
//  DoingBetter
//
//  Created by Steven Curtis on 30/03/2021.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: ViewModelProtocol

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder, viewModel: ViewModelProtocol) {
      self.viewModel = viewModel
      super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
      fatalError("A view model is required")
    }


}

