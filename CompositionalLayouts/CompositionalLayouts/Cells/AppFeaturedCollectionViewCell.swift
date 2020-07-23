//
//  AppFeaturedCollectionViewCell.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 26/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class AppFeaturedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var featureImageView: UIImageView!
    @IBOutlet weak var featureTitle: UILabel!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    public func configure(with data: AppDataModel, final: Bool) {
        if let feature = data.featureReason?.rawValue {
            featureTitle.text = feature
        }
        appTitle.text = data.title
        subTitle.text = data.subtitle
//        title.text = data.title
//        (final) ? (border.isHidden = true) : (border.isHidden = false)
//        appImage.image = UIImage(named: data.smallImage)
        
        featureImageView.image = UIImage(named: data.featureImage)
        
        featureImageView.layer.cornerRadius = 5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
