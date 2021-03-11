//
//  MVCViewControllerUITests.swift
//  TestingInjectingServicesUITests
//
//  Created by Steven Curtis on 06/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest

class MVCViewControllerUITests: XCTestCase {
    
    let app = XCUIApplication()


    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
    }

    func testAllScreens() {

        
        let app = XCUIApplication()
        let element3 = app.otherElements.containing(.navigationBar, identifier:"TestingInjectingServices.MenuView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let element = element3.children(matching: .other).element(boundBy: 0)
        element.children(matching: .other).element(boundBy: 0).buttons["GO"].tap()

        let backButton = app.navigationBars["TestingInjectingServices.SegueMVCView"].buttons["Back"]
        backButton.tap()
        element.children(matching: .other).element(boundBy: 1).buttons["GO"].tap()
        backButton.tap()
        element.children(matching: .other).element(boundBy: 2).buttons["GO"].tap()
        backButton.tap()

        let element2 = element3.children(matching: .other).element(boundBy: 1)
        element2.children(matching: .other).element(boundBy: 0).buttons["GO"].tap()

        let backButton2 = app.navigationBars["TestingInjectingServices.SegueMVVMView"].buttons["Back"]
        backButton2.tap()
        element2.children(matching: .other).element(boundBy: 1).buttons["GO"].tap()
        backButton2.tap()
        element2.children(matching: .other).element(boundBy: 2).buttons["GO"].tap()
        backButton2.tap()
        
                
    }

}
