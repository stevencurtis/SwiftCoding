//
//  DependencyInjectionViewController.swift
//  DependencyInjection
//
//  Created by Steven Curtis on 15/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class DependencyInjectionViewController: UIViewController {

    var passedData : String
    
    @IBOutlet weak var instatiateLabel: UILabel!
    
    init(display: String) {
        passedData = display
        super.init(nibName: "InitializationView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instatiateLabel.text = passedData

    }

}
