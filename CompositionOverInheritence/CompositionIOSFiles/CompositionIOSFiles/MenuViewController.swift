//
//  MenuViewController.swift
//  CompositionIOSFiles
//
//  Created by Steven Curtis on 09/09/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @objc func inheritanceButtonAction() {
        performSegue(withIdentifier: "inheritanceSegue", sender: nil)
    }
    
    @objc func compositionButtonAction() {
        performSegue(withIdentifier: "compositionSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let inheritanceButton = UIButton(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
        inheritanceButton.backgroundColor = .gray
        inheritanceButton.setTitle("Inheritance", for: .normal)
        inheritanceButton.setTitleColor(.black, for: .normal)
        let saveTap = UITapGestureRecognizer(target: self, action: #selector(inheritanceButtonAction))
        inheritanceButton.addGestureRecognizer(saveTap)
        view.addSubview(inheritanceButton)
        
        inheritanceButton.translatesAutoresizingMaskIntoConstraints = false
        inheritanceButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        inheritanceButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
        let loadButton = UIButton(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
        loadButton.backgroundColor = .gray
        loadButton.setTitle("Composition", for: .normal)
        loadButton.setTitleColor(.black, for: .normal)
        let loadTap = UITapGestureRecognizer(target: self, action: #selector(compositionButtonAction))
        loadButton.addGestureRecognizer(loadTap)
        view.addSubview(loadButton)
        
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        loadButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        loadButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 60).isActive = true
    }


}
