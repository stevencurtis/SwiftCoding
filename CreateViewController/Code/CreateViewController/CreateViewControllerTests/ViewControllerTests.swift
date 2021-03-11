//
//  ViewControllerTests.swift
//  CreateViewControllerTests
//
//  Created by Steven Curtis on 15/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
@testable import CreateViewController

class ViewControllerTests: XCTestCase {
    

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testViewController(){
        let viewController = ViewController(source: "tests")
        XCTAssertEqual(viewController.source, "tests")
    }
    
    func testViewControllerNib(){
        let vc = (UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as! ViewController)
        UIApplication.shared.keyWindow?.rootViewController = vc
        XCTAssertEqual( vc.centreLabel.text, "View Controller created from: storyboard")
    }

}
