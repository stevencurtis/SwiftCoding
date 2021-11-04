//
//  ContentTableViewCell.swift
//  MultipleInitializers
//
//  Created by Steven Curtis on 02/11/2021.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    func configure(with model: ContentTableViewCellViewModel) {
//        if let image = model.image {
//            profileImageView.image = image
//            titleLabel.isHidden = true
//            profileImageView.isHidden = false
//        } else {
//            titleLabel.text = model.title
//            profileImageView.isHidden = true
//            titleLabel.isHidden = false
//        }
//    }
    
    func configure(with content: ContentTableViewCellViewModel.CellContent) {
        switch content {
        case let .image(image):
            switch image {
            case let .name(name):
                profileImageView.image = UIImage(named: name)
            case let .url(url):
                // retrieve from url
                break
            }
            titleLabel.isHidden = true
            profileImageView.isHidden = false
        case let .title(title):
            titleLabel.text = title
            profileImageView.isHidden = true
            titleLabel.isHidden = false
        }
    }
}
