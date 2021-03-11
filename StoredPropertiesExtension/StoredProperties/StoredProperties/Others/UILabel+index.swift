//
//  UILabel+index.swift
//  StoredProperties
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

extension UILabel {
    private struct Data {
        static var _index: Int = 0
    }
    
    var index: Int {
        get {
            return Data._index
        }
        set {
            Data._index = newValue
        }
    }
}
