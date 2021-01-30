//
//  ViewController.swift
//  SwiftLintInstallation
//
//  Created by Steven Curtis on 26/12/2020.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        let array: NSArray = NSArray(array: [5, 6, 7])
//        let numbers = array as! [Int]
//        print(numbers.reduce(0, +))

        let array: NSArray = NSArray(array: [5, 6, 7])
        let numbers = array as? [Int]
        print(numbers?.reduce(0, +) as Any)
    }
}
