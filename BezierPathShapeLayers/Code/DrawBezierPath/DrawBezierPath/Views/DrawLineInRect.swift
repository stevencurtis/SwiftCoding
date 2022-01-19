//
//  DrawLineInRect.swift
//  DrawBezierPath
//
//  Created by Steven Curtis on 12/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DrawLineInRect: UIView {
    override func draw(_ rect: CGRect) {
        let bP = UIBezierPath()
        bP.move(to: CGPoint(x: 0, y: 0))
        bP.lineWidth = 5.0
        UIColor.blue.setStroke()
        bP.addLine(to: CGPoint(x: 50, y: 100))
        bP.stroke()
    }
}
