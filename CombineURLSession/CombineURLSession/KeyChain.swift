//
//  KeyChain.swift
//  KeychainImplementation
//
//  Created by Steven Curtis on 12/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

public protocol KeyChainProtocol {
    func add(_ query: [String: Any]) -> OSStatus
    func search(_ query: [String: Any]) -> Data?
    func delete(_ query: [String: Any]) -> OSStatus
}

class KeyChain: KeyChainProtocol {

    
    /// Fatch data from the KeyChain
    ///
    /// - Parameter query: A dictionary containing the query
    /// - Returns: The data returned as an optional type
    func search(_ query: [String : Any]) -> Data? {
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    /// Add data to the KeyChain, making sure that the entry does not already exist
    ///
    /// - Parameter query: A dictionary containing the query
    /// - Returns: The Security Framework Result Code
    func add(_ query: [String : Any]) -> OSStatus {
        _ = delete(query)
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    /// Remove data from the Keychain
    ///
    /// - Parameter query: A dictionary containing the query, including data
    /// - Returns: The Security Framework Result Codes
    func delete(_ query: [String: Any]) -> OSStatus {
        return SecItemDelete(query as CFDictionary)
    }

}
