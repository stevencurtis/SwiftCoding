//
//  ViewController.swift
//  ModelNavigationBar
//
//  Created by Steven Curtis on 23/05/2021.
//

import UIKit

final class ViewController: UIViewController {
    private var embeddedNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func DisplayModal(_ sender: UIButton) {
        let viewController = ModalViewController()
        let closeBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .done,
            target: self,
            action: #selector(self.dismissViewController(animated:)))
        viewController.navigationItem.rightBarButtonItem = closeBarButtonItem

        embeddedNavigationController = UINavigationController(rootViewController: viewController)
        navigationController?.present(embeddedNavigationController!, animated: true)
    }
    
    @objc private func dismissViewController(animated: Bool) {
        embeddedNavigationController?.dismiss(animated: true, completion: {})
    }
}

final class ModalViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Title"
    }
}
