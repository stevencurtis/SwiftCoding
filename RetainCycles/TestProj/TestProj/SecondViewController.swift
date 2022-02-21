//
//  SecondViewController.swift
//  TestProj
//
//  Created by Steven Curtis on 24/09/2020.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .blue
        self.view = view
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var articles = 0
    let dataManagerClass = DataManagerClass()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManagerClass.articlesDidChange = { [weak self] result in
            self?.articles = result
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
         print ("deinit Second View Controller")
    }

}

class DataManagerClass {
    var articlesDidChange: ((Int)->())?
}
