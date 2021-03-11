//
//  UpdateCornersView.swift
//  DesignableInspectable
//
//  Created by Steven Curtis on 09/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

@IBDesignable class UpdateCornersView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 1
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
       didSet {
           layer.borderWidth = borderWidth
       }
    }
    
    @IBInspectable var borderColor: UIColor? {
       didSet {
        layer.borderColor = borderColor?.cgColor
       }
    }

}



