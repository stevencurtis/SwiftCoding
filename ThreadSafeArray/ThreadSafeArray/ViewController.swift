//
//  ViewController.swift
//  ThreadSafeArray
//
//  Created by Steven Curtis on 15/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    var array = [0]
    // var array = SafeArray(repeating: 0, count: 1)

    func oneThousand(originalArray:Bool, interations: Int) -> Int? {
        if originalArray {
            var standardArray = [0]
            DispatchQueue.concurrentPerform(iterations: interations) { index in
                standardArray.append( (standardArray.last!) + 1 )
            }
            return (standardArray.count)
        } else {
            let safeArray = SafeArray(repeating: 0, count: 1)
            DispatchQueue.concurrentPerform(iterations: interations) { index in
                safeArray.append(safeArray.last! + 1 )
            }
            return (safeArray.count)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.concurrentPerform(iterations: 6) { index in
//            array.append( array.last! + 1 )
//        }
//        print (array.count)
        

//        DispatchQueue.concurrentPerform(iterations: 6) { index in
//            array.append(array.last! + 1 )
//        }
//        print (array.count)
    }


}

