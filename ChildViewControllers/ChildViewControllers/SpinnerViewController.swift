//
//  LoadingViewController.swift
//  ChildViewControllers
//
//  Created by Steven Curtis on 30/03/2021.
//

import UIKit

class SpinnerViewController: UIViewController {
    let spinner = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    func setupHierarchy() {
        view.addSubview(spinner)
    }
    
    func setupComponents() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        self.view.backgroundColor = .systemGray
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
