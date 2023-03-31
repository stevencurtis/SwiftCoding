//
//  ViewController.swift
//  UITableViewBackground
//
//  Created by Steven Curtis on 20/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = SecondViewModel()
        let secondViewController = SecondViewController(viewModel: viewModel)
        addChild(secondViewController)
        secondViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondViewController.view)
        
        NSLayoutConstraint.activate([
            secondViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            secondViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        secondViewController.didMove(toParent: self)
    }
}
