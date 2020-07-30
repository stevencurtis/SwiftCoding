//
//  FloatExtensions.swift
//  GradientLayerDeepDive
//
//  Created by Steven Curtis on 17/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

extension Float {
    var StringFromFloat: String?
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(for: self)
    }
}

extension CGFloat {
    var StringFromFloat: String?
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(for: self)
    }
}

extension NSNumber {
    var StringFromFloat: String?
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(for: self)
    }
}
