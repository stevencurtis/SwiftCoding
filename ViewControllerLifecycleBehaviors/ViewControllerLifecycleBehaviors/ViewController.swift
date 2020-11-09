//
//  ViewController.swift
//  ViewControllerLifecycleBehaviors
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

struct BlackStyleNavigationBarBehavior: ViewControllerLifecycleBehavior {
    func viewDidLoad(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.barStyle = .black
    }
}

struct DefaultStyleNavigationBarBehavior: ViewControllerLifecycleBehavior {
    func viewDidLoad(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.barStyle = .default
    }
}

struct HideNavigationBarBehavior: ViewControllerLifecycleBehavior {
    func viewWillAppear(viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func viewWillDisappear(viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBehaviours()
    }
    
    private func setupBehaviours() {
//        addBehaviors([BlackStyleNavigationBarBehavior()])
        addBehaviors([HideNavigationBarBehavior()])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
