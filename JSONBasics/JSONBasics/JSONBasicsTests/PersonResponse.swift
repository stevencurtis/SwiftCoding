//
//  PersonResponse.swift
//  JSONBasicsTests
//
//  Created by Steven Curtis on 29/03/2023.
//

@testable import JSONBasics

struct PersonResponse: Decodable {
    let customers: [ViewController.Person]
}
