//
//  ViewController.swift
//  ProgrammaticScrollViewStackView
//
//  Created by Steven Curtis on 11/12/2022.
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

        let container =  UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 10
        
        let redView = UIView()
        redView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        redView.backgroundColor = .red
        
        container.addArrangedSubview(redView)
        
        let greenView = UIView()
        greenView.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        greenView.backgroundColor = .green
        
        container.addArrangedSubview(greenView)
        
        scrollView.addSubview(container)

        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}
