//
//  Float.swift
//  CleanTableViews
//
//  Created by Steven Curtis on 16/01/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
import Darwin

public extension Float {
    public static func random(_ lower: Float = 0.0, upper: Float = 1.0) -> Float {
        let r = Float(arc4random(UInt32.self)) / Float(UInt32.max)
        return (r * (upper - lower)) + lower
    }
}

public extension Double {
    public static func random(_ lower: Double = 0.0, upper: Double = 1.0) -> Double {
        let r = Double(arc4random(UInt64.self)) / Double(UInt64.max)
        return (r * (upper - lower)) + lower
    }
}


