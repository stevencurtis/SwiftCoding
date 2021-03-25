//
//  ViewController.swift
//  IntrinsicContentSizeBasic
//
//  Created by Steven Curtis on 16/01/2021.
//

import UIKit

class ViewController: UIViewController {
        
    lazy var simpleLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Hello, World!"
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    lazy var containerView: ContainerView = {
        let container = ContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        print ("view frame: \(view.frame)")
        print ("view intrinsicContentSize: \(view.intrinsicContentSize)")
        print ("simpleLabel frame: \(simpleLabel.frame)")
        print ("simpleLabel intrinsicContentSize: \(simpleLabel.intrinsicContentSize)")
        print ("containerView frame: \(containerView.frame)")
        print ("containerView intrinsicContentSize: \(containerView.intrinsicContentSize)")

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            simpleLabel.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            simpleLabel.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor
            ),
            containerView.topAnchor.constraint(
                equalTo: self.simpleLabel.bottomAnchor,
                constant: 20
            ),
            containerView.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor
            )
        ])
    }
    
    func setupViews() {
        self.view.addSubview(simpleLabel)
        self.view.addSubview(containerView)
    }
}
