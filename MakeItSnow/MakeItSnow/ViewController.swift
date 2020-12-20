//
//  ViewController.swift
//  MakeItSnow
//
//  Created by Steven Curtis on 20/12/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var snowView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let snowViewEmitterLayer = CAEmitterLayer()
        // set the size of the emitter (where the particles originate)
        snowViewEmitterLayer.emitterSize = CGSize(width: snowView.frame.width, height: 2)
        // set the shape to be a line, as opposed to be a rectange etc.
        snowViewEmitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        // set the position of the emitter
        snowViewEmitterLayer.emitterPosition = CGPoint(x: snowView.frame.width / 2, y: snowView.frame.height / 2)
        // set the cells that emit. In this case, a single cell
        snowViewEmitterLayer.emitterCells = [generateSnowEmitterCell()]
        // add the emitter layer as a subview
        snowView.layer.addSublayer(snowViewEmitterLayer)
    }


    // this is a function that creates the CAEmitterCell
    private func generateSnowEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        // set the colour to be white
        cell.color = UIColor.white.cgColor
        // set the contents to be a white color
        cell.contents = UIColor.white.image(CGSize(width: 55, height: 55)).cgImage
        // number of items created per second
        cell.birthRate = 9.0
        // the lifetime of a cell in seconds
        cell.lifetime = 14.0
        // how much the lifetime of a cell can vary
        cell.lifetimeRange = 0
        // the scale factor applied to the call
        cell.scale = 0.1
        // the range in which the scale factor can vary
        cell.scaleRange = 0.1
        // the intial velocity of the cell
        cell.velocity = CGFloat(100)
        // the amount by which the velocity can vary
        cell.velocityRange = 0
        // emission angle
        cell.emissionLongitude = CGFloat.pi
        // the cone around which emissions can occur
        cell.emissionRange = 0.5
        // the rotational velocity applied to the cell
        cell.spin = 3.5
        // the variance of spin over a cell's lifetime
        cell.spinRange = 1
        return cell
    }
    
}

// an extension to create a solid image from a color
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
