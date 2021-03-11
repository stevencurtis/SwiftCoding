//
//  SegueMVVMViewController.swift
//  TestingInjectingServicesTests
//
//  Created by Steven Curtis on 05/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
@testable import TestingInjectingServices


class SegueMVVMViewControllerTests: XCTestCase {

    var sut: SegueMVVMViewController?
    
    override func setUp() {
        sut = SegueMVVMViewController()
    }
    
    override func tearDown() {
    }
    
    func testMVVMMock() {
        let serviceManager = ServiceManagerMock()
        sut!.serviceManager = serviceManager
        XCTAssertEqual("MockServiceManager", sut?.serviceManager?.getServiceName() )
    }


    

}
