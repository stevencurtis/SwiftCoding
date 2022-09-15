//
//  InjectedViewController.swift
//  ServiceOriented
//
//  Created by Steven Curtis on 30/03/2021.
//

import UIKit

class InjectedViewController: UIViewController {
    var viewModel: ViewModelProtocol
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        viewModel.dataClosure = { data in
            DispatchQueue.main.async {
                self.textView.text = data?.data.map{ $0.email }.joined(separator: "\n")
            }
        }
    }
    
    required init?(coder: NSCoder, viewModel: ViewModelProtocol) {
      self.viewModel = viewModel
      super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
      fatalError("A view model is required")
    }
    @IBAction func downloadAction(_ sender: UIButton) {
        viewModel.download()
    }
}
