//
//  ViewController.swift
//  DIIOS13
//
//  Created by Steven Curtis on 25/09/2020.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    @IBSegueAction
    func createDetailViewController(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> DetailViewController? {
      return DetailViewController(coder: coder, item: "Test")
    }
}

