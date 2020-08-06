//
//  UserDataManagerTests.swift
//  CombineURLSessionTests
//
//  Created by Steven Curtis on 10/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import CombineURLSession


class UserDataManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // check if the UserDataManager is asking the KeyChain to save, load etc. when asked

    func testUserDataManagerSave() {
        let kc = KeyChainManagerMock()
        let udm = UserDataManager(keychain: kc)
        udm.token = "test"
        XCTAssertEqual(kc.lastOp, .save)
    }
    
    func testUserDataManagerLoad() {
        let kc = KeyChainManagerMock()
        let udm = UserDataManager(keychain: kc)
        let _ = udm.token
        XCTAssertEqual(kc.lastOp, .load)
    }
    
    func testUserDataManagerDelete() {
        let kc = KeyChainManagerMock()
        let udm = UserDataManager(keychain: kc)
        udm.deleteToken()
        XCTAssertEqual(kc.lastOp, .delete)
    }
}
