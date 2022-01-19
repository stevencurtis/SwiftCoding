//
//  DrawRect.swift
//  DrawBezierPath
//
//  Created by Steven Curtis on 13/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DrawRect: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawRectangle()
    }
    
    /// required init from Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawRectangle()
    }

    override func draw(_ rect: CGRect) {
        UIColor.blue.setStroke()
        UIColor.blue.setFill()
        let bP = UIBezierPath()
        bP.move(to: CGPoint(x: rect.maxX, y: 0))
        bP.addLine(to: CGPoint(x: rect.maxX, y: 100))
        bP.addLine(to: CGPoint(x: rect.maxX - 100, y: 100))
        bP.addLine(to: CGPoint(x: rect.maxX - 100, y: 0))
        bP.close()
        bP.fill()
        bP.stroke()
    }
    
    func drawRectangle() {
        let bP = UIBezierPath()
        bP.move(to: CGPoint(x: 0, y: 0))
        bP.addLine(to: CGPoint(x: 0, y: 100))
        bP.addLine(to: CGPoint(x: 100, y: 100))
        bP.addLine(to: CGPoint(x: 100, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.path = bP.cgPath
        shapeLayer.lineWidth = 5.0
        
        self.layer.addSublayer(shapeLayer)
    }
}
