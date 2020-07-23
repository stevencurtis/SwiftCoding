//
//  NewUpdatedCollectionViewCell.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 29/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class NewUpdatedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var appImage: UIImageView!
    
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var inAppLabel: UILabel!
    public func configure(with data: AppDataModel, final: Bool) {
        title.text = data.title
        subtitle.text = data.subtitle
        
        inAppLabel.isHidden = !((data.inApp) ?? false)
        
        (final) ? (border.isHidden = true) : (border.isHidden = false)
        appImage.image = UIImage(named: data.smallImage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getButton.layer.cornerRadius = 15
        appImage.layer.cornerRadius = 12
    }

    // Gives the cell a chance to modify the attributes provided by the layout object.
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
        -> UICollectionViewLayoutAttributes {
            return layoutAttributes
    }
}
