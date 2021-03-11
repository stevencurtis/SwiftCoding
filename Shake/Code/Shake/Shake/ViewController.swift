//
//  ViewController.swift
//  Shake
//
//  Created by Steven Curtis on 09/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var shakeLabel: UILabel!
    var shakeCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shakeLabel.text = "Shaken 0 times"
        
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            shakeCounter += 1
            shakeLabel.text = "Shaken \(shakeCounter) times"
        }
    }
}

