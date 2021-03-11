//
//  DetailNoLeakViewController.swift
//  ProtocolDelegateMemoryLeak
//
//  Created by Steven Curtis on 22/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class DetailNoLeakViewController: UIViewController, ViewModelWeakDelegate {
    
    var viewmodel : ViewNoLeakModel?
    
    func retrieveData(_ data: [String]){
        print (data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = ViewNoLeakModel()
        viewmodel?.delegate = self
    }
}

// a class bound protocol is guarenteed to be used only on classes, and cannot be used on enums or structs.
// this makes sense because weak is a qualifier for reference types (as opposed to value types) so only
// makes sense on classes

protocol ViewModelWeakDelegate : class {
    func retrieveData(_ data: [String])
}

class ViewNoLeakModel {
    let data = ["1","2","3","4","5","6"]
    weak var delegate : ViewModelWeakDelegate?
    
    func fetchData() {
        delegate?.retrieveData(data)
    }
}

