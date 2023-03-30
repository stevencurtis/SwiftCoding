//
//  InjectedMockViewController.swift
//  UserDefaultsExample
//
//  Created by Steven Curtis on 30/09/2020.
//

import UIKit

protocol UserDefaultsProtocol {
    func bool(forKey defaultName: String) -> Bool
}

extension UserDefaults: UserDefaultsProtocol {}

class InjectedMockViewController: UIViewController {
    var userDefaults: UserDefaultsProtocol!
    var isPreviouslyLaunched = false

    init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder, userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange

        let previouslyLaunched = userDefaults.bool(forKey: "previouslyLaunched")
        if previouslyLaunched {
            print ("Previously Launched in InjectedMockViewController")
            isPreviouslyLaunched = true
        } else {
            print ("Not Previously Launched in InjectedMockViewController")
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
            isPreviouslyLaunched = false
        }
    }
}
