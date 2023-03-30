//
//  MockUserDefaults.swift
//  UserDefaultsExampleTests
//
//  Created by Steven Curtis on 30/09/2020.
//

@testable import UserDefaultsExample
import Foundation

class MockUserDefaults: UserDefaultsProtocol {
    var shouldReturnBool = false
    func bool(forKey defaultName: String) -> Bool {
        return shouldReturnBool
    }
}
