//
//  ViewController.swift
//  ReachabilityImplementation
//
//  Created by Steven Curtis on 04/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var reachabilityLabel: UILabel!
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupReachability(closure: {
            self.reachabilityLabel.text = "Reachable \($0)"
        })
    }
}
