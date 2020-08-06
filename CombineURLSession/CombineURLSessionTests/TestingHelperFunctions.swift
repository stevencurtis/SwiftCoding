//
//  TestingHelperFunctions.swift
//  KeychainImplementationTests
//
//  Created by Steven Curtis on 15/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import CombineURLSession


public func ==(lhs: [String: Any], rhs: [String: Any] ) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

extension RegisterModel: Equatable {
    public static func ==(lhs: RegisterModel, rhs: RegisterModel) -> Bool {
        return lhs.id == rhs.id && lhs.token == rhs.token
    }
}
