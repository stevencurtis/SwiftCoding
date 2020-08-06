//
//  Data - init to from.swift
//  KeychainImplementation
//
//  Created by Steven Curtis on 13/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

// MARK: - Encode and decode Swift's number types as Data Objects
extension Data {
    init<T>(from value: T) {
        var value = value
        var myData = Data()
        withUnsafePointer(to:&value, { (ptr: UnsafePointer<T>) -> Void in
            myData = Data( buffer: UnsafeBufferPointer(start: ptr, count: 1))
        })
        self.init(myData)
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
