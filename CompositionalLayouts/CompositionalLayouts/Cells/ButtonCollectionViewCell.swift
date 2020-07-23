//
//  ButtonCollectionViewCell.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 29/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    var button = UIButton()
    public func configure(with data: AppDataModel, final: Bool) {
        button.setTitle(data.title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(button)
        button.backgroundColor = .systemGray5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)

        button.layer.cornerRadius = 6
        
        button.setTitleColor(.link, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
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
