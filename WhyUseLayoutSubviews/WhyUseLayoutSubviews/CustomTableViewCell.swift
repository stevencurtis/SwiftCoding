//
//  CustomTableViewCell.swift
//  WhyUseLayoutSubviews
//
//  Created by Steven Curtis on 30/11/2020.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    /// A cache for the shadow path
    var shadowPathCache: CGPath?
    
    /// The image on the left-hand side of the UITableViewCell
    lazy var leftImage: UIImageView? = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(leftImage!)

        // do not setup AutoLayout according to the textLabel's autoresizing mask
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel!.topAnchor.constraint(equalTo: topAnchor),
            textLabel!.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel!.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: leftImage!.trailingAnchor, multiplier: 1),
            textLabel!.trailingAnchor.constraint(equalTo: trailingAnchor),
            leftImage!.topAnchor.constraint(equalTo: topAnchor),
            leftImage!.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftImage!.leftAnchor.constraint(equalTo: leftAnchor),
            leftImage!.widthAnchor.constraint(equalTo: leftImage!.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(data: String, image: String) {
        textLabel!.text = "Cell data: \(data)"
        leftImage!.image = UIImage(named: "PlaceholderImage")
    }
    
    // perform precise layout of the subviews by overriding layoutSubviews()
    override func layoutSubviews() {
        super.layoutSubviews()
        if let shadowPath = self.shadowPathCache {
            leftImage!.layer.shadowPath = shadowPath
        } else if let rect = leftImage?.bounds {
            self.shadowPathCache = UIBezierPath(rect: rect).cgPath
        }
        
        leftImage?.layer.shadowRadius = 8
        leftImage?.layer.shadowOffset = CGSize(width: 3, height: 3)
        leftImage?.layer.shadowOpacity = 0.5
    }
}
