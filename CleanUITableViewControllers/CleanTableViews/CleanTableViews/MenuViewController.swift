//
//  ViewController.swift
//  CleanTableViews
//
//  Created by Steven Curtis on 16/01/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    fileprivate var circleMaskView :CircleMaskView?

    @IBOutlet weak var imageClipper: UIView!
    @IBOutlet weak var backgroundImagesContainer: UIView!
    @IBOutlet weak var backgroundImageViewBack: UIImageView!
    
    //    @IBOutlet weak var backgroundImagesContainer: UIView!
//    @IBOutlet weak var imageClipper: UIView!
  //  @IBOutlet weak var backgroundImageViewBack: UIView!
  //  @IBOutlet weak var backgroundImageViewFront: UIView!
   
//    @IBOutlet weak var backgroundImageViewBack: UIImageView!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // The circleMaskView is instantiated here, because autolayout is not yet performed when viewDidLoad fires.
        // This leads to the circleMaskView being larger than the screen at the point of viewDidLoad
        // Ensure that only a single instance of circleMaskView is used by checking for nil
        if(circleMaskView == nil){
            circleMaskView = CircleMaskView(drawIn: imageClipper)
            circleMaskView!.radius = imageClipper.frame.size.height * 0.65
            circleMaskView!.fillColor = UIColor.white
            circleMaskView!.opacity = 1
            circleMaskView!.draw()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.backgroundImageViewBack.image = UIImage(named: "clean")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.backgroundImagesContainer.autoTranslateAnimation(8.0)
    }


}

