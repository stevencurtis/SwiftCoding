//
//  InjectedMockViewControllerTests.swift
//  UserDefaultsExampleTests
//
//  Created by Steven Curtis on 30/09/2020.
//

import XCTest
@testable import UserDefaultsExample

class InjectedMockViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserTrueDefault() {
        let userDefaults = MockUserDefaults()
        userDefaults.shouldReturnBool = true
        let viewController = InjectedMockViewController(userDefaults: userDefaults)
        let _ = viewController.view
        
        XCTAssertEqual(viewController.isPreviouslyLaunched, true)
    }
    
    func testUserFalseDefault() {
        let userDefaults = MockUserDefaults()
        userDefaults.shouldReturnBool = false
        let viewController = InjectedMockViewController(userDefaults: userDefaults)
        let _ = viewController.view
        
        XCTAssertEqual(viewController.isPreviouslyLaunched, false)
    }

}
