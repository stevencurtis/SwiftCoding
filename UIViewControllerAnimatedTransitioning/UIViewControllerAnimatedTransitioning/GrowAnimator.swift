//
//  GrowAnimator.swift
//  UIViewControllerAnimatedTransitioning
//
//  Created by Steven Curtis on 20/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class GrowAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting : Bool
    var originFrame : CGRect
    
    init(isPresenting : Bool, originFrame : CGRect) {
        self.isPresenting = isPresenting
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        TimeInterval(UINavigationController.hideShowBarDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard
            let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from),
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            else {
                // We only complete transition with success if the transition was executed.
                transitionContext.completeTransition(false)
                return
        }
                
        container.addSubview(toView)
        
        if isPresenting {
            let artworkVC = toViewController as! DetailViewController
            artworkVC.imageView.alpha = 0
            
            let transitionImageView = UIImageView(frame: originFrame)
            transitionImageView.image = artworkVC.imageView.image
            container.addSubview(transitionImageView)
            
            toView.frame = CGRect(
                x: fromView.frame.width,
                y: 0,
                width: toView.frame.width,
                height: toView.frame.height)
            toView.alpha = 0
            toView.layoutIfNeeded()
            
            UIView.animate(withDuration: TimeInterval(UINavigationController.hideShowBarDuration), animations: {
                transitionImageView.frame = artworkVC.imageView.frame
                toView.frame = fromView.frame
                toView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                transitionImageView.removeFromSuperview()
                artworkVC.imageView.alpha = 1
            })
        } else {
            let artworkVC = fromViewController as! DetailViewController
            artworkVC.imageView.alpha = 1 // will be 1 in any case
            
            let transitionImageView = UIImageView(frame: artworkVC.imageView.frame)
            transitionImageView.image = artworkVC.imageView.image
            container.addSubview(transitionImageView)
            
            UIView.animate(withDuration: TimeInterval(UINavigationController.hideShowBarDuration), animations: {
                transitionImageView.frame = self.originFrame
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                transitionImageView.removeFromSuperview()
            })
        }
    }
}
