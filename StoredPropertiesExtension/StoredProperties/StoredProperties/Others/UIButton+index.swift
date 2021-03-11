//
//  UIButton+index.swift
//  StoredProperties
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

class ButtonData {
    var index: Int = 0
    init(index: Int) {
        self.index = index
    }
}

extension UIButton {
    private static let association = ObjectAssociation<ButtonData>()
    var index: Int {
        set { UIButton.association[self] = ButtonData(index: newValue) }
        get {
            return UIButton.association[self]!.index
        }
    }
}
