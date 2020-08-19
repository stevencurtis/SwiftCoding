//
//  SearchViewController.swift
//  DarkMode
//
//  Created by Steven Curtis on 20/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let searchImageView = UIImageView()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground

        
        let image = UIImage(named: "photo")
        let asset = image?.imageAsset
        let resolvedImage = asset?.image(with: traitCollection)
        searchImageView.image = resolvedImage
        searchImageView.clipsToBounds = true
        searchImageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(searchImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchImageView.widthAnchor.constraint(equalToConstant: 300),
            searchImageView.heightAnchor.constraint(equalToConstant: 200),
            searchImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            searchImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

    }
    
}
