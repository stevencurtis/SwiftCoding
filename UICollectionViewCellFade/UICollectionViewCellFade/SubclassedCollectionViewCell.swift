//
//  SubclassedCollectionViewCell.swift
//  UICollectionViewFlowLayoutSubclass
//
//  Created by Steven Curtis on 12/12/2020.
//

import UIKit

class SubclassedCollectionViewCell: UICollectionViewCell {
    // the hotel is lazyly instantiated in a UIImageView
    var hotelImageView: UIImageView = {
        var hotelView = UIImageView()
        hotelView.contentMode = .scaleAspectFill
        hotelView.clipsToBounds = true
        return hotelView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add the imageview to the UICollectionView
        addSubview(hotelImageView)
        // we are taking care of the constraints
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        // pin the image to the whole collectionview
        hotelImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        hotelImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        hotelImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        hotelImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(image: String) {
        // set the appropriate image
        if let image : UIImage = UIImage(named: image) {
            hotelImageView.image = image
        }
    }
    
    func updateCell(faded: Bool, animated: Bool = true) {
        // if you want the opacity animated
        if animated {
            // animate with the duration in seconds
            UIView.animate(withDuration: 0.2) {
                // if it is faded, fade out to 0.1 opacity. If not, make clear at 1.0 opacity
                self.alpha = faded ? 0.1 : 1.0

            }
        } else {
            // if it is faded, fade out to 0.1 opacity. If not, make clear at 1.0 opacity
            self.alpha = faded ? 0.1 : 1.0
        }
    }
}

