//
//  DrawLineCGContext.swift
//  DrawBezierPath
//
//  Created by Steven Curtis on 31/12/2021.
//  Copyright © 2021 Steven Curtis. All rights reserved.
//

import UIKit

class DrawLineCGContext: UIView {
        
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(5.0)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 50, y: 100))
        context.addPath(path)
        context.strokePath()
    }
}
