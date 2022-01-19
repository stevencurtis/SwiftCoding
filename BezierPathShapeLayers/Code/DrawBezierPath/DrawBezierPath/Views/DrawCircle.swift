//
//  DrawCircle.swift
//  DrawBezierPath
//
//  Created by Steven Curtis on 13/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DrawCircle: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawOval()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        drawOval()
    }
    
    override func draw(_ rect: CGRect) {
        let subRect = CGRect(x: rect.maxX - 100, y: 0, width: 100, height: 100)
        UIColor.blue.setStroke()
        UIColor.blue.setFill()
        let bP = UIBezierPath(ovalIn: subRect)
        bP.stroke()
        bP.fill()
    }

    func drawOval() {
        let subRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let bP = UIBezierPath(ovalIn: subRect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.path = bP.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}
