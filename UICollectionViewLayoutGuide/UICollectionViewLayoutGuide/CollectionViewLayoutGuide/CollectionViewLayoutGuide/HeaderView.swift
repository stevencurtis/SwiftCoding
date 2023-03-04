//
//  HeaderView.swift
//  CollectionViewLayoutGuide
//
//  Created by Steven Curtis on 27/04/2021.
//

import UIKit

class HeaderView: UICollectionReusableView {
    lazy var title: UILabel = {
        let lab = UILabel(frame: .zero)
        lab.textAlignment = .center
        lab.textColor = .label
        return lab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        title.text = ""

        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
