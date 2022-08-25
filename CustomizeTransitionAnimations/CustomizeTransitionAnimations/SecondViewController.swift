//
//  SecondViewController.swift
//  CustomizeTransitionAnimations
//
//  Created by Steven Curtis on 17/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var dataSent: String?
    
    lazy var backButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        print ("Data sent to SecondViewController \(dataSent ?? "" )")
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.removeFromParent()
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
    }


}


