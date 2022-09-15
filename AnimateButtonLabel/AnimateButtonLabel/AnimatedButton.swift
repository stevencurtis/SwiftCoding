//
//  AnimatedButton.swift
//  AnimateButtonLabel
//
//  Created by Steven Curtis on 03/12/2020.
//

import UIKit

class AnimatedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // run the customize version to set the colours and the UIView
        customize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // run the customize version to set the colours and the UIView
        customize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Whenever the frame changes, run the customize function
        customize()
    }
    
    func customize() {
        // confine the subviews to the bounds of this view
        self.clipsToBounds = true
        // create a CABasicAnimation for the x-position animation
        let buttonAnimation = CABasicAnimation(keyPath: "position.x")
        // begin the animation straight away
        buttonAnimation.beginTime = 0.0
        // this animation will last 1.5 seconds
        buttonAnimation.duration = 1.5
        // a property representing the x value where the titleLabel will scroll from
        let buttonRHS: Double = Double(((self.titleLabel?.frame.maxX)! + (self.titleLabel?.frame.width)!))
        // a property representing the x value where the titleLabel will scroll to
        let buttonLHS: Double = Double(((self.titleLabel?.frame.minX)! - ((self.titleLabel?.frame.width)!)))
        // set the from value of the animation
        buttonAnimation.fromValue = NSNumber(value: buttonRHS)
        // set the to value of the animation
        buttonAnimation.toValue = NSNumber(value: buttonLHS)
        // repeat the animation forever
        buttonAnimation.repeatCount = .infinity
        // add the animation to the UIButton's titleLabel
        self.titleLabel!.layer.add(buttonAnimation, forKey: "basic")
    }
}
