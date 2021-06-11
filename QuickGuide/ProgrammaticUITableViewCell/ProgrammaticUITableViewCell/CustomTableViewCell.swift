//
//  CustomTableViewCell.swift
//  ProgrammaticUITableViewCell
//
//  Created by Steven Curtis on 13/11/2020.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    lazy var rightImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
        addSubview(rightImage)
        NSLayoutConstraint.activate([
            rightImage.topAnchor.constraint(equalTo: topAnchor),
            rightImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightImage.rightAnchor.constraint(equalTo: rightAnchor),
            rightImage.widthAnchor.constraint(equalTo: rightImage.heightAnchor)
        ])
    }
    
    func setupCell(image: String) {
        rightImage.image = UIImage(named: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
