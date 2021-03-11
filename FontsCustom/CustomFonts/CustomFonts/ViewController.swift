//
//  ViewController.swift
//  CustomFonts
//
//  Created by Steven Curtis on 21/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelDefaultFont: UILabel!
    @IBOutlet weak var labelChangedFont: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        labelDefaultFont.font = labelDefaultFont.font.withSize(18.0)
        labelChangedFont.font = UIFont(name: "Roboto-Regular", size: 18)
        

    }


}

