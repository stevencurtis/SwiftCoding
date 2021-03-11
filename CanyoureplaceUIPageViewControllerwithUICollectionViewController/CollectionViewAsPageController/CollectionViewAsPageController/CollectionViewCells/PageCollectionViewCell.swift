//
//  PageCollectionViewCell.swift
//  CollectionViewAsPageController
//
//  Created by Steven Curtis on 29/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {

    fileprivate var mainText: String?
    fileprivate var image: String?
    fileprivate var mainTitle: String?
    
    fileprivate var bgColor: UIColor?
    fileprivate var fgColor: UIColor?
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var bottomColorBar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
    }

    var tapAction : (()->())?
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        tapAction!()
    }
    
    override func prepareForReuse() { }
    
    func setupVC(title: String, mainText: String, imageName: String, bgColor: UIColor, fgColor: UIColor, action: (()->())?) {
        self.contentLabel.text = mainText
        self.titleLabel.text = title
        self.imageView.image = UIImage(named: imageName)
        view.backgroundColor = bgColor
        bottomColorBar.backgroundColor = fgColor
        tapAction = action
    }

}
