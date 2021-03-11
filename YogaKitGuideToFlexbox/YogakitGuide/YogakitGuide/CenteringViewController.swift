//
//  CenteringViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 11/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import FlexLayout

class CenteringViewController: UIViewController {

    fileprivate let parentFlexContainer = UIView()

    override func viewDidLayoutSubviews() {
        parentFlexContainer.flex.layout(mode: .fitContainer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        parentFlexContainer.flex.direction(.column).padding(12).define { (flex) in

            
        }
    }
    


}
