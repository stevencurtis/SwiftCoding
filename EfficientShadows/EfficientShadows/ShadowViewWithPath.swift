//
//  ShadowViewWithPath.swift
//  EfficientShadows
//
//  Created by Steven Curtis on 30/11/2020.
//

import UIKit

class ShadowViewWithPath: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupColor()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 15
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
