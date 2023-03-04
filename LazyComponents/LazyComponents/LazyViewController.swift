//
//  LazyViewController.swift
//  ProgrammaticConstraints
//
//  Created by Steven Curtis on 13/11/2020.
//

import UIKit

class LazyViewController: UIViewController {
    var label: UILabel = {
        let lab = UILabel()
        lab.text = "This is a great label!"
        lab.textAlignment = .center
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
