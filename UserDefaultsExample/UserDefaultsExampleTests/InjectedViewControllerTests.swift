//
//  InjectedViewControllerTests.swift
//  UserDefaultsExampleTests
//
//  Created by Steven Curtis on 30/09/2020.
//

import XCTest
@testable import UserDefaultsExample

class InjectedViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserFalseDefault() {
        let databaseName = "testing"
        let userDefaults = UserDefaults(suiteName: databaseName)!
        userDefaults.removePersistentDomain(forName: "testing")
        
        let viewController = InjectedViewController(userDefaults: userDefaults)
        let _ = viewController.view
        
        XCTAssertEqual(viewController.isPreviouslyLaunched, false)
    }
    
    func testUserTrueDefault() {
        let databaseName = "testing"
        let userDefaults = UserDefaults(suiteName: databaseName)!
        userDefaults.removePersistentDomain(forName: "testing")
        userDefaults.setValue(true, forKey: "previouslyLaunched")
        
        let viewController = InjectedViewController(userDefaults: userDefaults)
        let _ = viewController.view
        
        XCTAssertEqual(viewController.isPreviouslyLaunched, true)
    }

}
