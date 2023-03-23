//
//  ViewController.swift
//  TestProject
//
//  Created by Steven Curtis on 10/03/2023.
//

import UIKit

final class Counter {
    private var count = 0
    func increment() -> Int {
        count += 1
        return count
    }
}

final class ViewController: UIViewController {
    
    private var tasks = [Task<Void, Never>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let counter = Counter()
  
        for _ in 1...1000 {
               tasks += [
                Task.detached {
                       print(counter.increment())
                   }
               ]
           }
    }
}
