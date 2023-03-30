//
//  InjectedViewController.swift
//  UserDefaultsExample
//
//  Created by Steven Curtis on 30/09/2020.
//

import UIKit

class InjectedViewController: UIViewController {
    var userDefaults: UserDefaults!
    var isPreviouslyLaunched = false
    
    @IBSegueAction func segueAction(_ coder: NSCoder) -> InjectedMockViewController? {
        return InjectedMockViewController(coder: coder, userDefaults: UserDefaults())
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder, userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue

        let previouslyLaunched = userDefaults.bool(forKey: "previouslyLaunched")
        if previouslyLaunched {
            print ("Previously Launched in InjectedViewController")
            isPreviouslyLaunched = true
        } else {
            print ("Not Previously Launched in InjectedViewController")
            isPreviouslyLaunched = false
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
        }
    }
}
