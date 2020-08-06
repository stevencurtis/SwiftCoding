//
//  KeyChainManagerMock.swift
//  CombineURLSessionTests
//
//  Created by Steven Curtis on 10/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import CombineURLSession

enum LastKeyChainOperation {
    case save
    case load
    case delete
}

class KeyChainManagerMock: KeychainManagerProtocol {
    var lastOp: LastKeyChainOperation?
    
    @discardableResult func save(key: String, data: Data) -> OSStatus {
        lastOp = .save
        return 0
    }
    
    func load(key: String) -> Data? {
        lastOp = .load
        return nil
    }
    
    func delete(key: String, data: Data) throws -> OSStatus {
        lastOp = .delete
        return 0
    }
    
    func delete(key: String) throws -> OSStatus {
        lastOp = .delete
        return 0
    }
    

}
