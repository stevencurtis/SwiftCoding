//
//  GradientView.swift
//  DesignableInspectable
//
//  Created by Steven Curtis on 09/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        return gradientLayer
    }()
    
    @IBInspectable
    public var startColor: UIColor = .green {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    @IBInspectable
    public var endColor: UIColor = .blue {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.insertSublayer(gradientLayer, at: 0)
    }

}
