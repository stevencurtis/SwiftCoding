//
//  SegueMVCViewControllerTests.swift
//  TestingInjectingServicesTests
//
//  Created by Steven Curtis on 05/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
@testable import TestingInjectingServices


class SegueMVCViewControllerTests: XCTestCase {
    var sut: SegueMVCViewController?
    
    override func setUp() {
        sut = SegueMVCViewController()
    }

    override func tearDown() {
    }
    
    func testMVCMock() {
        let service = ServiceManagerMock()
        sut?.serviceManager = service
        XCTAssertEqual("MockServiceManager", sut?.serviceManager?.getServiceName())
    }
    
//    func testCrash() {
//        let service = ServiceManagerMock()
//        segueVC?.serviceManager = service
//        XCTAssertEqual("MockServiceManager", segueVC?.serviceLabel.text)
//    }

    func testMVCRefactored() {
        let service = ServiceManagerMock()
        sut?.serviceManager = service
        XCTAssertEqual("MockServiceManager", sut?.displayText)
    }
    

}
