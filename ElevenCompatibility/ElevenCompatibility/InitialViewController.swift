//
//  InitialViewController.swift
//  ElevenCompatibility
//
//  Created by Steven Curtis on 21/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    lazy var imageView = UIImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let initialView = UIView()
        initialView.backgroundColor = .systemGray
        self.view = initialView
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        setupImage()
        setupConstraints()
    }
    
    func setupImage() {
        imageView.image = UIImage(named: "GF")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

}
