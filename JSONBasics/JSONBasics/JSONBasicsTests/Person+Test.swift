//
//  Person+Test.swift
//  JSONBasicsTests
//
//  Created by Steven Curtis on 29/03/2023.
//

@testable import JSONBasics

extension ViewController.Person {
    static func test(
        name: String,
        age: Int,
        email: String
    ) -> ViewController.Person {
        ViewController.Person(name: name, age: age, email: email)
    }
}
