//
//  CircularAnimator.swift
//  CircularTransition
//
//  Created by Steven Curtis on 21/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class CircularAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        TimeInterval(UINavigationController.hideShowBarDuration)
    }
    
    weak var context: UIViewControllerContextTransitioning?
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // save the context
        context = transitionContext
        
        
        let containerView = transitionContext.containerView
        
        guard
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            else {
                // We only complete transition with success if the transition was executed.
                transitionContext.completeTransition(false)
                return
        }
        
        containerView.addSubview(toView)
        
        let radius: CGFloat = 100
        let toHeight = toView.bounds.height
        
        let circleMaskPathInitial = UIBezierPath(
            ovalIn: CGRect(origin:
                CGPoint(x: toView.frame.midX - (radius / 2),
                        y: toHeight / 2
                ),
                           size: CGSize(width: radius, height: radius)
            )
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathInitial.cgPath
        toView.layer.mask = maskLayer
        
        let circleMaskPathFinal = UIBezierPath(
            ovalIn: CGRect(origin:
                CGPoint(x: -toView.bounds.width,
                        y: -toView.bounds.height / 2
                ),
                           size: CGSize(
                            width: toHeight * 2,
                            height: toHeight * 2)
            )
        )
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.delegate = self
        maskLayerAnimation.duration = TimeInterval(UINavigationController.hideShowBarDuration)
        maskLayer.path = circleMaskPathFinal.cgPath
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
}

extension CircularAnimator: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        context?.completeTransition(true)
    }
}

