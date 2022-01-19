//
//  DrawArcs.swift
//  DrawBezierPath
//
//  Created by Steven Curtis on 13/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DrawArcs: UIView {

    override func draw(_ rect: CGRect) {
        let bP = UIBezierPath(
            arcCenter:
                CGPoint(
                    x: rect.maxX - 50,
                    y: 128
                ),
            radius: 50,
            startAngle: 180 * .pi / 180,
            endAngle: 0 * .pi / 180,
            clockwise: true
        )
        
        UIColor.blue.setStroke()
        UIColor.blue.setFill()
        
        bP.fill()
        bP.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawArc()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        drawArc()
    }
    
    func drawArc() {
        let bP = UIBezierPath(
            arcCenter: CGPoint(x: 50, y: 128),
            radius: 50,
            startAngle: 180 * .pi / 180,
            endAngle: 0 * .pi / 180,
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.path = bP.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}
