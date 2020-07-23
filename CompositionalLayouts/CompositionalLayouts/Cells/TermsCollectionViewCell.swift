//
//  TermsCollectionViewCell.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 30/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class TermsCollectionViewCell: UICollectionViewCell {
    var textLabel = UILabel()
    let border = UIView()

    public func configure(with data: AppDataModel, final: Bool) {
        textLabel.text = data.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(textLabel)
        textLabel.textColor = .lightGray
        textLabel.font = UIFont(name: "system", size: 12)
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
            border.topAnchor.constraint(equalTo: self.topAnchor),
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
