//
//  CircleMaskView.swift
//  CleanTableViews
//
//  Created by Steven Curtis on 16/01/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//  https://stackoverflow.com/questions/16512761/calayer-with-transparent-hole-in-it

import Foundation
import UIKit
import CoreGraphics

class CircleMaskView {
    
    fileprivate var fillLayer = CAShapeLayer()
    var target: UIView?
    
    var fillColor: UIColor = UIColor.gray {
        didSet {
            self.fillLayer.fillColor = self.fillColor.cgColor
        }
    }
    
    var radius: CGFloat? {
        didSet {
            self.draw()
        }
    }
    
    var opacity: Float = 0.5 {
        didSet {
            self.fillLayer.opacity = self.opacity
        }
    }

    init(drawIn: UIView) {
        self.target = drawIn
    }
    
    /**
     Draw a circle mask on target view
     */
    func draw() {
        guard let target = target else {
            print("target is nil")
            return
        }
        
        var rad: CGFloat = 0
        let size = target.frame.size
        if let r = self.radius {
            rad = r
        } else {
            rad = min(size.height, size.width)
        }
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 0.0)
        let circlePath = UIBezierPath(roundedRect: CGRect(x: size.width / 2.0 - rad / 2.0, y: size.height / 2.0 - rad / 2.0, width: rad, height: rad), cornerRadius: rad)
        
        path.append(circlePath)
        path.usesEvenOddFillRule = true
        
        fillLayer.path = path.cgPath
        fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
        fillLayer.fillColor = self.fillColor.cgColor
        fillLayer.opacity = self.opacity
        self.target!.layer.addSublayer(fillLayer)
    }
    
    func remove() {
        self.fillLayer.removeFromSuperlayer()
    }
    
}
