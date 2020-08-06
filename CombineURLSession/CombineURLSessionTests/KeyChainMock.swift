//
//  KeyChainMock.swift
//  KeychainImplementationTests
//
//  Created by Steven Curtis on 14/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import CombineURLSession

class KeyChainMock: KeyChainProtocol {
    var element: [String: Any] = [:]
    var updated: Bool = false
    /// Search for elements in the local elements Array
    func search(_ query: [String : Any]) -> Data? {
        if let key = query["acct"], let keystring = key as? String, let dta = element[keystring], let data = dta as? Data {
           return data
        }
        return nil
    }
    
    /// Update elements in the local elements Array
    func update(_ query: [String : Any], with attributes: [String : Any]) -> OSStatus {
        self.updated = true
        return 0
    }
    
    /// Delete elements to the local elements Array
    func delete(_ query: [String : Any]) -> OSStatus {
        if let key = query["acct"], let keystring = key as? String {
            element[keystring] = nil
        }
        return 0
    }
    
    
    /// Add elements to the local elements Arraay
    func add(_ query: [String : Any]) -> OSStatus {
        if let anykey = (query["acct"]), let value = (query["v_Data"]), let key = anykey as? String {
            element[key] = value
            return 0
        }
        return 50
    }

}
