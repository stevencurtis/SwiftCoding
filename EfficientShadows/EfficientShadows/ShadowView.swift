//
//  ShadowView.swift
//  EfficientShadows
//
//  Created by Steven Curtis on 27/11/2020.
//

import UIKit

class ShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    
    func setupShadow() {
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 15
        self.backgroundColor = .systemBlue
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupShadow()
    }
}
