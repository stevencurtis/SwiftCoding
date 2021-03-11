//
//  ViewController.swift
//  Overriding
//
//  Created by Steven Curtis on 08/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = SalesCalculator().income(sellingPrice: 3.0)
        _ = SalesCalculator().getSalesPrice()
        
    }


}

