//
//  ViewController.swift
//  MVVMDI
//
//  Created by Steven Curtis on 14/10/2020.
//

import UIKit
import NetworkLibrary

class ViewController: UIViewController {
    
    var viewModel: ViewModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = ViewModel(networkManager: NetworkManager<URLSession>())
    }
    
    init(viewModel: ViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getData() {
        viewModel?.getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
}
