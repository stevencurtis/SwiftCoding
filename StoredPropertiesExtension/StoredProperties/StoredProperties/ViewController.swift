//
//  ViewController.swift
//  StoredProperties
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let butt = UIButton(frame: .zero)
        butt.index = 3
        print (butt.index)
        
        let lab = UILabel()
        lab.index = 5
        print (lab.index)
        
        let secondLab = UILabel()
        print (secondLab.index)
        
        let textView = UITextView()
        textView.index = 2
        print (textView.index)
        
        let secondText = UITextView()
        print (secondText.index)
        
    }
}
