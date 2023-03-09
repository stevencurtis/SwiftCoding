//
//  UIView+Shadows.swift
//  EfficientShadows
//
//  Created by Steven Curtis on 27/11/2020.
//

import UIKit

@IBDesignable
extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let initcolor = layer.borderColor  {
                return UIColor.init(cgColor: initcolor) }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset : CGSize{
        get {
            return layer.shadowOffset
        } set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor : UIColor {
        get {
            if let shadow = layer.shadowColor {
                return UIColor.init(cgColor: shadow)
            }
            return UIColor.init(cgColor: layer.shadowColor ?? UIColor.blue.cgColor)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity : Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
}
