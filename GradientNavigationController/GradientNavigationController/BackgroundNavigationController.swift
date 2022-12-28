//
//  BackgroundNavigationController.swift
//  GradientNavigationController
//
//  Created by Steven Curtis on 16/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class BackgroundNavigationController: UINavigationController {
    override func viewDidLoad() {
         super.viewDidLoad()

         let gradient = CAGradientLayer()
         var bounds = navigationBar.bounds
         bounds.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
         gradient.frame = bounds
         gradient.colors = [UIColor.green.cgColor, UIColor.blue.cgColor]
         gradient.startPoint = CGPoint(x: 0, y: 0)
         gradient.endPoint = CGPoint(x: 1, y: 0)

         if let image = getImageFrom(gradientLayer: gradient) {
            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            
            let appearance = navigationBar.standardAppearance.copy()
            appearance.backgroundImage = image
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
         }
     }

     func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
         var gradientImage:UIImage?
         UIGraphicsBeginImageContext(gradientLayer.frame.size)
         if let context = UIGraphicsGetCurrentContext() {
             gradientLayer.render(in: context)
             gradientImage = UIGraphicsGetImageFromCurrentImageContext()?
                .resizableImage(
                    withCapInsets: UIEdgeInsets.zero,
                    resizingMode: .stretch
            )
         }
         UIGraphicsEndImageContext()
         return gradientImage
     }
}
