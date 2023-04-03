//
//  JSONBasicsTests.swift
//  JSONBasicsTests
//
//  Created by Steven Curtis on 28/03/2023.
//

import XCTest
@testable import JSONBasics

final class JSONBasicsTests: XCTestCase {
    func testDecodeJSONFile() {
        let bundle = Bundle(for: Self.self)
        let path = bundle.path(forResource: "Person", ofType: "json")!
        let content = try! String(contentsOfFile: path, encoding: .utf8)
        
        let decoder = JSONDecoder()
        let data = content.data(using: .utf8)!
        let model = try! decoder.decode(PersonResponse.self, from: data)
        
        let expected: [ViewController.Person] = [
            .test(name: "Robert Paxman", age: 26, email: "rb@hotmail.com"),
                .test(name: "Ahmed Paterl", age: 51, email: "ahmed@yahoo.com"),
                .test(name: "Leanne Truslow", age: 31, email: "Thetrus@gmail.com"),
                .test(name: "Faith Tecilla", age: 16, email: "faith1995@gmail.com"),
                .test(name: "Maura Kayas", age: 12, email: "MKayas@AOL.com")
        ]
        XCTAssertEqual(model.customers, expected)
    }
    
    func testDecodeJSONFileUsingHelpers() {
        let response: PersonResponse = .json(contentsOfFile: "Person", bundle: Bundle(for: Self.self))
        let expected: [ViewController.Person] = [
            .test(name: "Robert Paxman", age: 26, email: "rb@hotmail.com"),
                .test(name: "Ahmed Paterl", age: 51, email: "ahmed@yahoo.com"),
                .test(name: "Leanne Truslow", age: 31, email: "Thetrus@gmail.com"),
                .test(name: "Faith Tecilla", age: 16, email: "faith1995@gmail.com"),
                .test(name: "Maura Kayas", age: 12, email: "MKayas@AOL.com")
        ]
        XCTAssertEqual(response.customers, expected)
    }
}
