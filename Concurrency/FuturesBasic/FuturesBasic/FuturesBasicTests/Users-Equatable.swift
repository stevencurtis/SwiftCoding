//
//  Users-Equatable.swift
//  FuturesBasicTests
//
//  Created by Steven Curtis on 02/02/2023.
//

import Foundation
@testable import FuturesBasic

extension Users: Equatable {
    public static func == (lhs: FuturesBasic.Users, rhs: FuturesBasic.Users) -> Bool {
        lhs.support.url == rhs.support.url && lhs.data.map { $0.id } == rhs.data.map { $0.id }
    }
}
