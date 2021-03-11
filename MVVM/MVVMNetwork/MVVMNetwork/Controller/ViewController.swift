//
//  ViewController.swift
//  MVVMNetwork
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

protocol BreachViewModelType {
    func fetchData(completion: @escaping ([BreachModel]) -> Void)
    func configure (_ view: BreachView, number index: Int)
}

class ViewController: UIViewController {
    var breachesViewModel: BreachViewModelType!
    var breachView : BreachView?
    
    // to be called during testing
    init(viewModel: BreachViewModelType) {
        breachesViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // required when called from storyboard
    required init?(coder aDecoder: NSCoder) {
        breachesViewModel = BreachViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()       
        breachesViewModel.fetchData{ [weak self] breaches in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }

    func updateUI() {
        breachView = BreachView(frame: view.frame)
        breachesViewModel.configure(breachView!, number: 3)
        view.addSubview(breachView!)
    }
}

