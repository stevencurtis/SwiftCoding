//
//  ViewController.swift
//  StrongClosures
//
//  Created by Steven Curtis on 10/02/2022.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel: ViewModel
    private var value: String?
    private var weakValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // Beware, we can only have one
        // of these that will return a value at any given time!
        viewModel.articlesDidChange = { value in
            self.value = value
        }
        
        viewModel.articlesDidChange = { [weak self] value in
            self?.value = value
        }
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

