//
//  ViewController.swift
//  ProgrammaticScrollView
//
//  Created by Steven Curtis on 25/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let container = UIView()
        container.backgroundColor = .blue
        container.translatesAutoresizingMaskIntoConstraints = false

        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = .red

        container.addSubview(redView)
        redView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        redView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        
        let greenView = UIView()
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.backgroundColor = .green
        container.addSubview(greenView)

        greenView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        greenView.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        greenView.topAnchor.constraint(equalTo: redView.bottomAnchor).isActive = true

        scrollView.addSubview(container)

        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

//        let heightConstraint = container.heightAnchor.constraint(equalToConstant: 1700)
//        heightConstraint.priority = UILayoutPriority(250)
//        heightConstraint.isActive = true
        container.bottomAnchor.constraint(equalTo: greenView.bottomAnchor).isActive = true

        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}
