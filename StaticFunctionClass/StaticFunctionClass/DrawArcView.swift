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
