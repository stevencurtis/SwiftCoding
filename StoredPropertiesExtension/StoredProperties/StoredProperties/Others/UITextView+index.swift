//
//  UITextView+index.swift
//  StoredProperties
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

extension UITextView {
    private static var _index = StoredProperty<Int>()
    
    var index: Int {
        get {
            return UITextView._index.get(self) ?? 0
        }
        set {
            UITextView._index.set(self, value: newValue)
        }
    }
}
