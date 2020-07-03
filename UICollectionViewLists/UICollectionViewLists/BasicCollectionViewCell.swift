//
//  LinkCollectionViewCell.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 29/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewListCell {
    var textLabel = UILabel()
    let border = UIView()

    
    func updateWithText(_ titleString: String) {
        textLabel.text = titleString
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(textLabel)
        textLabel.textColor = .link
        textLabel.font = UIFont(name: "system", size: 18)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        border.backgroundColor = .opaqueSeparator
        self.addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            border.topAnchor.constraint(equalTo: self.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            border.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            border.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Gives the cell a chance to modify the attributes provided by the layout object.
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
        -> UICollectionViewLayoutAttributes {
            return layoutAttributes
    }
}


