//
//  AppsCompositionalLayout-setupNavBar.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 29/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

extension AppsCompositionalLayout {
    func setupNavBar() {
        let image = UIImage(systemName: "person.crop.circle")
        let imageView = UIImageView(image: image)
        
        navigationController?.navigationBar.subviews.forEach { subview in
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            guard stringFromClass.contains("UINavigationBarLargeTitleView") else { return }
            subview.subviews.forEach { label in
                guard label is UILabel else { return }
                subview.addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: label.topAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 40),
                    imageView.heightAnchor.constraint(equalToConstant: 40),
                    imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20)
                ])
            }
        }
    }
}
