//
//  ViewController.swift
//  CaseLetSingle
//
//  Created by Steven Curtis on 02/07/2021.
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
        
        viewModel.closure = { result in
            switch result {
            case let .success(users):
                print(users.data.map{ "\($0.firstName) \($0.lastName): \($0.email)" }.joined(separator: "\n"))
            case .failure(_):
                break
            }
        }
        
        viewModel.closure = { result in
            if case let .success(users) = result {
                print(users.data.map{ "\($0.firstName) \($0.lastName): \($0.email)" }.joined(separator: "\n"))
            }
        }
        
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}

        viewModel.retrieveUsers(from: url)
    }
}
