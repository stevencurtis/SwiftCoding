//
//  LinkCollectionViewCell.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 19/02/2021.
//

import UIKit
import SDWebImage

class SongCollectionViewCell: UICollectionViewCell {
    lazy var imageView = UIImageView()
    lazy var heartImageView = UIImageView()
    
    var topRightTap: (() -> ())?
    var onTap: (() -> ())?
    var topRightAction: ButtonModel?
    
    public func configure(with favourite: Favourites, onTap: (() -> ())?, topRightAction: ButtonModel? = nil) {
        self.onTap = onTap
        if let action = topRightAction {
            topRightTap = action.action
            if let icon = action.icon {
                heartImageView.image = (
                    UIImage(
                        systemName: icon
                    )?.withTintColor(
                        .black,
                        renderingMode: .alwaysOriginal
                    )
                )
            }
        }
        imageView.sd_setImage(with: URL(string: favourite.image), placeholderImage: UIImage(named: "placeholder"))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        
        addSubview(heartImageView)
        heartImageView.contentMode = .scaleAspectFit
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getButtonTapped))
        heartImageView.addGestureRecognizer(tapGesture)
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        imageView.addGestureRecognizer(cellTapGesture)
        
        NSLayoutConstraint.activate([
            heartImageView.topAnchor.constraint(equalTo: topAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -00),
            heartImageView.heightAnchor.constraint(equalToConstant: 30),
            heartImageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    @IBAction func getButtonTapped(_ sender: UIButton){
        topRightTap?()
    }
    
    @objc func didTouchDown(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended {
            topRightTap?()
        }
    }
    
    @IBAction func cellTapped(){
        print ("cell tapped")
        onTap?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
        -> UICollectionViewLayoutAttributes {
            return layoutAttributes
    }
    
    override func prepareForReuse() {
        heartImageView.image = nil
        imageView.image = nil
        heartImageView.sd_cancelCurrentImageLoad()
    }
}


