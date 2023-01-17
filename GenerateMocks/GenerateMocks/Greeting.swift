//
//  Greeting.swift
//  GenerateMocks
//
//  Created by Steven Curtis on 28/12/2020.
//

import Foundation

// sourcery: AutoMockable
protocol GreetingProtocol {
    func sayHello() -> String
}

struct Greeting: GreetingProtocol {
    func sayHello() -> String {
         return "Hello \(name)"
    }
    var name: String
}
