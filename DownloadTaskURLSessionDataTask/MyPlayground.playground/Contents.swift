import UIKit

var fillColor = UIColor.green
let maskLayer = CAShapeLayer()
let fillLayer = CAShapeLayer()

func changeBackgroundColor() {
    
    let animcolor = CABasicAnimation(keyPath: "fillColor")
    animcolor.fromValue = UIColor.green.cgColor
    animcolor.toValue = UIColor.orange.cgColor
    animcolor.duration = 1.0;
    animcolor.repeatCount = 0;
    animcolor.autoreverses = true
    fillLayer.add(animcolor, forKey: "fillColor")
    
}

// re-adjust the clipping path when the view bounds changes

let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.backgroundColor = UIColor.white

func createPaths() {
    let clipPath = UIBezierPath()
    clipPath.move(to: CGPoint(x: view.bounds.minX + 7.65, y: view.bounds.minY - 0.25))
    clipPath.addCurve(to: CGPoint(x: view.bounds.minX + 7.65, y: view.bounds.minY + 36.1),
                      controlPoint1: CGPoint(x: view.bounds.minX - 2.38, y: view.bounds.minY + 9.79),
                      controlPoint2: CGPoint(x: view.bounds.minX - 2.38, y: view.bounds.minY + 26.06))
    clipPath.addCurve(to: CGPoint(x: view.bounds.minX + 43.99, y: view.bounds.minY + 36.1),
                      controlPoint1: CGPoint(x: view.bounds.minX + 17.69, y: view.bounds.minY + 46.13),
                      controlPoint2: CGPoint(x: view.bounds.minX + 33.96, y: view.bounds.minY + 46.13))
    
    clipPath.addLine(to: CGPoint(x: view.bounds.minX + 43.99, y: view.bounds.minY + 36.1))
    clipPath.addLine(to: CGPoint(x: view.bounds.minX + 44.01, y: view.bounds.minY + 0.19))
    clipPath.addLine(to: CGPoint(x: view.bounds.minX + 7.58, y: view.bounds.minY + 0.19))
    
    // update layer paths
    fillLayer.path = clipPath.cgPath
    maskLayer.path = clipPath.cgPath
    
    fillLayer.fillColor = fillColor.cgColor
    fillLayer.fillRule = .evenOdd
    view.layer.addSublayer(fillLayer)
    maskLayer.fillRule = .evenOdd
    view.layer.mask = maskLayer
}

createPaths()
