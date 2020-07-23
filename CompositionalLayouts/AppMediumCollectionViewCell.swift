//
//  AppMediumCollectionViewCell.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 26/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class AppMediumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var appImageView: UIImageView!
    
    public func configure(with data: AppDataModel, final: Bool) {
        appTitleLabel.text = data.title
        appImageView.image = UIImage(named: data.featureImage)  
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
