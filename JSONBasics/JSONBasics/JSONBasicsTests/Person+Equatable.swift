//
//  Person+Equatable.swift
//  JSONBasicsTests
//
//  Created by Steven Curtis on 29/03/2023.
//

@testable import JSONBasics

extension ViewController.Person: Equatable {
    public static func == (lhs: ViewController.Person, rhs: ViewController.Person) -> Bool {
        lhs.email == rhs.email
    }
}
