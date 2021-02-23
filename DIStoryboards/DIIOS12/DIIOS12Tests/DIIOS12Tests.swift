//
//  DIIOS12Tests.swift
//  DIIOS12Tests
//
//  Created by Steven Curtis on 25/09/2020.
//

import XCTest
@testable import DIIOS12

class DIIOS12Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let injectedFactory = MockFactory()
        let viewController = ViewController()
        viewController.viewControllerFactory = injectedFactory
        viewController.traverseToInfo()
        XCTAssertEqual((injectedFactory as MockFactory).didCreateInfo, true)
    }
}
