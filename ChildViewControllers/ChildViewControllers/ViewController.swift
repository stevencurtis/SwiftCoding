//
//  ViewController.swift
//  ChildViewControllers
//
//  Created by Steven Curtis on 30/03/2021.
//

import UIKit

class ViewController: UIViewController {
    let loadingVC = SpinnerViewController()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        loadContentViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.removeContentViewController()
        })
    }


    func loadContentViewController() {
        addChild(loadingVC)
        view.addSubview(loadingVC.view)
        loadingVC.didMove(toParent: self)
    }
    
    func removeContentViewController() {
        willMove(toParent: nil)
        loadingVC.view.removeFromSuperview()
        loadingVC.removeFromParent()
    }
}

