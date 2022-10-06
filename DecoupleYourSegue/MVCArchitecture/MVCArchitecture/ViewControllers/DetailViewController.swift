//
//  DetailViewController.swift
//  MVCArchitecture
//
//  Created by Steven Curtis on 14/05/2021.
//

import UIKit

protocol DataViewProtocol: AnyObject {
    var data: String { get set }
}

class DetailViewController: UIViewController, DataViewProtocol {
    var data: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let lab = UILabel()
        view.addSubview(lab)
        lab.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lab.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lab.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        lab.text = "Data items downloaded: \(data)"
    }
}
