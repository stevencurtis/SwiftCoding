//
//  CircularCoordinator.swift
//  CircularTransition
//
//  Created by Steven Curtis on 21/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class CircularCoordinator: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircularAnimator()
    }
}
