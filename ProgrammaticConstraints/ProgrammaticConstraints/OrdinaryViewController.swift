//
//  OrdinaryViewController.swift
//  ProgrammaticConstraints
//
//  Created by Steven Curtis on 13/11/2020.
//

import UIKit

class OrdinaryViewController: UIViewController {
    var label: UILabel?
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view

        label = UILabel()
        label?.text = "This is a great label!"
        label?.textAlignment = .center
        label?.translatesAutoresizingMaskIntoConstraints = false
        
        guard let label = label else {return}
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
