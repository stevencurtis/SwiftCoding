//
//  ViewController.swift
//  AnimateBarButton
//
//  Created by Steven Curtis on 01/12/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var barButtonItem: UIBarButtonItem! {
        didSet {
            // use the image set on the barButtonItem
            let icon = barButtonItem.image
            
            // set the iconSize
            let iconSize = CGRect(origin: .zero, size: icon!.size)
            
            // create a UIButton with the iconSeize
            let iconButton = UIButton(frame: iconSize)
            
            // setBackgroundImage for the UIButton
            iconButton.setBackgroundImage(icon, for: [])

            // the button goes into the right-hand side of the Navigation Bar
            barButtonItem.customView = iconButton
            
            // the custom view starts off small
            barButtonItem.customView!.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            // animate the custom view to the regular size
            UIView.animate(withDuration: 1.0,
                delay: 0.0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 10,
                options: .curveLinear,
                animations: {
                    // restore the identity transform; so the button goes back to the original size
                    self.barButtonItem.customView!.transform = .identity
                },
                completion: nil
            )
            
            // set the target of the button
            iconButton.addTarget(self, action: #selector(handleStarButtonTap), for: .touchUpInside)
        }
    }
    
    @objc private func handleStarButtonTap(_ sender: UIButton) {
        // negative is anti-clockwise
        barButtonItem.customView!.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi * 6/5))
        UIView.animate(withDuration: 1.0) {
            // restore the identity transform; so the button goes back to the original position
            self.barButtonItem.customView!.transform = .identity
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
