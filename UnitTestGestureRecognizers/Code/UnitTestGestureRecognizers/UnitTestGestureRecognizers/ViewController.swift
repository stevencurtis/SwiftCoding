//
//  ViewController.swift
//  UnitTestGestureRecognizers
//
//  Created by Steven Curtis on 18/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var subclassedView : PanRotatePinchUIView!

    override func loadView() {
        
        let view = UIView()
        view.backgroundColor = .lightGray
        
        subclassedView = PanRotatePinchUIView()
        view.addSubview(subclassedView)
        subclassedView.backgroundColor = .green
        
        subclassedView.translatesAutoresizingMaskIntoConstraints = false
        subclassedView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        subclassedView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        subclassedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -160).isActive = true
        subclassedView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
      
        self.view = view
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


