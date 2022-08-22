//
//  ViewControllerTests.swift
//  LocalBundleTests
//
//  Created by Steven Curtis on 02/10/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

@testable import LocalBundle
import XCTest

class ViewControllerTests: XCTestCase {
    var sut: ViewController?
    override func setUp() {
        sut = ViewController()
    }
    
    func testInitialLabelValue() {
        // without method swizzling engaged we pull from the existing strings
        sut?.viewDidLoad()
        XCTAssertEqual(sut?.targetLabel.text, "Welcome Localizable.strings")
    }
    
    func testDownloaded() {
        // Strings from bundle
        sut?.viewDidLoad()
        MyLocalizer.swizzleMainBundle()
        XCTAssertEqual(
            sut?.targetLabel.text, "Welcome en.lproj in bundle")
    }

    func testBundle() {
        if let path = Bundle(for: type(of: self)).path(forResource: "BundleTesting.bundle", ofType: nil), let bundle = Bundle(path: path) {
            print (bundle)
        }
    }
}
