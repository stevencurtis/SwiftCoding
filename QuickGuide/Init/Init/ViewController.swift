//
//  ViewController.swift
//  Init
//
//  Created by Steven Curtis on 07/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var me = Person.init(name: "Dave") // my name isn't Dave
        var you = Person(name: "Dave") // applies if your name is Dave
        
        print (me, you)
    }


}

