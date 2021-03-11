//
//  DetailViewController.swift
//  ProtocolDelegateMemoryLeak
//
//  Created by Steven Curtis on 22/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit


class DetailLeakViewController: UIViewController, ViewModelDelegate {
    
    var viewmodel : ViewModel?
    
    func retrieveData(_ data: [String]){
        print (data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = ViewModel()
        viewmodel?.delegate = self
    }
}

protocol ViewModelDelegate {
    func retrieveData(_ data: [String])
}

class ViewModel {
    let data = ["1","2","3","4","5","6"]
    var delegate : ViewModelDelegate?
    
    func fetchData() {
        delegate?.retrieveData(data)
    }
}


