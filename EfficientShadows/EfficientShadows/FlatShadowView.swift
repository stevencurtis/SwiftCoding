//
//  FlatShadowView.swift
//  EfficientShadows
//
//  Created by Steven Curtis on 01/12/2020.
//

import UIKit

class FlatShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupColor()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 0
        
        // the height of the frame
        let height: CGFloat = frame.height
        // the width of the frame
        let width: CGFloat = frame.width
        // assign the shadowRadius
        layer.shadowRadius = 0
        // assign the shadowOffset
        layer.shadowOffset = .zero
        // assign the shadowOpacity
        layer.shadowOpacity = 0.2
        
        // define the offset for the bottom of the shadow
        let shadowOffsetX: CGFloat = 1000
        // the shadowPath to be drawn
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: height))
        shadowPath.addLine(to: CGPoint(x: width, y: 0))
        shadowPath.addLine(to: CGPoint(x: width + shadowOffsetX, y: 1000))
        shadowPath.addLine(to: CGPoint(x: shadowOffsetX, y: 1000))
        // assign the shadowPath
        layer.shadowPath = shadowPath.cgPath
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
