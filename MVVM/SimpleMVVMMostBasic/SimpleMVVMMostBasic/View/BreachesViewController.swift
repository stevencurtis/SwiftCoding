//
//  ViewController.swift
//  SimpleMVVMExample
//
//  Created by Steven Curtis on 03/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class BreachesViewController: UIViewController {
       
    // the view model is setup with simple
    var breachesViewModel = BreachViewModel(model: [BreachModel(title: "000webhost")])

    override func viewDidLoad() {
        super.viewDidLoad()
        let breachView = BreachView(frame: self.view.frame)
        breachesViewModel.configure(breachView)
        self.view.addSubview(breachView)
        breachView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breachView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            breachView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            breachView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            breachView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
}



