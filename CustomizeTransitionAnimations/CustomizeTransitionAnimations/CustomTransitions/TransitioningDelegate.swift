//
//  TransitioningDelegate.swift
//  CustomizeTransitionAnimations
//
//  Created by Steven Curtis on 17/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimator()
    }
}
