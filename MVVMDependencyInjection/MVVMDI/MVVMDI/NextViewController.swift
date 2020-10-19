//
//  NextViewController.swift
//  MVVMDI
//
//  Created by Steven Curtis on 15/10/2020.
//

import UIKit
import NetworkLibrary

class NextViewController: UIViewController {
    var viewModel: NextViewModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = NextViewModel(networkManager: NetworkManager<URLSession>())
    }
    
    init(viewModel: NextViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

}
