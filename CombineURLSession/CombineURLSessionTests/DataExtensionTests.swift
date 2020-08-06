//
//  DataExtensionTests.swift
//  KeychainImplementationTests
//
//  Created by Steven Curtis on 13/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import CombineURLSession

class DataExtensionTests: XCTestCase {
    
    func testFrom() {
        let data = Data(from: 14)
        let array : [UInt8] = [0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ]
        let dataFromArray = Data(bytes: array, count: 8)
        XCTAssertEqual(data, dataFromArray)
    }

    func testFromZero() {
        let integer: Int = 0
        let data = Data(from: integer)
        let array : [UInt8] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ]
        let dataFromArray = Data(bytes: array, count: 8)
        XCTAssertEqual(data, dataFromArray)
    }
    
    func testFromNegative() {
        let integer: Int = -10
        let data = Data(from: integer)
        let array : [UInt8] = [0xF6, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ]
        let dataFromArray = Data(bytes: array, count: 8)
        XCTAssertEqual(data, dataFromArray)
    }
    
    func testTo() {
        let array : [UInt8] = [0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ]
        let dataFromArray = Data(bytes: array, count: 8)
        let data = dataFromArray.to(type: Int.self)
        XCTAssertEqual(14, data)
    }

}
