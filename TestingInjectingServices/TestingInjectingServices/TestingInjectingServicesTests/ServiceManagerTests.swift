//
//  ServiceManagertests.swift
//  TestingInjectingServicesTests
//
//  Created by Steven Curtis on 06/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
@testable import TestingInjectingServices

class ServiceManagerTests: XCTestCase {

    var sut: ServiceManager?
    
    override func setUp() {
        sut = ServiceManager()
    }
    
    func testServiceManager() {
        XCTAssertEqual("MainServiceManager", sut?.getServiceName() )
    }

}
