//
//  ViewController.swift
//  VisualMemoryDebugger
//
//  Created by Steven Curtis on 12/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let parent = Parent(name: "Kim", child: nil)
        let child = Child(name: "Jafari", parent: parent)
        parent.child = child
    }
}
