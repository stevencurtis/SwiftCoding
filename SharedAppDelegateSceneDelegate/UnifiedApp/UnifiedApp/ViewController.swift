//
//  ViewController.swift
//  UnifiedApp
//
//  Created by Steven Curtis on 15/08/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .purple
        self.view = view
    }
}
