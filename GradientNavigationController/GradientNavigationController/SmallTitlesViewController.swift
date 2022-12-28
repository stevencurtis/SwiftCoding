//
//  SmallTitlesViewController.swift
//  GradientNavigationController
//
//  Created by Steven Curtis on 17/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class SmallTitlesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupGradient()
    }
    
    func setupGradient() {
        guard let navigationController = navigationController else {return}
        var newFrame = self.navigationController?.navigationBar.frame
        newFrame?.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = newFrame ?? .zero
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        guard let graphicsContext = UIGraphicsGetCurrentContext() else {return}
        gradientLayer.render(in: graphicsContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.navigationController!.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        
        let appearance = navigationController.navigationBar.standardAppearance.copy()
        appearance.backgroundImage = image
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    



}
