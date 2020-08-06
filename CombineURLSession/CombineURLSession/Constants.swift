//
//  Constants.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 10/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

var passwordLength = 0

enum RuntimeError: Error {
    case runtimeError(String)
}

enum KeyChainKeys: CaseIterable {
    static let accessToken = "access"
}

enum KeyChainOperations: String {
    case token
    
}
