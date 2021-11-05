//
//  SubclassedTapGestureRecognizer.swift
//  PassParameterTapGesture
//
//  Created by Steven Curtis on 25/09/2021.
//

import UIKit

class SubclassedTapGestureRecognizer: UITapGestureRecognizer {
    let number: Int
    init(target: AnyObject, action: Selector, number: Int) {
        self.number = number
        super.init(target: target, action: action)
    }
}
