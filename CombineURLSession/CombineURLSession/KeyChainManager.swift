//
//  KeyChainManager.swift
//  KeychainImplementation
//
//  Created by Steven Curtis on 14/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

enum KeychainError: Error {
    case itemMissing
}

public protocol KeychainManagerProtocol {
    @discardableResult func save(key: String, data: Data) -> OSStatus
    func load(key: String) -> Data?
    func delete(key: String, data: Data) throws -> OSStatus
    func delete(key: String) throws -> OSStatus
}

class KeyChainManager: KeychainManagerProtocol {
    
    /// The keychain instance
    private let keychain: KeyChainProtocol
    
    /// The initializer that introduces the keychain instance
    ///
    /// - Parameter keychain: Any keychain that conforms to the keychain protocol
    init(_ keychain: KeyChainProtocol ) {
        self.keychain = keychain
    }
    
    func delete(key: String) throws -> OSStatus {
        if let data = load(key: key) {
            let query = createSaveQuery(key: key, data: data )
            return keychain.delete(query)
        }
        throw KeychainError.itemMissing
    }
    
    func delete(key: String, data: Data) throws -> OSStatus {
        let query = createSaveQuery(key: key, data: Data.init() )
        return keychain.delete(query)
    }
    
    @discardableResult func save(key: String, data: Data) -> OSStatus {
        let query = createSaveQuery(key: key, data: data)
        // both are OK here
        return keychain.add(query)
    }
    
    func load(key: String) -> Data? {
        let query = createSearchQuery(key: key)
        return keychain.search(query)
    }
    
    func createSaveQuery(key: String, data: Data) -> [String: Any] {
        // Build the query to be used in Saving Data
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ]
            as [String : Any]
        return query
    }
    
    func createSearchQuery(key: String) -> [String: Any] {
        // Build the query to be used in Loading Data
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ]
            as [String : Any]
        return query
    }
}
