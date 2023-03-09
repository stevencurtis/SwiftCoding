//
//  ContactShadowView.swift
//  EfficientShadows
//
//  Created by Steven Curtis on 01/12/2020.
//

import UIKit

class ContactShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupColor()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 15
        
        
        let shadowSize: CGFloat = 20
        // create the size of the oval to draw the oval within
        let contactRect = CGRect(x: 0, y: 50 - (shadowSize * 0.5), width: 20 + shadowSize * 2, height: shadowSize)
        // create the val shadowPath
        layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        // define the radius of the shadow
        layer.shadowRadius = 5
        // define the shadowOpacity of the shadow
        layer.shadowOpacity = 0.3
    }
    
    func setupColor() {
        self.backgroundColor = .systemBlue
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupColor()
    }
}

