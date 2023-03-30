//
//  ViewController.swift
//  UserDefaultsExample
//
//  Created by Steven Curtis on 30/09/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBSegueAction func segueAction(_ coder: NSCoder) -> InjectedViewController? {
        return InjectedViewController(coder: coder, userDefaults: UserDefaults())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red

        let previouslyLaunched = UserDefaults.standard.bool(forKey: "previouslyLaunched")
        if previouslyLaunched {
            print ("Previously Launched")
        } else {
            print ("Not Previously Launched")
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
        }
    }
}

