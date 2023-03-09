//
//  ViewController.swift
//  EfficientShadows
//
//  Created by Steven Curtis on 27/11/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var basicView: UIView!
    @IBOutlet weak var basicViewRounded: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        basicView.layer.shadowRadius = 8
        basicView.layer.shadowOffset = CGSize(width: 3, height: 3)
        basicView.layer.shadowOpacity = 0.5
        
        basicViewRounded.layer.shadowRadius = 8
        basicViewRounded.layer.shadowOffset = CGSize(width: 3, height: 3)
        basicViewRounded.layer.shadowOpacity = 0.5
        basicViewRounded.layer.cornerRadius = 15
    }


}

