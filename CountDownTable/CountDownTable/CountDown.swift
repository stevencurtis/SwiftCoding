//
//  Created by Steven Curtis on 27/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

@IBDesignable class CountDown: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, minutes: CGFloat) {
        self.init(frame: frame)
        self.minutes = minutes
    }

    @IBInspectable
    var seconds: CGFloat = 0 {
        didSet {
            update(time: .seconds, units: seconds, animate: true)
        }
    }
    
    @IBInspectable
    var minutes: CGFloat = 0 {
        didSet {
            update(time: .minutes, units: minutes, animate: true)
        }
    }
    
    @IBInspectable
    var hours: CGFloat = 0 {
        didSet {
            update(time: .hours, units: hours, animate: true)
        }
    }
    
    let shapeLayer = CAShapeLayer()
    var animationClosure: (() -> ())?

    enum TimeUnits {
        case hours
        case minutes
        case seconds
    }
    
    override func draw(_ rect: CGRect) {
        let shapeLayerCircle = CAShapeLayer()
        shapeLayerCircle.path = drawArc(
            startAngle: 0,
            endAngle: CGFloat.pi * 2).cgPath
        
        let halfSize = min( bounds.size.width / 2, bounds.size.height / 2)
        let radius = CGFloat( halfSize - ( 1 / 2) )

        shapeLayerCircle.strokeColor = UIColor.lightGray.cgColor
        shapeLayerCircle.fillColor = UIColor.clear.cgColor
        shapeLayerCircle.lineWidth = 3.0
        shapeLayerCircle.position = CGPoint(
            x: -((radius * 2) - rect.width) / 2,
            y: 0)
        self.layer.addSublayer(shapeLayerCircle)
    }

    func update(time: TimeUnits, units: CGFloat, animate: Bool = false) {
        var duration: CGFloat
        var divisor: CGFloat = 6
        var units = units

        switch time {
        case .hours:
            duration = units * 60 * 60
            divisor = 6
            units = units * 2.5
        case .minutes:
            duration = units * 60
            divisor = 6
        case .seconds:
            duration = units
            divisor = 6
        }

        let halfSize: CGFloat = min( bounds.size.width / 2, bounds.size.height / 2)
        let radius = CGFloat( halfSize - ( 1 / 2) )

        shapeLayer.path = drawArc(
            startAngle: (3 * CGFloat.pi) / 2,
            endAngle: CGFloat( (units * divisor) * CGFloat.pi / 180 ) - CGFloat.pi / 2).cgPath
        shapeLayer.strokeColor = UIColor.link.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.position = CGPoint(
            x: -((radius * 2) - self.bounds.width) / 2,
            y: 0)
        
        self.layer.addSublayer(shapeLayer)
        
        // ensure this layer is forwards of the grey circle layer
        shapeLayer.zPosition = 1

        if animate {
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isRemovedOnCompletion = false
            animation.toValue = 0.0
            animation.duration = CFTimeInterval(duration)

            CATransaction.setCompletionBlock {
                if let closure = self.animationClosure {
                    closure()
                }
            }

            shapeLayer.add(animation, forKey: "myStroke")
            CATransaction.commit()
        }
    }
    
    private func drawArc(startAngle: CGFloat, endAngle: CGFloat) -> UIBezierPath {
        let halfSize: CGFloat = min( bounds.size.width / 2, bounds.size.height / 2)
        let desiredLineWidth: CGFloat = 1
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: halfSize, y: halfSize),
            radius: CGFloat( halfSize - ( desiredLineWidth / 2) ),
            startAngle: startAngle,
            endAngle:endAngle,
            clockwise: true)
        return circlePath
    }
}
