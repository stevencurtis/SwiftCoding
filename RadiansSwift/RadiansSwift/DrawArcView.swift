import UIKit

class DrawArcView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    func drawArc(startRadians: CGFloat, endRadians: CGFloat) {
        let bP = UIBezierPath(
            arcCenter: CGPoint(x: 50, y: 128),
            radius: 50,
            startAngle: startRadians,
            endAngle: endRadians,
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.path = bP.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawArc(startDegrees: CGFloat, endDegrees: CGFloat) {
        let bP = UIBezierPath(
            arcCenter: CGPoint(x: 50, y: 128),
            radius: 50,
            startAngle: DrawArcView.degRad(startDegrees),
            endAngle: DrawArcView.degRad(endDegrees),
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.path = bP.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    static func degRad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
}


class DegreesConverter {

    static func degRad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    static func radDeg(_ number: CGFloat) -> CGFloat {
        return number * 180 / .pi
    }
    
    // we know two sides and the angle between them - returns the final side
    static func sideAngleSide(b: CGFloat, c: CGFloat, arrowAngle: CGFloat) -> CGFloat {
        let bSquared = b * b
        let cSquared = c * c
        let first: CGFloat = CGFloat(((bSquared) + (cSquared)))
        let cossed = cos(arrowAngle)
        let second = (2 * CGFloat(b) * CGFloat(c)) * cossed
        let result = sqrt(first - second)
        return result
    }
    
    // used with sideAngleSide to return the smallest angle
    static func smallestAngle(angle: CGFloat, finalSide b: CGFloat, smallestSide a: CGFloat) -> CGFloat {
        let sinB = (sin(angle) * b) / a
        // The inverse of sin is asin
        return asin(sinB)
    }
}


