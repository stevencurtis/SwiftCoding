//
//  ViewController.swift
//  Annotation
//
//  Created by Steven Curtis on 03/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        takePicture()
        print (increment(3))
        readArr([])
    }
    
    func readArr(_ arr: [Int]) {
        for i in 0...arr.count {
            if i == arr.count {
//                #error("error found")
            }
        }
    }
    
    func increment(_ num: Int) -> Int {
        // FIXME: Make this increment the input
        #warning("Incorrect result returned")
        return num
    }
    
    
    @discardableResult
    func takePicture() -> Bool {
        #if targetEnvironment(simulator)
            // TODO: Do camera stuff
            return true
        #else
            return true
        #endif
    }
    
//    @discardableResult
//    func takePicture() -> Bool {
//        // TODO: Do camera stuff
//        return true
//    }

}

