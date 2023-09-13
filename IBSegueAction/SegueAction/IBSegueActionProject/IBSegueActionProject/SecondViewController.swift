//
//  SecondViewController.swift
//  IBSegueActionProject
//
//  Created by Steven Curtis on 17/07/2023.
//

import UIKit

class SecondViewController: UIViewController {

    var myNum: Int?
    
    init?(myNum: Int, coder: NSCoder) {
        self.myNum = myNum
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        print(myNum)
    }
}
