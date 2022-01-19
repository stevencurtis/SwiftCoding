//
//  DrawLine.swift
//  DrawBezierPath
//
//  Created by Steven Curtis on 12/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DrawLine: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawLine()
    }
    
    func drawLine() {
        let bP = UIBezierPath()
        bP.move(to: CGPoint(x: 0, y: 0))
        bP.addLine(to: CGPoint(x: 50, y: 100))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.path = bP.cgPath
        shapeLayer.lineWidth = 5.0
        
        self.layer.addSublayer(shapeLayer)
    }
}
