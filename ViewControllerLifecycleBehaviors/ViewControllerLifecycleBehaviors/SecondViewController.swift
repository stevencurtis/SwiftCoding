//
//  SecondViewController.swift
//  ViewControllerLifecycleBehaviors
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBehaviours()
    }
    
    private func setupBehaviours() {
//        addBehaviors([DefaultStyleNavigationBarBehavior()])
//        addBehaviors([HideNavigationBarBehavior()])

    }

}
