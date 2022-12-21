//
//  ViewController.swift
//  StoryboardDelete
//
//  Created by Steven Curtis on 12/12/2022.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let view = ButtonView()
        view.button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        self.view = view
    }
    
    @objc
    private func buttonDidTap() {
        let controller = DetailViewController()
        present(controller, animated: true, completion: nil)
    }
}
