//
//  Person.swift
//  StaticFunctionClass
//
//  Created by Steven Curtis on 30/12/2021.
//

import Foundation

struct Person {
    let name: String
    let age: Int
    
    func formattedPerson() -> String {
        return "\(name) is \(age) years old"
    }
}
