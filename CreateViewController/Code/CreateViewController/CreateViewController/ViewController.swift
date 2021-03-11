//
//  ViewController.swift
//  CreateViewController
//
//  Created by Steven Curtis on 15/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var centreLabel: UILabel!
    
    var labelText = "View Controller created from: "
     
    var source : String?
    
    init(source : String) {
        super.init(nibName: nil, bundle: nil)
        self.source = source
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.source = "storyboard"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centreLabel.text = labelText + (source ?? "")
    }

}

