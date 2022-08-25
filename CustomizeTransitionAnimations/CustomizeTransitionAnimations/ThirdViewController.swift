//
//  ThirdViewController.swift
//  CustomizeTransitionAnimations
//
//  Created by Steven Curtis on 18/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.navigationController?.delegate = self
    }
    
    @IBAction func moveToVC(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForthViewController") as? ForthViewController
        {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ThirdViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimator()
    }
}
