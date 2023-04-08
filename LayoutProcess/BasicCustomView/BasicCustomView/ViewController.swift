//
//  ViewController.swift
//  BasicCustomView
//
//  Created by Steven Curtis on 16/01/2021.
//

import UIKit

class ViewController: UIViewController {

    lazy var containerView: BasicCustomView = {
        let view = BasicCustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        containerView.invalidateIntrinsicContentSize()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            containerView.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor
            )
        ])
    }
    
    func setupViews() {
        self.view.addSubview(containerView)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }


}

