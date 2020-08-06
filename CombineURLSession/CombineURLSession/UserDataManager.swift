//
//  UserDataManager.swift
//  Starling-Tech-Test
//
//  Created by Steven Curtis on 15/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

protocol UserDataManagerProtocol {
    var token: String? { get set }
    func deleteToken()
}

class UserDataManager: UserDataManagerProtocol {
    private let keychain: KeychainManagerProtocol
    
    // default to using the KeyChainManager and KeyChain
    init(keychain: KeychainManagerProtocol = KeyChainManager(KeyChain())) {
        self.keychain = keychain
    }
    
    func deleteToken() {
        _ = try? keychain.delete(key: KeyChainKeys.accessToken)
    }

    var token: String? {
        get {
            if let receivedData = keychain.load(key: KeyChainKeys.accessToken) {
                let accessTokenData = String(decoding: receivedData, as: UTF8.self)
                return accessTokenData
            }
            return nil
        }
        set {
            guard let newValue = newValue else {return}
            if let accessTokenData = newValue.data(using: .utf8) {
                self.keychain.save(key: KeyChainKeys.accessToken, data: accessTokenData)
            }
        }
    }

}
