//
//  DepthShadowView.swift
//  EfficientShadows
//
//  Created by Steven Curtis on 01/12/2020.
//

import UIKit

class DepthShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupColor()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 15
        
        // the radius of the shadow
        let shadowRadius: CGFloat = 5
        // the width of the shadow
        let shadowWidth: CGFloat = 1.25
        // the height of the shadow
        let shadowHeight: CGFloat = 0.5
        // the height of the frame
        let height: CGFloat = frame.height
        // the width of the frame
        let width: CGFloat = frame.width

        // the shadowPath to be drawn
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: shadowRadius / 2, y: height - shadowRadius / 2))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius / 2, y: height - shadowRadius / 2))
        shadowPath.addLine(to: CGPoint(x: width * shadowWidth, y: height + (height * shadowHeight)))
        shadowPath.addLine(to: CGPoint(x: width * -(shadowWidth - 1), y: height + (height * shadowHeight)))
        // assign the shadowPath
        layer.shadowPath = shadowPath.cgPath
        // assign the shadowRadius
        layer.shadowRadius = shadowRadius
        // assign the shadowOffset
        layer.shadowOffset = .zero
        // assign the shadowOpacity
        layer.shadowOpacity = 0.2
    }
    
    func setupColor() {
        self.backgroundColor = .systemBlue
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupColor()
    }
}
