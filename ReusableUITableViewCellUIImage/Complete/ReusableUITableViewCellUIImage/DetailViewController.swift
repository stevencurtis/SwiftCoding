//
//  DetailViewController.swift
//  ReusableUITableViewCellUIImage
//
//  Created by Steven Curtis on 13/06/2021.
//

import UIKit

class DetailViewController: UIViewController {

    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ProfileView()
        view.configure(with: "James")
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            view.heightAnchor.constraint(equalToConstant: 150),
            view.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
