//
//  DetailViewController.swift
//  StoryboardDelete
//
//  Created by Steven Curtis on 12/12/2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    override func loadView() {
        let view = DetailUIView()
        view.button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        self.view = view
    }
    
    @objc
    private func buttonDidTap() {
        dismiss(animated: true, completion: nil)
    }
}
