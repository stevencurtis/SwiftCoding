//
//  Sandwich+Equatable.swift
//  RecreateSandwichesTests
//
//  Created by Steven Curtis on 04/04/2023.
//

@testable import RecreateSandwiches

extension Sandwich: Equatable {
    public static func == (lhs: Sandwich, rhs: Sandwich) -> Bool {
        lhs.id == rhs.id
    }
}
