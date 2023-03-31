//
//  SecondViewController.swift
//  UItableViewBackgroundTwo
//
//  Created by Steven Curtis on 20/06/2021.
//

import UIKit

class SecondViewController: UIViewController {

    let viewModel: SecondViewModel
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .orange
        self.view = view
    }

    init(viewModel: SecondViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
