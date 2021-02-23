//
//  MockFactory.swift
//  DIIOS12Tests
//
//  Created by Steven Curtis on 25/09/2020.
//

import UIKit
@testable import DIIOS12


class MockFactory: ViewControllerFactoryProtocol{
    var didCreateInfo = false
    func createInfoViewControllerWith(item: String) -> UIViewController {
        didCreateInfo = true
        return UIViewController()
    }
}

