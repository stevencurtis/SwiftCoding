//
//  ViewController.swift
//  UIViewSubclassXIB
//
//  Created by Steven Curtis on 02/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let subclassedView = SubclassedView(frame: .zero)
        self.view.addSubview(subclassedView)
        
        subclassedView.translatesAutoresizingMaskIntoConstraints = false
        subclassedView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        subclassedView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        subclassedView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        subclassedView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true 
    }


}

