//
//  BasicViewController.swift
//  AccessUIKit
//
//  Created by Steven Curtis on 26/04/2021.
//

import UIKit
import SwiftUI

struct CustomViewController: UIViewControllerRepresentable {
    var message: String
    func makeUIViewController(context: Context) -> UIViewController {
        BasicViewController(message: message)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class BasicViewController: UIViewController {
    lazy var label: UILabel = UILabel()
    var message: String
    
    override func viewDidLoad() {
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    init(message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        self.view.addSubview(label)
    }
    
    func setupComponents() {
        label.text = message
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
}
