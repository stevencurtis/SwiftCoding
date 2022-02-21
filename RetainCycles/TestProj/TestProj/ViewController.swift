//
//  ViewController.swift
//  TestProj
//
//  Created by Steven Curtis on 24/09/2020.
//

import UIKit

class ViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let second = SecondViewController()
        self.navigationController?.pushViewController(second, animated: true)
    }
}
