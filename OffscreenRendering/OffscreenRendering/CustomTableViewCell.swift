//
//  CustomTableViewCell.swift
//  OffscreenRendering
//
//  Created by Steven Curtis on 30/11/2020.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    /// A cache for the shadow path
    var shadowPathCache: CGPath?
    
    lazy var rightImage: UIImageView? = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubview(rightImage!)
        
        NSLayoutConstraint.activate([
            rightImage!.topAnchor.constraint(equalTo: topAnchor),
            rightImage!.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightImage!.rightAnchor.constraint(equalTo: rightAnchor),
            rightImage!.widthAnchor.constraint(equalTo: rightImage!.heightAnchor),
        ])
    }
    
    func setupCell(image: String) {
        rightImage?.image = UIImage(named: image)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let shadowPath = self.shadowPathCache {
            rightImage!.layer.shadowPath = shadowPath
        } else if let rect = rightImage?.bounds {
            self.shadowPathCache = UIBezierPath(rect: rect).cgPath
        }
        
        rightImage?.layer.shadowRadius = 8
        rightImage?.layer.shadowOffset = CGSize(width: -3, height: -3)
        rightImage?.layer.shadowOpacity = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

