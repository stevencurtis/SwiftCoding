//
//  TimeModelEquatable.swift
//  AdvancedCodableTests
//
//  Created by Steven Curtis on 01/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import AdvancedCodable

extension TimeModel: Equatable {    
    public static func == (lhs: TimeModel, rhs: TimeModel) -> Bool {
        return
            lhs.uniqueKey == rhs.uniqueKey
    }
}
