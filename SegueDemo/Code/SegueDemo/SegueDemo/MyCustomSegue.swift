//
//  MyCustomSegue.swift
//  SegueDemo
//
//  Created by Steven Curtis on 28/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class MyCustomSegue: UIStoryboardSegue {
    
    private var selfRetainer: MyCustomSegue? = nil

    override func perform() {
        destination.transitioningDelegate = self
        selfRetainer = self
        destination.modalPresentationStyle = .overCurrentContext
        source.present(destination, animated: true, completion: nil)
    }
}

extension MyCustomSegue: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Presenter()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        selfRetainer = nil
        return Dismisser()
    }
    
    private class Presenter: NSObject, UIViewControllerAnimatedTransitioning {
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 1.5
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            let containerView = transitionContext.containerView
            let toView = transitionContext.view(forKey: .to)!
            
            containerView.addSubview(toView)
            toView.alpha = 0.0
            UIView.animate(withDuration: 1.5,
                           animations: {
                            toView.alpha = 1.0
            },
                           completion: { _ in
                            transitionContext.completeTransition(true)
            }
            )
        }
    }
    
    private class Dismisser: NSObject, UIViewControllerAnimatedTransitioning {
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.2
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            let container = transitionContext.containerView
            let fromView = transitionContext.view(forKey: .from)!
            UIView.animate(withDuration: 0.2, animations: {
                fromView.frame.origin.y += container.frame.height - fromView.frame.minY
            }) { (completed) in
                transitionContext.completeTransition(completed)
            }
        }
        
        
    }
}
