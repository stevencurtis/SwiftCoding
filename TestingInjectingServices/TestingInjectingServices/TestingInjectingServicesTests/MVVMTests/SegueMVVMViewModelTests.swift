//
//  SegueMVVMViewModelTests.swift
//  TestingInjectingServicesTests
//
//  Created by Steven Curtis on 05/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
@testable import TestingInjectingServices


class SegueMVVMViewModelTests: XCTestCase {

    var sut: SegueMVVMViewModel?
    var serviceModel : ServiceModel?
    var mvvmView: SegueMVVMView?

    override func setUp() {
        mvvmView = SegueMVVMView( frame: CGRect (x: 0, y: 0, width: 100, height: 100) )
    }

    func testMVVMModel() {
        sut = SegueMVVMViewModel(model: ServiceModel(serviceName: "ServiceModelInTest"))
        XCTAssertEqual("ServiceModelInTest", sut?.serviceModel?.serviceName )
    }

    func testMVVMModelWithTestLabel() {
        sut = SegueMVVMViewModel(model: ServiceModel(serviceName: "ServiceModelPassedToLab"))
        sut?.configure(mvvmView!)
        XCTAssertEqual("ServiceModelPassedToLab", mvvmView!.titleLabel.text )
    }

}
