//
//  ViewController.swift
//  Gradients
//
//  Created by Steven Curtis on 23/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for view in stackView.arrangedSubviews {
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.black.cgColor
        }

        // 1
        var gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradient.frame = view1.bounds
        gradient.locations = [0.0, 0.5]
        view1.layer.insertSublayer(gradient, at: 0)
        
        // 2
        gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradient.frame = view2.bounds
        gradient.locations = [0.5, 1.0]
        view2.layer.insertSublayer(gradient, at: 0)

        // 3
        gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor]
        gradient.frame = view3.bounds
        gradient.locations = [0, 0.5, 1.0]
        view3.layer.insertSublayer(gradient, at: 0)

        // 4
        gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor]
        gradient.frame = view4.bounds
        gradient.locations = [0, 0.8, 1.0]
        view4.layer.insertSublayer(gradient, at: 0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        

    }

}

