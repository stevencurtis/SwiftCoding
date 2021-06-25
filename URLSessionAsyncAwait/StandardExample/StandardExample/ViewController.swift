//
//  ViewController.swift
//  StandardExample
//
//  Created by Steven Curtis on 22/06/2021.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: ViewModel
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.closure = {
            print($0)
        }
        
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}

        viewModel.retrieveUsers(from: url)
    }
}

