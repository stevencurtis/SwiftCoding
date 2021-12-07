//
//  ViewController.swift
//  ViewsThreads
//
//  Created by Steven Curtis on 02/12/2021.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: String(describing: Self.self),
            bundle: Bundle(for: Self.self)
        )
        
        self.viewModel.dictionarySet = { dict in
            let values = dict.allValues.description
            DispatchQueue.main.async {
                self.textView.text = values
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUsers()
    }
}

