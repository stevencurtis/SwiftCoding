//
//  ViewController.swift
//  CADisplayLinkExamples
//
//  Created by Steven Curtis on 07/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // the timer instance
    var timer = Timer()
    
    // set up the CADisplayLink
    var displayLink: CADisplayLink?

    
    @IBAction func goToExample(_ sender: UIButton) {
        timer.invalidate()
        displayLink?.invalidate()
    }
    
    // the function that the CADisplayLink will fire
    @objc func updateAnimation() {
        print("CADisplayLink Update animation")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
        displayLink?.add(to: .current, forMode: .common)
        
        // set up the timer
        timer = Timer.scheduledTimer(withTimeInterval: 1 / 60,
              repeats: true) { timer in
              print ("Timer update animation")
            }
    }
    
}

