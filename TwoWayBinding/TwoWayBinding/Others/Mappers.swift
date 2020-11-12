//
//  Mappers.swift
//  TwoWayBinding
//
//  Created by Steven Curtis on 12/11/2020.
//

import Foundation

enum Mappers {
    static var transformBoolToStringFunction: (Bool) -> String = String.init(_:)
    static var transformFloatToStringFunction: (Float) -> String = String.init(_:)
    static var transformIntToStringFunction: (Int) -> String = String.init(_:)
}
