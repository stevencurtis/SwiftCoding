//
//  ViewController.swift
//  DependencyInversion
//
//  Created by Steven Curtis on 22/09/2020.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ViewModel(networkManager: NetworkManager(session: URLSession.shared))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetch()
    }
}
