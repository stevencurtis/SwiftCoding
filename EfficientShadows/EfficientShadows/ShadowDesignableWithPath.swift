//
//  ShadowDesignableWithPath.swift
//  EfficientShadows
//
//  Created by Steven Curtis on 01/12/2020.
//

import UIKit

@IBDesignable
class ShadowDesignableWithPath: UIView {
    override func layoutSubviews() {
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
}
